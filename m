Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1064C71155
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 18:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601C122203
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgLBSFv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 13:05:51 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:24805 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgLBSFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 13:05:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606932332; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: To:
 From: Sender; bh=/TlMS5OJ20jyahV9MX4hb/PKbCiV3kGHQzaJ1zuJzzQ=; b=F0mjt3bycmA+RE5R3waCaHirRQcysMlqV01HAaWXyA5a6bO+tu92QGXX4vxU2G8PISjk5lHp
 vdFEFGT+lDHmv9oporQHWWIdfNO0eLcQwACOn5w9YBJ+mYJlSoiEcMXLKadj7DLXSyhDw0fX
 OdstwOnacENuVZKbL0lxMrg072w=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fc7d75e7edc97d061ea2ca9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 18:05:18
 GMT
Sender: rsiddoji=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7974AC43460; Wed,  2 Dec 2020 18:05:17 +0000 (UTC)
Received: from rsiddoji1 (unknown [123.201.165.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2CABC433ED;
        Wed,  2 Dec 2020 18:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2CABC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rsiddoji@codeaurora.org
From:   "Ravi Kumar Siddojigari" <rsiddoji@codeaurora.org>
To:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>
References: 
In-Reply-To: 
Subject: RE: [PATCH] dm verity: correcting logic used with corrupted_errs counter
Date:   Wed, 2 Dec 2020 23:35:11 +0530
Organization: The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
Message-ID: <000001d6c8d5$b03e7200$10bb5600$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH+wGaSVHC4B8VH2eGDagahwX5nL6mUKdpA
Content-Language: en-us
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sorry,  Resending the patch for comments with  dm-devel added .

-----Original Message-----
From: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org> 
Sent: Friday, November 20, 2020 6:37 PM
To: 'linux-block@vger.kernel.org' <linux-block@vger.kernel.org>
Cc: 'dm-devel@redhat.com' <dm-devel@redhat.com>
Subject: RE: [PATCH] dm verity: correcting logic used with corrupted_errs
counter

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


