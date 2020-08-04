Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BB5C433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A4E206DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KAA1ivmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgHDJH6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbgHDJH6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 05:07:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2BC06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 02:07:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s16so30332505qtn.7
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wY5U1pUe+qw0enxKGw2PJA9tH4p4Mf8pWBXWr9tP5Y4=;
        b=KAA1ivmrZcoS21hJBSqWVLDHXo1lXe6spzk6WPw7TNq8csDBGMyGjX468fbUrMqOMa
         wrrFtbN+ESyaRSb6LbOsi2hVwQPwsHVFSn7jHWGvEP2l3w/bbn3VseLqK18y7S/3FpLy
         5Q0QPiRse1jqlPoaKWK5Z/RZgmLFM1JDd+SUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wY5U1pUe+qw0enxKGw2PJA9tH4p4Mf8pWBXWr9tP5Y4=;
        b=SLiH1CMAXeoCxJgatkWqSCbQJNVa0mBiYu81Y/6J6QoFjyt6XENisGfqpImOLtit6q
         7iikzWFM1OHf/mlEgSSnYDXtHvM0txwH4ARqIGwGFlTT+FXji7oC2pa4ywvbYTO2VOa7
         ogxO0afBGWvDhpmscY5SOZVeIdb1akvc52kL6mkKu1JdhFyuKAMk7mYyklZroQq9Osbc
         HhvTAy3EwQcoQa2ualvwKjf0pam6A9LApg20/BCzlsGFiemX2beHuJW/H6609cHwOZ2c
         CbEFv/zvp6zlRiDt2nhk4wx7sSD5jH5cksE6pYXQ0dA/fwi3wX7zXW625NbHQtolkR4N
         MYRg==
X-Gm-Message-State: AOAM5321r9/9+dHfMQbCBt803ucoqS488v3+RVv4qc4y6KP3YtvKGh2D
        OE44KkLSXHfnB+hvjBOYhHfXohaiVK42M9aNxmj55Cocez/qA2/hp2UVrGKxGDWVWbYsd04/+tg
        7y34zyxituMpPDaTZYfwrEcJlO5Ocud9+YugEjCizu+kUvnCzTdAhMipA8C837l4QQfb1ktAdHt
        nYv35ZOT8=
X-Google-Smtp-Source: ABdhPJzCJ7HOiqh5e68sEUeBiawiWMuf/N+Q5zGuhc/rZ9Nv2UvV7L5urSkS/3busJ/l7uovVo/9Ww==
X-Received: by 2002:aed:2ae2:: with SMTP id t89mr20372091qtd.171.1596532076955;
        Tue, 04 Aug 2020 02:07:56 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 65sm19989407qkn.103.2020.08.04.02.07.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 02:07:56 -0700 (PDT)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     pbonzini@redhat.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [RFC 15/16] lpfc: vmid: Adding qfpa and vmid timeout check in worker thread
Date:   Tue,  4 Aug 2020 07:43:15 +0530
Message-Id: <1596507196-27417-16-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch add the periodic check for issuing of qfpa command and vmid
timeout in the worker thread. The inactivity timeout check is added via
the timer function.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index b20013866942..38df3c4341f9 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -433,6 +433,32 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 	return fcf_inuse;
 }
 
+void lpfc_check_vmid_qfpa_issue(struct lpfc_hba *phba)
+{
+	struct lpfc_vport *vport;
+	struct lpfc_vport **vports;
+	int i, ret;
+
+	vports = lpfc_create_vport_work_array(phba);
+	if (!vports)
+		return;
+
+	for (i = 0; i <= phba->max_vports; i++) {
+		if ((!vports[i]) && (i == 0))
+			vport = phba->pport;
+		else
+			vport = vports[i];
+		if (!vport)
+			break;
+
+		if (vport->vmid_flag & LPFC_VMID_ISSUE_QFPA) {
+			ret = lpfc_issue_els_qfpa(vport);
+			vport->vmid_flag &= ~LPFC_VMID_ISSUE_QFPA;
+		}
+	}
+	lpfc_destroy_vport_work_array(phba, vports);
+}
+
 /**
  * lpfc_sli4_post_dev_loss_tmo_handler - SLI4 post devloss timeout handler
  * @phba: Pointer to hba context object.
@@ -744,6 +770,22 @@ lpfc_work_done(struct lpfc_hba *phba)
 	if (ha_copy & HA_LATT)
 		lpfc_handle_latt(phba);
 
+	/* Handle VMID Events */
+	if (lpfc_is_vmid_enabled(phba)) {
+		if (phba->pport->work_port_events &
+		    WORKER_CHECK_VMID_ISSUE_QFPA) {
+			lpfc_check_vmid_qfpa_issue(phba);
+			phba->pport->work_port_events &=
+				~WORKER_CHECK_VMID_ISSUE_QFPA;
+		}
+		if (phba->pport->work_port_events &
+		    WORKER_CHECK_INACTIVE_VMID) {
+			lpfc_check_inactive_vmid(phba);
+			phba->pport->work_port_events &=
+			    ~WORKER_CHECK_INACTIVE_VMID;
+		}
+	}
+
 	/* Process SLI4 events */
 	if (phba->pci_dev_grp == LPFC_PCI_DEV_OC) {
 		if (phba->hba_flag & HBA_RRQ_ACTIVE)
-- 
2.18.2

