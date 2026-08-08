#  Каталог доменных событий

## Patient Management
|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|PatientRegistered|В системе зарегистрирован новый пациент|Patient Management|Clinical Management, FinTech Operations,Billing, Notifications, Analytics & Reporting,Audit|{ patientId, fullName, dateOfBirth, insuranceNumber, contactPhone, registrationDate }|
|PatientProfileUpdated|Изменены персональные данные пациента|Patient Management|Clinical Management, FinTech Operations,Billing, Notifications, Analytics & Reporting,Audit|{ patientId, updatedFields, changeType, timestamp }|
|InsuranceVerified|Страховой полис пациента проверен и подтверждё|Patient Management|Clinical Management, Billing, FinTech Operations|{ patientId, insuranceNumber, validityStatus, expiryDate, timestamp }|
|PatientDeactivated|Пациент деактивирован|Patient Management|Clinical Management, FinTech Operations, Notifications, Audit|{ patientId, deactivationReason, timestamp }|

## Clinical Management

|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|AppointmentScheduled|Пациент записан на приём к врачу|Clinical Management|Notifications, Analytics & Reporting, Audit|{ appointmentId, patientId, doctorId, clinicId, datetime, specialty }|
|AppointmentCancelled|Запись отменена|Clinical Management|Notifications, Analytics & Reporting, Audit|{ appointmentId, patientId, doctorId, cancellationReason, timestamp }|
|MedicalRecordCreated|Создана электронная медицинская карта для пациента|Clinical Management|Analytics, Audit|{ recordId, patientId, createdBy, createdAt }|
|DiagnosisAdded|Врач поставил диагноз|Clinical Management|AI Diagnostics, Partner Management (Pharma), Analytics & Reporting, Audit|{ recordId, patientId, diagnosisCode, description, doctorId, timestamp }|
|PrescriptionIssued|Врач выписал рецепт|Clinical Management|Inventory & Logistics, Partner Management (Pharma), Notifications , Analytics & Reporting, Audit|{ prescriptionId, patientId, drugId, dosage, quantity, doctorId, issueDate, expiryDate }|
|PrescriptionFulfilled|Пациент получил лекарство по рецепту|Clinical Management|Inventory & Logistics, Partner Management (Pharma), Analytics & Reporting|{ prescriptionId, patientId, drugId, quantity, pharmacyId, fulfillmentDate }|
|ClinicalNoteAppended|В карту добавлена клиническая заметка|Clinical Management|AI Diagnostics, Analytics & Reporting
, Audit|{ recordId, patientId, note, authorId, timestamp, noteType }|
|LabResultUploaded|Загружены результаты лабораторных исследований|Clinical Management, AI Diagnostics, Analytics & Reporting, Audit| { resultId, patientId, testType, resultData, uploadedBy, timestamp }|

## AI Diagnostics

|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|AIRequestSubmitted|Отправлен запрос на ИИ-анализ медицинских данных|AI Diagnostics, Notifications, Analytics & Reporting, Audit|{ requestId, patientId, dataId, modelType, submittedAt }|
|AIRequestCompleted|ИИ-анализ завершён|AI Diagnostics, Clinical Management, Notifications, Analytics & Reporting, Audit|{ requestId, patientId, resultSummary, confidenceScore, modelVersion, completedAt }|
|AIRequestFailed|ИИ-анализ не удался|AI Diagnostics, Clinical Management, Notifications, Analytics & Reporting, Audit|{ requestId, patientId, errorCode, errorMessage, timestamp }|
|AIDiagnosisSuggested|ИИ предложил возможный диагноз на основе анализа данных|AI Diagnostics, Clinical Management, Notifications, Analytics & Reporting|{ suggestionId, patientId, diagnosisCode, confidenceScore, modelVersion, suggestedAt }|
|AIFeedbackReceived|Врач оставил обратную связь по качеству ИИ-рекомендации|AI Diagnostics|Analytics & Reporting|{ suggestionId, doctorId, feedbackType, accuracyRating, timestamp }|

## FinTech Operations

|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|AccountCreated|Открыт финансовый счёт пациента для оплаты услуг|FinTech Operations|Billing, Analytics & Reporting, Audit|{ accountId, patientId, accountType, currency, createdAt }|
|CreditCreated|Оформлена заявка на кредит|FinTech Operations|Billing, Notifications, Analytics & Reporting, Audit|{ CreditId, patientId, amount, term, interestRate, createdAt }|
|CreditApproved|Кредит одобрен|FinTech Operations	, Notifications, Analytics & Reporting, Audit|{ CreditId, patientId, amount, approvedAt, approvedBy }|
|CreditRejected|Кредит отклонён|FinTech Operations|Notifications, Analytics & Reporting, Audit|{ CreditId, patientId, rejectionReason, rejectedAt }|
|PaymentMade|Совершён платёж|FinTech Operations|Billing, Notifications, Analytics & Reporting, Audit|{ transactionId, invoiceId, patientId, amount, paymentMethod, timestamp }|
|PaymentFailed|Платёж не удался|FinTech Operations|Notifications, Analytics & Reporting, Audit|{ transactionId, invoiceId, patientId, amount, failureReason, timestamp }|
|RefundProcessed|Оформлен возврат средств|FinTech Operations|Billing, Notifications, Analytics & Reporting, Audit|{ refundId, transactionId, patientId, amount, refundReason, timestamp }|

## Billing

