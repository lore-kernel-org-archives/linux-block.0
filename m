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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8C4C2BBCF
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 12:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722C123109
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 12:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLPMYM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 07:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgLPMYL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 07:24:11 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AAEC061257
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 04:23:02 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z21so379858pgj.4
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 04:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dl6RzmY/6SBv+guHzE2VWfICpPZ1nuw51a4JmxyqYHU=;
        b=ITxG3q59mOap95ZirwXvI+b+5HEL5TJMVThx4Gz7Ml8ivTKKQlPtoofWRbBgZbnowg
         cmU0E1WohN0zIOxJ+SB81Rm5qs+85dclzdjOcQ+KGNAZI1I16ALqW7KQgF0pDMsi2yWp
         MpxegDwNM5AktxQZZEkOEQ75gqcI1t99Auf5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dl6RzmY/6SBv+guHzE2VWfICpPZ1nuw51a4JmxyqYHU=;
        b=GWCiLzsicVBpb0TDf1keFculszE17+SfXLajqyGc/95+c3a5l4U4wXl2vQUnarmZ5G
         FvdHNvgbtDh1k9HXUUM63DHiltLHH4YiB3uFU9e53zPdpTYiGgEZIo2Ku/244A/JnTPg
         E2o7HQWLh/0A04rDfuicwpCFU6bWxG/NyFa/a6dei9EpT/60oNGEVMQ0p7BhjwkLB14D
         NkNvDqZ1uap7+o1JQLC2HvQd2Ptfa/noz0B4SFGxOOU7ADLR0znD7aEtsDVL29dfC7Yq
         CmLLQ/e2JYJ1gYSDG8D/IISUxcx+TUDTKBYLiF5uCVlxFrMbDCJwNn3NNEirnNUnL6QR
         JNFQ==
X-Gm-Message-State: AOAM532CUyyhBqp5E+rh1mWVIyMopTkIb+XA4zrvTi70FNTo2rWKNfrF
        tEaBSQhelE6YyCIgC/rXCuP9lRMPkADnavB4GvWMs/OROYGha5o0mzVYCpWEkd5kzJILiOEVXJ2
        fTrD3pPAH6D4/wouC6XKrkxyQnC/xJw8hZL1pDYM9S6uqWkPh/6/bY4U7aDFiRPEFfztJkPO0Dl
        z49iuhkasthcHd
