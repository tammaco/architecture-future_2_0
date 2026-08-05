# Описание агрегатов

## Patient Management

### Aggregatе: Patient

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: персональные данные, контакты, страховые полисы. Не включает: медицинскую историю, финансовые счета|Номер полиса должен быть уникальным в системе, Дата рождения не может быть в будущем, Контактный телефон обязателен для взрослых пациентов|PatientId (UUID) — основной ключ, InsuranceNumber|PatientRegistered, PatientProfileUpdated, InsuranceVerified, PatientDeactivated|

### Aggregatе: InsurancePolicy

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: данные полиса, страховую компанию, срок действия, покрытие. Не включает: данные пациента (только ссылка)|Полис должен иметь срок действия (начало и конец), Полис не может быть просрочен при активном статусе, У пациента может быть только один активный ОМС-полис|InsurancePolicyId (UUID), PolicyNumber|InsurancePolicyAdded, InsurancePolicyUpdated, InsurancePolicyExpired|

## Clinical Management

### Aggregatе: MedicalRecord

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: записи осмотров, диагнозы, назначения, результаты исследований. Не включает: финансовую информацию, данные пациента (только ссылка)|Медицинская карта привязана к одному пациенту, Записи нельзя удалить, только аннулировать (отменить), Врач должен иметь право на внесение записей, История изменений должна сохраняться для аудита|RecordId (UUID), PatientId — внешний ключ|MedicalRecordCreated, DiagnosisAdded, ClinicalNoteAppended, LabResultUploaded|

### Aggregatе: Appointment

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: данные о записи, время, врача, статус, заметки. Не включает: медицинскую карту (только ссылка)|Время записи должно быть в рабочее время врача, Один слот не может быть занят двумя пациентами, Статус записи: Scheduled -> InProgress -> Completed / Cancelled|AppointmentId (UUID)|AppointmentScheduled, AppointmentCancelled, AppointmentCompleted|

### Aggregatе: Receipt

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: рецепт, дозировку, количество, инструкции. Не включает: информацию о наличии лекарств|Нельзя выписать рецепт на препарат, вызывающий аллергию (проверка по карте), Статус рецепта: Issued -> Active -> Fulfilled / Expired|PrescriptionId (UUID), PatientId + IssueDate|PrescriptionIssued, PrescriptionFulfilled, PrescriptionExpired|

## AI Diagnostics

### Aggregatе: AIRequest

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: запрос на анализ, входные данные, результат, версию модели. Не включает: медицинскую карту пациента (только ссылка)|Запрос должен содержать валидные медицинские данные, Результат должен содержать confidence score (0-1), Время выполнения запроса не может превышать 5 минут|RequestId (UUID)|AIRequestSubmitted, AIRequestCompleted, AIRequestFailed, AIDiagnosisSuggested|

### Aggregatе: AIModel

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: модель, версию, метрики, статус. Не включает: данные пациентов|Модель должна иметь уникальную версию, Точность модели не может быть ниже порогового значения (0.85), При обновлении модели предыдущая версия должна быть заархивирована|ModelId (UUID), ModelName + Version - UniqueKey|ModelDeployed, ModelUpdated, ModelArchived|

## FinTech Operations

### Aggregatе: Account

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: счёт, валюту, баланс, статус, транзакции. Не включает: кредиты|Активный счёт не может быть удалён, только заморожен, Все транзакции должны логироваться для аудита|AccountId (UUID), PatientId + AccountType| AccountCreated, AccountFrozen, AccountClosed|

### Aggregatе: Credit

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: кредитный договор, сумму, срок, проценты, график платежей. Не включает: платёжные транзакции|Сумма кредита не может превышать лимит, одобренный скорингом, График платежей обязателен и не может быть изменён после утверждения, Статус: Draft -> Submitted -> Approved / Rejected -> Active -> Closed|CreditCreated, CreditApproved, CreditRejected, CreditRepaid|

