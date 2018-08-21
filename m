Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35939 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeHUWaj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Aug 2018 18:30:39 -0400
Received: by mail-io0-f172.google.com with SMTP id m4-v6so16313622iop.3
        for <linux-block@vger.kernel.org>; Tue, 21 Aug 2018 12:09:16 -0700 (PDT)
MIME-Version: 1.0
From: Kashyap Desai <kashyap.desai@broadcom.com>
Date: Tue, 21 Aug 2018 13:09:15 -0600
Message-ID: <CAHsXFKEXk4VhgveRKkHYP9gDJt8dAdrqBrWAA70B-UqjdkAzTg@mail.gmail.com>
Subject: [RFC 1/1] megaraid_sas : IRQ polling using threaded interrupt
To: linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Peter Rivera <peter.rivera@broadcom.com>,
        Steve Hagan <steve.hagan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Create Threaded ISR if possible.  Driver will do interrupt polling if
work load is high based on host busy (or it can be some other
trigger.).


Signed-off-by: Kashyap Desai < kashyap.desai@broadcom.com>
---


diff --git a/drivers/scsi/megaraid/megaraid_sas.h
b/drivers/scsi/megaraid/megaraid_sas.h
index 75dc25f..6817b51 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2291,6 +2291,7 @@ struct megasas_instance {
     u8 adapter_type;
     bool consistent_mask_64bit;
     bool support_nvme_passthru;
+    bool use_threaded_interrupts;
 };
 struct MR_LD_VF_MAP {
     u32 size;
@@ -2534,6 +2535,7 @@ void megasas_return_mfi_mpt_pthr(struct
megasas_instance *instance,
 int megasas_reset_fusion(struct Scsi_Host *shost, int reason);
 int megasas_task_abort_fusion(struct scsi_cmnd *scmd);
 int megasas_reset_target_fusion(struct scsi_cmnd *scmd);
+irqreturn_t megasas_irq_check_fusion(int irq, void *devp);
 u32 mega_mod64(u64 dividend, u32 divisor);
 int megasas_alloc_fusion_context(struct megasas_instance *instance);
 void megasas_free_fusion_context(struct megasas_instance *instance);
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c
b/drivers/scsi/megaraid/megaraid_sas_base.c
index 71d9757..aa0fb53 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5029,6 +5029,7 @@ int megasas_set_crash_dump_params(struct
megasas_instance *instance,
     struct pci_dev *pdev;

     pdev = instance->pdev;
+    instance->use_threaded_interrupts = 0;
     instance->irq_context[0].instance = instance;
     instance->irq_context[0].MSIxIndex = 0;
     if (request_irq(pci_irq_vector(pdev, 0),
@@ -5054,7 +5055,7 @@ int megasas_set_crash_dump_params(struct
megasas_instance *instance,
 static int
 megasas_setup_irqs_msix(struct megasas_instance *instance, u8 is_probe)
 {
-    int i, j;
+    int i, j, cpu, ret;
     struct pci_dev *pdev;

     pdev = instance->pdev;
@@ -5063,9 +5064,18 @@ int megasas_set_crash_dump_params(struct
megasas_instance *instance,
     for (i = 0; i < instance->msix_vectors; i++) {
         instance->irq_context[i].instance = instance;
         instance->irq_context[i].MSIxIndex = i;
-        if (request_irq(pci_irq_vector(pdev, i),
-            instance->instancet->service_isr, 0, "megasas",
-            &instance->irq_context[i])) {
+         if (instance->use_threaded_interrupts)
+             ret = request_threaded_irq(pci_irq_vector(pdev, i),
+                 megasas_irq_check_fusion,
+                 instance->instancet->service_isr, 0, "megasas",
+                 &instance->irq_context[i]);
+
+         else
+             ret = request_irq(pci_irq_vector(pdev, i),
+                 instance->instancet->service_isr, 0, "megasas",
+                 &instance->irq_context[i]);
+
+         if (ret) {
             dev_err(&instance->pdev->dev,
                 "Failed to register IRQ for vector %d.\n", i);
             for (j = 0; j < i; j++)
@@ -5326,6 +5336,8 @@ static int megasas_init_fw(struct
megasas_instance *instance)
                     instance->msix_vectors);
         } else /* MFI adapters */
             instance->msix_vectors = 1;
+
+        instance->use_threaded_interrupts = 1;
         /* Don't bother allocating more MSI-X vectors than cpus */
         instance->msix_vectors = min(instance->msix_vectors,
                          (unsigned int)num_online_cpus());
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c
b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 94c23ad..4d228f6 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3525,7 +3525,7 @@ irqreturn_t megasas_isr_fusion(int irq, void *devp)
 {
     struct megasas_irq_context *irq_context = devp;
     struct megasas_instance *instance = irq_context->instance;
-    u32 mfiStatus, fw_state, dma_state;
+    u32 mfiStatus, fw_state, dma_state, i;

     if (instance->mask_interrupts)
         return IRQ_NONE;
@@ -3542,33 +3542,39 @@ irqreturn_t megasas_isr_fusion(int irq, void *devp)
         return IRQ_HANDLED;
     }

-    if (!complete_cmd_fusion(instance, irq_context->MSIxIndex)) {
-        instance->instancet->clear_intr(instance->reg_set);
-        /* If we didn't complete any commands, check for FW fault */
-        fw_state = instance->instancet->read_fw_status_reg(
-            instance->reg_set) & MFI_STATE_MASK;
-        dma_state = instance->instancet->read_fw_status_reg
-            (instance->reg_set) & MFI_STATE_DMADONE;
-        if (instance->crash_dump_drv_support &&
-            instance->crash_dump_app_support) {
-            /* Start collecting crash, if DMA bit is done */
-            if ((fw_state == MFI_STATE_FAULT) && dma_state)
-                schedule_work(&instance->crash_init);
-            else if (fw_state == MFI_STATE_FAULT) {
-                if (instance->unload == 0)
-                    schedule_work(&instance->work_init);
-            }
-        } else if (fw_state == MFI_STATE_FAULT) {
-            dev_warn(&instance->pdev->dev, "Iop2SysDoorbellInt"
-                   "for scsi%d\n", instance->host->host_no);
-            if (instance->unload == 0)
-                schedule_work(&instance->work_init);
+    if (instance->use_threaded_interrupts &&
+        atomic_read(&instance->fw_outstanding) > 1024) {
+        disable_irq_nosync(pci_irq_vector(instance->pdev,
irq_context->MSIxIndex));
+        for (i = 0; i < 100; i++) {
+          complete_cmd_fusion(instance, irq_context->MSIxIndex);
+          usleep_range(1 , 11);
         }
+        enable_irq(pci_irq_vector(instance->pdev, irq_context->MSIxIndex));
+        return IRQ_HANDLED;
+    } else {
+        return complete_cmd_fusion(instance, irq_context->MSIxIndex)
? IRQ_HANDLED : IRQ_NONE;
     }

     return IRQ_HANDLED;
 }

+
+/*
+ * megasas_irq_check_fusion:
+ * For threaded interrupts, this handler will be called
+ * and its job is to invoke core ISR- megasas_isr_fusion.
+ */
+irqreturn_t megasas_irq_check_fusion(int irq, void *devp)
+{
+    struct megasas_irq_context *irq_context = devp;
+    struct megasas_instance *instance = irq_context->instance;
+
+    if (instance->mask_interrupts)
+        return IRQ_NONE;
+
+    return IRQ_WAKE_THREAD;
+}
+
 /**
  * build_mpt_mfi_pass_thru - builds a cmd fo MFI Pass thru
  * @instance:            Adapter soft state