MIME-Version: 1.0
X-Google-Smtp-Source: ABdhPJzrmrSsC1I9fBU4ul1heVGldUN3T/mw1/nEKyXqF8iwHHr/CKwHRYbiybX48/Bd8VjMt3AqeA==
X-Received: by 2002:a63:650:: with SMTP id 77mr28186182pgg.132.1608121381398;
        Wed, 16 Dec 2020 04:23:01 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s7sm2477296pfh.207.2020.12.16.04.22.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 04:23:00 -0800 (PST)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org, hare@suse.de
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        pbonzini@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v5 04/16] lpfc: vmid: Add the datastructure for supporting VMID in lpfc
Date:   Wed, 16 Dec 2020 10:59:34 +0530
Message-Id: <1608096586-21656-5-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1608096586-21656-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1608096586-21656-1-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b9aed905b693ef90"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000b9aed905b693ef90
Content-Type: text/plain; charset="US-ASCII"

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch adds the primary datastructures needed to implement VMID in lpfc
driver. It maintains the capability, current state, hash table for the
vmid/appid along with other information.

Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v5:
No Change

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
Removed unused variable.
---
 drivers/scsi/lpfc/lpfc.h | 97 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index a54c8da30273..ab61352363d4 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -303,6 +303,63 @@ struct lpfc_stats {
 struct lpfc_hba;
 
 
+#define LPFC_VMID_TIMER   300	/* timer interval in seconds. */
+
+#define LPFC_MAX_VMID_SIZE      256
+#define LPFC_COMPRESS_VMID_SIZE 16
+
+union lpfc_vmid_io_tag {
+	u32 app_id;	/* App Id vmid */
+	u8 cs_ctl_vmid;	/* Priority tag vmid */
+};
+
+#define JIFFIES_PER_HR	(HZ * 60 * 60)
+
+struct lpfc_vmid {
+	u8 flag;
+#define LPFC_VMID_SLOT_FREE     0x0
+#define LPFC_VMID_SLOT_USED     0x1
+#define LPFC_VMID_REQ_REGISTER  0x2
+#define LPFC_VMID_REGISTERED    0x4
+#define LPFC_VMID_DE_REGISTER   0x8
+	u8 host_vmid[LPFC_MAX_VMID_SIZE];
+	union lpfc_vmid_io_tag un;
+	u64 io_rd_cnt;
+	u64 io_wr_cnt;
+	u8 vmid_len;
+	u8 delete_inactive; /* Delete if inactive flag 0 = no, 1 = yes */
+	u32 hash_index;
+	u64 __percpu *last_io_time;
+};
+
+#define lpfc_vmid_is_type_priority_tag(vport)\
+	(vport->vmid_priority_tagging ? 1 : 0)
+
+#define LPFC_VMID_HASH_SIZE     256
+#define LPFC_VMID_HASH_MASK     255
+#define LPFC_VMID_HASH_SHIFT    6
+
+struct lpfc_vmid_context {
+	struct lpfc_vmid *vmp;
+	struct lpfc_nodelist *nlp;
+	u8 instantiated;
+};
+
+struct lpfc_vmid_priority_range {
+	u8 low;
+	u8 high;
+	u8 qos;
+};
+
+struct lpfc_vmid_priority_info {
+	u32 num_descriptors;
+	struct lpfc_vmid_priority_range *vmid_range;
+};
+
+#define QFPA_EVEN_ONLY 0x01
+#define QFPA_ODD_ONLY  0x02
+#define QFPA_EVEN_ODD  0x03
+
 enum discovery_state {
 	LPFC_VPORT_UNKNOWN     =  0,    /* vport state is unknown */
 	LPFC_VPORT_FAILED      =  1,    /* vport has failed */
@@ -442,6 +499,9 @@ struct lpfc_vport {
 #define WORKER_RAMP_DOWN_QUEUE         0x800	/* hba: Decrease Q depth */
 #define WORKER_RAMP_UP_QUEUE           0x1000	/* hba: Increase Q depth */
 #define WORKER_SERVICE_TXQ             0x2000	/* hba: IOCBs on the txq */
+#define WORKER_CHECK_INACTIVE_VMID     0x4000	/* hba: check inactive vmids */
+#define WORKER_CHECK_VMID_ISSUE_QFPA   0x8000	/* vport: Check if qfpa need */
+						/* to issue */
 
 	struct timer_list els_tmofunc;
 	struct timer_list delayed_disc_tmo;
@@ -452,6 +512,8 @@ struct lpfc_vport {
 #define FC_LOADING		0x1	/* HBA in process of loading drvr */
 #define FC_UNLOADING		0x2	/* HBA in process of unloading drvr */
 #define FC_ALLOW_FDMI		0x4	/* port is ready for FDMI requests */
+#define FC_ALLOW_VMID		0x8	/* Allow VMID IO's */
+#define FC_DEREGISTER_ALL_APP_ID	0x10	/* Deregister all vmid's */
 	/* Vport Config Parameters */
 	uint32_t cfg_scan_down;
 	uint32_t cfg_lun_queue_depth;
@@ -470,9 +532,36 @@ struct lpfc_vport {
 	uint32_t cfg_tgt_queue_depth;
 	uint32_t cfg_first_burst_size;
 	uint32_t dev_loss_tmo_changed;
+	/* VMID parameters */
+	u8 lpfc_vmid_host_uuid[LPFC_COMPRESS_VMID_SIZE];
+	u32 max_vmid;	/* maximum VMIDs allowed per port */
+	u32 cur_vmid_cnt;	/* Current VMID count */
+#define LPFC_MIN_VMID	4
+#define LPFC_MAX_VMID	255
+	u32 vmid_inactivity_timeout;	/* Time after which the VMID */
+						/* deregisters from switch */
+	u32 vmid_priority_tagging;
+#define LPFC_VMID_PRIO_TAG_DISABLE	0 /* Disable */
+#define LPFC_VMID_PRIO_TAG_SUP_TARGETS	1 /* Allow supported targets only */
+#define LPFC_VMID_PRIO_TAG_ALL_TARGETS	2 /* Allow all targets */
+	unsigned long *vmid_priority_range;
+#define LPFC_VMID_MAX_PRIORITY_RANGE    256
+#define LPFC_VMID_PRIORITY_BITMAP_SIZE  32
+	u8 vmid_flag;
+#define LPFC_VMID_IN_USE		0x1
+#define LPFC_VMID_ISSUE_QFPA		0x2
+#define LPFC_VMID_QFPA_CMPL		0x4
+#define LPFC_VMID_QOS_ENABLED		0x8
+#define LPFC_VMID_TIMER_ENBLD		0x10
+	struct fc_qfpa_res *qfpa_res;
 
 	struct fc_vport *fc_vport;
 
+	struct lpfc_vmid *vmid;
+	struct lpfc_vmid *hash_table[LPFC_VMID_HASH_SIZE];
+	rwlock_t vmid_lock;
+	struct lpfc_vmid_priority_info vmid_priority;
+
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	struct dentry *debug_disc_trc;
 	struct dentry *debug_nodelist;
@@ -934,6 +1023,13 @@ struct lpfc_hba {
 	struct nvmet_fc_target_port *targetport;
 	lpfc_vpd_t vpd;		/* vital product data */
 
+	u32 cfg_max_vmid;	/* maximum VMIDs allowed per port */
+	u32 cfg_vmid_app_header;
+#define LPFC_VMID_APP_HEADER_DISABLE	0
+#define LPFC_VMID_APP_HEADER_ENABLE	1
+	u32 cfg_vmid_priority_tagging;
+	u32 cfg_vmid_inactivity_timeout;	/* Time after which the VMID */
+						/*  deregisters from switch */
 	struct pci_dev *pcidev;
 	struct list_head      work_list;
 	uint32_t              work_ha;      /* Host Attention Bits for WT */
@@ -1175,6 +1271,7 @@ struct lpfc_hba {
 	struct list_head ct_ev_waiters;
 	struct unsol_rcv_ct_ctx ct_ctx[LPFC_CT_CTX_MAX];
 	uint32_t ctx_idx;
+	struct timer_list inactive_vmid_poll;
 
 	/* RAS Support */
 	struct lpfc_ras_fwlog ras_fwlog;
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

--000000000000b9aed905b693ef90
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
BCCt2D0pf8HXMW1YV1Oo15UJ0mxjP+1e1tYp1Nro96YNUDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDEyMTYxMjIzMDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAppCphF7IWtCmKOt5
fL5aNcC1I3IKJXhvUJWvOSZJ0ghnNqyT1ByOZduR0UW15EZohOJiLmzjlSXJNP5mvse0nxfrtEWU
J9RbQhGCpzGPJzyI0TQJ7yeI1pl3IzftHgSos31G/hCrDt+Um4pvf6TTXhx6s+h35P9/CkIQMAs5
nHA4fl/C07ix/l0JrGl/XBnpeyQwcP0NMC9NeQ14jy50tWGZbiSbKpwOr0MVD8ADJE9PbUC45RZ7
eWCBiOuFAkBErhOqnJIth4Wc3QVilo2/AdkvO08wMfXaLf8k2Vqh2J+X+hdFnk830O0lRLzZ0LqA
0pDunix2ETGLRyFi6pPkCQ==
--000000000000b9aed905b693ef90--
