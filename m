Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00C7C5519F
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 12:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D51E24180
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 12:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="LBEdxhCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKRMri (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Nov 2020 07:47:38 -0500
Received: from z5.mailgun.us ([104.130.96.5]:34148 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKRMri (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Nov 2020 07:47:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605703658; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: To: From: Sender;
 bh=dTQgOUVuojBlogTXdtxUl0gbxkKymUygC3hcYieAfG0=; b=LBEdxhCUJFeOVBruU6cZoVBnxV/EiI7bqN4LDlSCT0sIUeUGkRpkNvzKQHYP6ZcVKzseun0c
 6NqlzWA0Kt/IMbCwjEUsI4WcVEg4Ywy/8x3CG55t/PLFhUxHp+52J/88aPfx4c0gaCEQvo3Y
 JbcybDZil/+y84IY7tYsqjnPXRg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fb517e98e090a888680b938 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Nov 2020 12:47:37
 GMT
Sender: rsiddoji=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88C27C43460; Wed, 18 Nov 2020 12:47:36 +0000 (UTC)
Received: from rsiddoji1 (unknown [203.109.108.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 261BDC433C6
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2020 12:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 261BDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rsiddoji@codeaurora.org
From:   "Ravi Kumar Siddojigari" <rsiddoji@codeaurora.org>
To:     <linux-block@vger.kernel.org>
Subject: [PATCH] dm verity: correcting logic used with corrupted_errs counter
Date:   Wed, 18 Nov 2020 18:17:25 +0530
Organization: The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
Message-ID: <001a01d6bda8$fd4aee30$f7e0ca90$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ada9qDhYf7tQ7aqeSw2BxZmYJ5jwyA==
Content-Language: en-us
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In verity_handle_err we see that the "corrupted_errs"  is never going to be
more than one as the code will fall through "out" label and hit
panic/kernel_restart on the first error  which is not as expected.. 
Following patch will make sure that corrupted_errs are incremented and only
panic/kernel_restart once it reached DM_VERITY_MAX_CORRUPTED_ERRS.

Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
---
 drivers/md/dm-verity-target.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index f74982dcbea0..d86900a2a8d7 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -221,8 +221,10 @@ static int verity_handle_err(struct dm_verity *v, enum
verity_block_type type,
 	/* Corruption should be visible in device status in all modes */
 	v->hash_failed = 1;
 
-	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
+	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS){
+		DMERR("%s: reached maximum errors", v->data_dev->name);
 		goto out;
+	}
 
 	v->corrupted_errs++;
 
@@ -240,13 +242,13 @@ static int verity_handle_err(struct dm_verity *v, enum
verity_block_type type,
 	DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
 		    type_str, block);
 
-	if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS)
-		DMERR("%s: reached maximum errors", v->data_dev->name);
 
 	snprintf(verity_env, DM_VERITY_ENV_LENGTH, "%s=%d,%llu",
 		DM_VERITY_ENV_VAR_NAME, type, block);
 
 	kobject_uevent_env(&disk_to_dev(dm_disk(md))->kobj, KOBJ_CHANGE,
envp);
+	/* DM_VERITY_MAX_CORRUPTED_ERRS limit not reached yet */
+		return 0;
 
 out:
 	if (v->mode == DM_VERITY_MODE_LOGGING)
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a
Linux Foundation Collaborative Project