|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|InvoiceGenerated|Сформирован счёт за медицинские услуги|Billing|FinTech Operations, Notifications, Analytics & Reporting, Audit|{ invoiceId, patientId, amount, services, dueDate, status, timestamp }|
|InvoicePaid|Счёт оплачен|Billing|FinTech Operations, Analytics & Reporting, Audit|{ invoiceId, patientId, amount, paidAt, paymentMethod }|
|InvoiceOverdue|Счёт просрочен|Billing|Notifications, FinTech Operations, Analytics & Reporting|{ invoiceId, patientId, amount, overdueDays, timestamp }|
|SettlementCompleted|Завершён период взаиморасчётов с клиникой или партнёром|Billing|Analytics & Reporting, Audit|{ settlementId, clinicId, period, totalAmount, status, timestamp }|

## Inventory & Logistics

|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|StockUpdated|Изменился остаток лекарства/материала на складе|Inventory & Logistics|Clinical Management, Analytics & Reporting, Audit|{ drugId, quantityChange, warehouseId, newStock, timestamp }|
|StockLow|Остаток на складе ниже порогового значения|Inventory & Logistics|Partner Management (Pharma), Notifications, Analytics & Reporting|{ drugId, currentStock, threshold, warehouseId, timestamp }|
|SupplyOrderCreated|Создан заказ на поставку лекарств/материалов|Inventory & Logistics|Partner Management (Pharma), Analytics & Reporting, Audit|{ orderId, drugId, quantity, supplierId, orderDate, status }|
|SupplyOrderReceived|Поставка получена на склад|Inventory & Logistics|Analytics & Reporting, Audit|{ orderId, drugId, quantity, receivedDate, status }|

## Partner Management

|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|PartnerOnboarded|Новый партнёр зарегистрирован в системе|Partner Management|Notifications, Analytics & Reporting, Audit|{ partnerId, partnerType, name, legalInfo, onboardedAt }|
|DrugAvailabilityResponse|Фармацевтическая компания подтвердила наличие лекарства|Partner Management (Pharma)|Clinical Management, Inventory & Logistics|{ drugId, pharmacyId, quantity, price, availabilityStatus, timestamp }|
|DeviceDataReceived|Получены данные с медицинского устройства|Partner Management (Devices)|Clinical Management, AI Diagnostics, Analytics & Reporting, Audit|{ deviceId, patientId, dataType, dataPayload, timestamp }|
|DeviceStatusChanged|Изменился статус оборудования|Partner Management (Devices)|Notifications, Inventory & Logistics, Analytics & Reporting|{ deviceId, deviceName, newStatus, changedAt }|

## Notifications

|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|NotificationSent|Уведомление отправлено|Notifications|Analytics & Reporting, Audit|{ notificationId, recipientId, channel, type, status, timestamp }|
|NotificationFailed|Уведомление не доставлено|Notifications	, Analytics & Reporting, Audit|{ notificationId, recipientId, channel, failureReason, timestamp }|
|FeedbackReceived|Получена обратная связь от пациента|Notifications|Clinical Management, Analytics & Reporting|{ feedbackId, patientId, feedbackType, rating, comment, timestamp }|
|AlertTriggered|Сработало критическое уведомление|Notifications|AIM, Analytics & Reporting, Audit|{ alertId, severity, source, message, triggeredAt, escalatedTo }|

## IAM

|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|UserAuthenticated|Пользователь успешно вошёл в систему|IAM|Audit|{ userId, timestamp, ipAddress, userAgent, success }|
|UserAuthorized|Проверка прав доступа пользователя к ресурсу|IAM|Audit|{ userId, resource, action, granted, timestamp }|
|RoleAssigned|Пользователю назначена новая роль|IAM|Notifications, Audit|{ userId, role, assignedBy, timestamp }|
|RoleRevoked|У пользователя отозвана роль|IAM|Notifications, Audit|{ userId, role, revokedBy, timestamp }|
|AccessAttemptDenied|Попытка несанкционированного доступа к ресурсу|IAM|Notifications, Audit|{ userId, resource, action, reason, timestamp }|

## Audit

|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|AuditRecorded|Зафиксировано действие пользователя с данными|Audit|Analytics & Reporting|{ auditId, userId, action, resource, data, timestamp }|
|ConsentGranted|Пациент дал согласие на обработку персональных данных|Audit|Clinical Management, Analytics & Reporting|{ patientId, consentType, grantedAt, expiresAt }|
|ConsentRevoked|Пациент отозвал согласие на обработку данных|Audit|Clinical Management, Analytics & Reporting|{ patientId, consentType, revokedAt }|
|ComplianceReportGenerated|Сформирован отчёт для регулятора|Audit|Notifications, Analytics & Reporting|{ reportId, reportType, period, generatedAt, summary }|
|IncidentReported|Зарегистрирован инцидент безопасности|Audit|Notifications, AIM, Analytics & Reporting|{ incidentId, severity, description, reportedAt, assignedTo }|

## Analytics & Reporting

|Событие|Семантика|Источник|Подписчики|Минимальный контракт|
|-|-|-|-|-|
|AnalyticsViewUpdated|Обновлена аналитическая витрина данных|Analytics & Reporting|Notifications|{ viewId, dataset, period, refreshTimestamp }|
|ReportGenerated|Сформирован аналитический отчёт по запросу пользователя|Analytics & Reporting|Notifications, Audit|{ reportId, type, parameters, generatedAt, status }|