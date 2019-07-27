Return-Path: <SRS0=8nuL=VY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925FCC76186
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 18:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9120840
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 18:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix+I4uDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbfG0Sxq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Jul 2019 14:53:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37160 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387794AbfG0Sxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jul 2019 14:53:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so26020583pfa.4;
        Sat, 27 Jul 2019 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y3DnasAilMtI3RHpffbNTgKJ99rymltM1iusWTe3er4=;
        b=Ix+I4uDUS+gstrellW1g3Ojk4+fwQ2/s3x9Iu03wCV2yR0JJ5oQDgFZOeqTuyGDrny
         EuiEnHsq8/vKBvSOmZFZNYgbsAj5t3Df70F9XY+1FyTQXCxi9ko9ktlCVNJql+pyiEfK
         aGaWBAkqEyp8t1mfUMmMnoBoATOQ3qzoWSC6i+oraTxhAFL/BbqkIlDwiNRb4+F/rWp7
         /h4UK1pDWIa5HGI8yq51vQx1QV3PaHRUKNEwoRC6WaCOJxuTkBsQt1Gq6yYarZJsJ5we
         J8aiugN7hfvWBo9+a+LDXnyNur2GOzWOBj4QLKPe7ohqfhzvEWYm1k+bB/JQFtGXtA3r
         4xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y3DnasAilMtI3RHpffbNTgKJ99rymltM1iusWTe3er4=;
        b=E9tvL7LgYtG28qoqvFbpi+tlr9+FIHGpbeuZx9xZw9oASIFO9Le4Y7MyHUIbwiGcrb
         v4I/tJkbUMC7hkEHIwuewnMInsnG3N3/xVduBOyUegFldr3JG+hR7nGs+tuYNa8fy/GY
         57fLt2nE6DryiULMlgdRcVVT75qRf9MSrwJz7XRh8tnpTB0OS76++gO0IGXr2b6bA+Fg
         TTonE4kNbDIB/WPziWxUa40DxBSA4GMnWJZ86a76h77ohyDtBDzG4/jDdbdMpcwmA+1u
         mgaVPP8GYUCsiIaJqtZs/3IjZJDZCgW7fwAaryS6t6AOiLrKRBqXJCT/xZ0xAbK9a7cH
         rs2w==
X-Gm-Message-State: APjAAAWpjskDbYXKLo/DvALdB7l12IyuhwMnnM7FJKg7QFm/BOIrK20i
        miqxCelbrJdQ2HucjnoG1Von/3dVJN8=
X-Google-Smtp-Source: APXvYqxYevqHhJ6dt1EzQWwOWP8c4KB8DdOUpnfAfnIMcQ6mqofCdtY7VyEV2Cy2pdWlVImmnMp1CQ==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr28749668pfv.195.1564253624486;
        Sat, 27 Jul 2019 11:53:44 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id j10sm22023163pfn.188.2019.07.27.11.53.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 11:53:43 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        Minwoo Im <minwoo.im@samsung.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [RESEND PATCH] mpt3sas: support target smid for [abort|query] task
Date:   Sun, 28 Jul 2019 03:53:37 +0900
Message-Id: <20190727185337.19299-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Minwoo Im <minwoo.im@samsung.com>

From: Minwoo Im <minwoo.im@samsung.com>

We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MGMT)
to /dev/mpt3ctl.  If the given task_type is either abort task or query
task, it may need a field named "Initiator Port Transfer Tag to Manage"
in the IU.

Current code does not support to check target IPTT tag from the
tm_request.  This patch introduces to check TaskMID given from the
userspace as a target tag.  We have a rule of relationship between
(struct request *req->tag) and smid in mpt3sas_base.c:

3318 u16
3319 mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
3320         struct scsi_cmnd *scmd)
3321 {
3322         struct scsiio_tracker *request = scsi_cmd_priv(scmd);
3323         unsigned int tag = scmd->request->tag;
3324         u16 smid;
3325
3326         smid = tag + 1;

So if we want to abort a request tagged #X, then we can pass (X + 1) to
this IOCTL handler.  Otherwise, user space just can pass 0 TaskMID to
abort the first outstanding smid which is legacy behaviour.

Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: James E.J. Bottomley <jejb@linux.ibm.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: MPT-FusionLinux.pdl@broadcom.com
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Acked-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index d4ecfbbe738c..a26c5516ea3e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -596,8 +596,16 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command *karg,
 		if (priv_data->sas_target->handle != handle)
 			continue;
 		st = scsi_cmd_priv(scmd);
-		tm_request->TaskMID = cpu_to_le16(st->smid);
-		found = 1;
+
+		/*
+		 * If the given TaskMID from the user space is zero, then the
+		 * first outstanding smid will be picked up.  Otherwise,
+		 * targeted smid will be the one.
+		 */
+		if (!tm_request->TaskMID || tm_request->TaskMID == st->smid) {
+			tm_request->TaskMID = cpu_to_le16(st->smid);
+			found = 1;
+		}
 	}
 
 	if (!found) {
-- 
2.17.1

