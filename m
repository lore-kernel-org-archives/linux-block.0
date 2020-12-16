Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0274CC35270
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDE52339F
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 12:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgLPMYY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 07:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgLPMYX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 07:24:23 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEDFC0611D0
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 04:23:16 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id w16so17527872pga.9
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 04:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Dg9fN3h7KOR7s6VmRczTkxUNFX0VjU0vgBOvp5Jg3U=;
        b=U5RHTlg7WzK3by8GhOXtYtmQOnGHIqqtPHuPZUqPhwwMuZDkU+e6pvtO599i7t+9Ib
         /+izXUyXqmMtus7Hf+JhHd+gRjcwy1SlLqLqdsxjRoMswYdRGr3AnBv7PTshg/cKnsXf
         BnqjVoehYcLQ75zbUS8qB3mkN0wqPmswUk/ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4Dg9fN3h7KOR7s6VmRczTkxUNFX0VjU0vgBOvp5Jg3U=;
        b=j/53SGESex/uRao/PP7Mv4ZIigsKpaQ/LSjgnv+JrB08Y/mcPY6hN7LVHaVlWAUuvw
         39iBkrgZmLDfCwL3YWFf0t6Wx9Pc9t6SUbuqtg5AwFj6Oxx/rKgXs8guIyEepNF27uDR
         A00LxxzpRS2j61x3+HSVjYOOEvL4GeXwo0vtfbXgE4+DKqXT1y9K7XvTHOYN88dcvJJ2
         V2VMag1Nk41toZeKlfP2QIQe+30xnfQHw/uRrgtUJ+kdkAWCJmSN5Do75x7gCNmkJGjG
         3oTCqlB6pwOBjGAhQ6YSB+PmDfJMd0v6OchOOn30FqB9EUJZdrOkuakTJIxjn67EWWQ/
         DkUg==
X-Gm-Message-State: AOAM531TTCR0x9YO87uig0JRmI/7Yaj4A87vAp7Q7wBaPYeZ0hwx0/34
        nWTs0FqfkvBf9KImIRzVtm/IHoICeBzXP0ue6eUhaL+VePD/8b0gtf4HRLHConoJKnfKoUKXq7e
        +66exdj+j30gs7JjtJwRS5zH/3TZ1H3KSjpf4zGqdpOeTb2FWzffsrW0l+hhxlHjem9v+jooOvZ
        etnEstUUWTcaeC
