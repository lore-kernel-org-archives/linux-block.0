Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E412C63777
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 13:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D96922255
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 13:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="W+hGw+G4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgKTNHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 08:07:12 -0500
Received: from z5.mailgun.us ([104.130.96.5]:11754 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgKTNHM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 08:07:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605877632; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=ky9lHNsP8+Lm33lBN7ePYKYRKvn3pWSKYZ+YzHVzvF4=; b=W+hGw+G4sBeeYeZZe6u0K7w2lPDExSKASIIjRRYiA8EGZIPpijOUPI1aitJCXelD0pmGHETC
 7t5ZgzTJT/hy1ZDqbWLiIveRQopwCm/5T+Kq2hV/uTtCc5yqyvicoyhB2dYoo0CWS8m1TEwf
 X6Ixr43p5ytLB91OUrDeSgo5dYg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fb7bf707f0cfa6a1608f4f9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 13:06:56
 GMT
Sender: rsiddoji=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9146CC43460; Fri, 20 Nov 2020 13:06:55 +0000 (UTC)
Received: from rsiddoji1 (unknown [123.201.77.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF926C433C6;
        Fri, 20 Nov 2020 13:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF926C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rsiddoji@codeaurora.org
From:   "Ravi Kumar Siddojigari" <rsiddoji@codeaurora.org>
To:     <linux-block@vger.kernel.org>
Cc:     <dm-devel@redhat.com>
References: 
In-Reply-To: 
Subject: RE: [PATCH] dm verity: correcting logic used with corrupted_errs counter
Date:   Fri, 20 Nov 2020 18:36:48 +0530
Organization: The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
Message-ID: <000a01d6bf3e$04469360$0cd3ba20$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHEZAMspObxLWufX0PyT6U7blaUhKn1sqZA
Content-Language: en-us
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One more question  :
	Current code has DM_VERITY_MAX_CORRUPTED_ERRS  set to 100  can we
reduce this ? or is there any  data that made us to keep this 100 ?
Regards,
Ravi

-----Original Message-----
From: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org> 
Sent: Wednesday, November 18, 2020 6:17 PM
To: 'linux-block@vger.kernel.org' <linux-block@vger.kernel.org>
Subject: [PATCH] dm verity: correcting logic used with corrupted_errs
counter

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
+	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS) {
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