### Aggregatе: Payment

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: транзакцию, сумму, способ оплаты, статус. Не включает: счета (только ссылка)|Сумма платежа должна быть положительной, Платёж не может быть обработан без подтверждения, Статус: Initiated -> Processing -> Completed / Failed / Refunded, Каждый платёж должен иметь уникальный внешний ID (от шлюза)|PaymentId (UUID), TransactionId|PaymentMade, PaymentFailed, RefundProcessed|

## Billing

### Aggregatе: Invoice

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: счёт, услуги, суммы, сроки, статус. Не включает: платежи (только ссылка)|Счёт должен содержать минимум одну услугу, Сумма счёта = сумма всех услуг, Счёт может быть оплачен только один раз, Статус: Draft -> Issued -> Paid / Overdue / Cancelled|InvoiceId (UUID), InvoiceNumber - UniqueKey|InvoiceGenerated, InvoicePaid, InvoiceOverdue, InvoiceCancelled|

### Aggregatе: Settlement

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: взаиморасчёты с партнёрами, период, суммы. Не включает: отдельные счета|Сумма должна соответствовать сумме всех счетов за период, Взаиморасчёты должны быть подтверждены обеими сторонами|SettlementId (UUID)|SettlementCompleted, SettlementDisputed|

## Inventory & Logistics

### Aggregatе: Stock

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: лекарства, материалы, количество, сроки годности. Не включает: заказы|Количество не может быть отрицательным, Лекарства с истекшим сроком годности должны быть списаны, У каждого препарата должна быть уникальная серия для отслеживания|StockId (UUID), DrugId + WarehouseId + BatchNumber|StockUpdated, StockLow, StockExpired|

### Aggregatе: SupplyOrder

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: заказ, поставщика, позиции, статус. Не включает: конкретные остатки|аказ должен содержать минимум одну позицию, Статус: Draft -> Sent -> Confirmed -> Shipped -> Received / Cancelled, Количество в заказе не может быть равно нулю, Заказ не может быть изменён после подтверждения|OrderId (UUID), OrderNumber|SupplyOrderCreated, SupplyOrderReceived, SupplyOrderCancelled|

### Aggregatе: Equipment

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: оборудование, серийный номер, статус, ТО|У оборудования должен быть уникальный серийный номер, Статус: Active -> Maintenance -> Broken -> Retired|EquipmentId (UUID), SerialNumber|EquipmentRegistered, EquipmentMaintenanceDue, EquipmentStatusChanged|

## Partner Management 

### Aggregatе: Partner

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: партнёра, тип, контракты, статус|Тип партнёра: Pharma, DeviceManufacturer, Insurance, Clinic, У партнёра может быть несколько контрактов, Статус: Onboarding -> Active -> Suspended -> Terminated|PartnerId (UUID)|PartnerOnboarded, PartnerActivated, PartnerSuspended|

# IAM

### Aggregatе: User

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: пользователя, роли, права доступа. Не включает: персональные данные пациента|У пользователя должен быть уникальный логин, Пароль должен соответствовать политике безопасности, У пользователя должна быть минимум одна роль|UserId (UUID), Login|UserAuthenticated, UserAuthorized, RoleAssigned, RoleRevoked, AccessAttemptDenied|

### Aggregatе: Role

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: роль, права, описание. Не включает: конкретных пользователей|Роль должна иметь уникальное имя, Роль не может быть удалена, если у неё есть активные пользователи, Права роли должны быть явно определены|RoleId (UUID), RoleName|RoleCreated, RoleUpdated, RoleArchived|

## Audit 

### Aggregatе: AuditLog

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: действие, пользователь, ресурс, данные, время|Лог не может быть изменён после записи (WORM), Лог должен содержать идентификатор пользователя|AuditId (UUID), Timestamp + UserId|AuditRecorded|

### Aggregatе: Consent

|Границы|Инварианты|Ключи|События|
|-|-|-|-|
|Включает: согласие на обработку данных, тип, сроки|Согласие должно иметь срок действия, Согласие может быть отозвано в любой момент, Без согласия доступ к данным запрещён|ConsentId (UUID)|ConsentGranted, ConsentRevoked, ConsentExpired|