MIME-Version: 1.0
X-Google-Smtp-Source: ABdhPJzxcvMOTZziE2MlP8/2hivz0erkbkliwEffQcaW8kYKVuyGLrdN/V6r/DddUu5tNglqtFMl2g==
X-Received: by 2002:aa7:8eda:0:b029:19e:c8c3:ed74 with SMTP id b26-20020aa78eda0000b029019ec8c3ed74mr26168135pfr.66.1608121395621;
        Wed, 16 Dec 2020 04:23:15 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s7sm2477296pfh.207.2020.12.16.04.23.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 04:23:15 -0800 (PST)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org, hare@suse.de
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        pbonzini@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v5 08/16] lpfc: vmid: Add support for vmid in mailbox command, does vmid resource allocation and vmid cleanup
Date:   Wed, 16 Dec 2020 10:59:38 +0530
Message-Id: <1608096586-21656-9-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1608096586-21656-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1608096586-21656-1-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009358f305b693f0b5"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000009358f305b693f0b5
Content-Type: text/plain; charset="US-ASCII"

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch does the following -
1.adds supporting datastructures for mailbox command which helps in
determining if the firmware supports appid or not.
2.This patch allocates the resource for vmid and checks if the firmware
supports the feature or not.
3.The patch cleans up the vmid resources and stops the timer.

Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v5:
Merged patches 8 and 11 of v4 to this patch
Changed Return code to non-numeric/Symbol

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_hw4.h  | 12 +++++++
 drivers/scsi/lpfc/lpfc_init.c | 68 +++++++++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_mbox.c |  6 ++++
 drivers/scsi/lpfc/lpfc_scsi.c | 21 +++++++++++
 drivers/scsi/lpfc/lpfc_sli.c  |  9 +++++
 5 files changed, 116 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index 541b9aef6bfe..5fdafc92fc2d 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -272,6 +272,9 @@ struct lpfc_sli4_flags {
 #define lpfc_vfi_rsrc_rdy_MASK		0x00000001
 #define lpfc_vfi_rsrc_rdy_WORD		word0
 #define LPFC_VFI_RSRC_RDY		1
+#define lpfc_ftr_ashdr_SHIFT            4
+#define lpfc_ftr_ashdr_MASK             0x00000001
+#define lpfc_ftr_ashdr_WORD             word0
 };
 
 struct sli4_bls_rsp {
@@ -2943,6 +2946,9 @@ struct lpfc_mbx_request_features {
 #define lpfc_mbx_rq_ftr_rq_mrqp_SHIFT		16
 #define lpfc_mbx_rq_ftr_rq_mrqp_MASK		0x00000001
 #define lpfc_mbx_rq_ftr_rq_mrqp_WORD		word2
+#define lpfc_mbx_rq_ftr_rq_ashdr_SHIFT          17
+#define lpfc_mbx_rq_ftr_rq_ashdr_MASK           0x00000001
+#define lpfc_mbx_rq_ftr_rq_ashdr_WORD           word2
 	uint32_t word3;
 #define lpfc_mbx_rq_ftr_rsp_iaab_SHIFT		0
 #define lpfc_mbx_rq_ftr_rsp_iaab_MASK		0x00000001
@@ -2974,6 +2980,9 @@ struct lpfc_mbx_request_features {
 #define lpfc_mbx_rq_ftr_rsp_mrqp_SHIFT		16
 #define lpfc_mbx_rq_ftr_rsp_mrqp_MASK		0x00000001
 #define lpfc_mbx_rq_ftr_rsp_mrqp_WORD		word3
+#define lpfc_mbx_rq_ftr_rsp_ashdr_SHIFT         17
+#define lpfc_mbx_rq_ftr_rsp_ashdr_MASK          0x00000001
+#define lpfc_mbx_rq_ftr_rsp_ashdr_WORD          word3
 };
 
 struct lpfc_mbx_supp_pages {
@@ -4391,6 +4400,9 @@ struct wqe_common {
 #define wqe_xchg_WORD         word10
 #define LPFC_SCSI_XCHG	      0x0
 #define LPFC_NVME_XCHG	      0x1
+#define wqe_appid_SHIFT       5
+#define wqe_appid_MASK        0x00000001
+#define wqe_appid_WORD        word10
 #define wqe_oas_SHIFT         6
 #define wqe_oas_MASK          0x00000001
 #define wqe_oas_WORD          word10
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index ac67f420ec26..8318dfdc7d87 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -2843,6 +2843,10 @@ lpfc_cleanup(struct lpfc_vport *vport)
 	if (phba->link_state > LPFC_LINK_DOWN)
 		lpfc_port_link_failure(vport);
 
+	/* cleanup vmid resources */
+	if (lpfc_is_vmid_enabled(phba))
+		lpfc_vmid_vport_cleanup(vport);
+
 	list_for_each_entry_safe(ndlp, next_ndlp, &vport->fc_nodes, nlp_listp) {
 		if (vport->port_type != LPFC_PHYSICAL_PORT &&
 		    ndlp->nlp_DID == Fabric_DID) {
@@ -4269,6 +4273,62 @@ lpfc_get_wwpn(struct lpfc_hba *phba)
 		return rol64(wwn, 32);
 }
 
+/**
+ * lpfc_vmid_res_alloc - Allocates resources for VMID
+ * @phba: pointer to lpfc hba data structure.
+ * @vport: pointer to vport data structure
+ *
+ * This routine allocated the resources needed for the vmid.
+ *
+ * Return codes
+ *	0 on Succeess
+ *	Non-0 on Failure
+ */
+u8
+lpfc_vmid_res_alloc(struct lpfc_hba *phba, struct lpfc_vport *vport)
+{
+	u16 i;
+
+	/* vmid feature is supported only on SLI4 */
+	if (phba->sli_rev == LPFC_SLI_REV3) {
+		phba->cfg_vmid_app_header = 0;
+		phba->cfg_vmid_priority_tagging = 0;
+	}
+
+	/* if enabled, then allocated the resources */
+	if (lpfc_is_vmid_enabled(phba)) {
+		vport->vmid =
+		    kmalloc_array(phba->cfg_max_vmid, sizeof(struct lpfc_vmid),
+				  GFP_KERNEL);
+		if (!vport->vmid)
+			return FAILURE;
+
+		memset(vport->vmid, 0,
+		       phba->cfg_max_vmid * sizeof(struct lpfc_vmid));
+
+		rwlock_init(&vport->vmid_lock);
+
+		/* setting the VMID parameters for the vport */
+		vport->vmid_priority_tagging = phba->cfg_vmid_priority_tagging;
+		vport->vmid_inactivity_timeout =
+		    phba->cfg_vmid_inactivity_timeout;
+		vport->max_vmid = phba->cfg_max_vmid;
+		vport->cur_vmid_cnt = 0;
+
+		for (i = 0; i < LPFC_VMID_HASH_SIZE; i++)
+			vport->hash_table[i] = NULL;
+
+		vport->vmid_priority_range = bitmap_zalloc
+			(LPFC_VMID_MAX_PRIORITY_RANGE, GFP_KERNEL);
+
+		if (!vport->vmid_priority_range) {
+			kfree(vport->vmid);
+			return FAILURE;
+		}
+	}
+	return 0;
+}
+
 /**
  * lpfc_create_port - Create an FC port
  * @phba: pointer to lpfc hba data structure.
@@ -4421,6 +4481,12 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 			vport->port_type, shost->sg_tablesize,
 			phba->cfg_scsi_seg_cnt, phba->cfg_sg_seg_cnt);
 
+	/* allocate the resources for vmid */
+	rc = lpfc_vmid_res_alloc(phba, vport);
+
+	if (rc)
+		goto out;
+
 	/* Initialize all internally managed lists. */
 	INIT_LIST_HEAD(&vport->fc_nodes);
 	INIT_LIST_HEAD(&vport->rcv_buffer_list);
@@ -4445,6 +4511,8 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 	return vport;
 
 out_put_shost:
+	kfree(vport->vmid);
+	bitmap_free(vport->vmid_priority_range);
 	scsi_host_put(shost);
 out:
 	return NULL;
diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
index 3414ffcb26fe..78a9b9baecf3 100644
--- a/drivers/scsi/lpfc/lpfc_mbox.c
+++ b/drivers/scsi/lpfc/lpfc_mbox.c
@@ -2100,6 +2100,12 @@ lpfc_request_features(struct lpfc_hba *phba, struct lpfcMboxq *mboxq)
 		bf_set(lpfc_mbx_rq_ftr_rq_iaab, &mboxq->u.mqe.un.req_ftrs, 0);
 		bf_set(lpfc_mbx_rq_ftr_rq_iaar, &mboxq->u.mqe.un.req_ftrs, 0);
 	}
+
+	/* Enable Application Services Header for apphedr VMID */
+	if (phba->cfg_vmid_app_header) {
+		bf_set(lpfc_mbx_rq_ftr_rq_ashdr, &mboxq->u.mqe.un.req_ftrs, 1);
+		bf_set(lpfc_ftr_ashdr, &phba->sli4_hba.sli4_flags, 1);
+	}
 	return;
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 3b989f720937..b79b6f03cdb6 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5370,6 +5370,27 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	return 0;
 }
 
+/*
+ * lpfc_vmid_vport_cleanup - cleans up the resources associated with a vports
+ * @vport: The virtual port for which this call is being executed.
+ */
+void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport)
+{
+	/* delete the timer */
+	if (vport->port_type == LPFC_PHYSICAL_PORT)
+		del_timer_sync(&vport->phba->inactive_vmid_poll);
+
+	/* free the resources */
+	kfree(vport->qfpa_res);
+	kfree(vport->vmid_priority.vmid_range);
+	kfree(vport->vmid);
+
+	/* reset variables */
+	vport->qfpa_res = NULL;
+	vport->vmid_priority.vmid_range = NULL;
+	vport->vmid = NULL;
+	vport->cur_vmid_cnt = 0;
+}
 
 /**
  * lpfc_abort_handler - scsi_host_template eh_abort_handler entry point
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 95caad764fb7..f9b6e32db618 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -7696,6 +7696,15 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 		goto out_free_mbox;
 	}
 
+	/* Disable vmid if app header is not supported */
+	if (phba->cfg_vmid_app_header && !(bf_get(lpfc_mbx_rq_ftr_rsp_ashdr,
+						  &mqe->un.req_ftrs))) {
+		bf_set(lpfc_ftr_ashdr, &phba->sli4_hba.sli4_flags, 0);
+		phba->cfg_vmid_app_header = 0;
+		lpfc_printf_log(phba, KERN_DEBUG, LOG_SLI,
+				"1242 vmid feature not supported");
+	}
+
 	/*
 	 * The port must support FCP initiator mode as this is the
 	 * only mode running in the host.
-- 
2.26.2


-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--0000000000009358f305b693f0b5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
J/4V6ms/nIUi+/4vPYjckYUbRzkXm1/X0IyUfpp5cgdrFn9jBIk69fQGAUEhnVvwcXnHWotYxZFd
Xew5Fz0CAwEAAaOCAdMwggHPMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFGlygmIxZ5VEhXeRgMQENkmdewthMB0GA1Ud
DgQWBBR6On9cEmlB2VsuST951zNMSKtFBzANBgkqhkiG9w0BAQsFAAOCAQEAOGDBLQ17Ge8BVULh
hsKhgh5eDx0mNmRRdhvTJnxOTRX5QsOKvsJGOUbyrKjD3BTTcGmIUti9HmbqDe/3gRTbhu8LA508
LbMkW5lUoTb8ycBNOKLYhNE8UEOY8jRTUtMEhzT6NJDEE+1hb3kSGfArrrF3Z8pRYiUUhcpC5GKL
9KsxA+DECRfSGfXJJQSq6nEZUGKhz+dz5CV1s8UIZLe9HEEfyJO4eRP+Fw9X16cthAbY0kpVnAvT
/j45FAauY/h87uphdvSb5wC9v5w4VO0JKs0yNUjyWXg/RG+6JCvcViLFLAlRCLrcRcVaQwWZQ3YB
EpmWnHflnrBcah5Ozy137DGCAm8wggJrAgEBMG0wXTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIDIgQ0EgLSBT
SEEyNTYgLSBHMwIMX/krgFDQUQNyOf+1MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEi
BCBaOteU5eO9cky+0IAaQCWYGCmIOLplXDEXg4yiB1fL/TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDEyMTYxMjIzMTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAjB2+LFNfOwesiGeo
OWX7BMx0g0H6v2y7LrKlNGqINZLRLaNryuBm5/D5Ns7cqDBAQ3puQIiCOXfh4sI++gLKB+rl1E2i
WCfmK7fPZDjNiYJY7GvdLGC95b60UheE2RBWz7NSK54U4HL6+C5bpWWwHZQf76alttVxTqubWvEA
VvE7LqWCLRS6BojJ2G145y2qrQRiDYTgEXdp502b0B2boRDtR80Q8vaZdDDJW8uO2BF5x4/WQ6f9
fpG6pQi5pTi0mrMS7yuXKW9QmU+g/IVW5xuqFjRkV5BuwCTErWE9gepJtMfpAL3Z8cXoVBuCuOQV
FY1Z08HdEPcv6TFUwflplg==
--0000000000009358f305b693f0b5--
