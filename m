Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E6C7EE2F
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 21:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbjEWVsE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 17:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbjEWVsD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C82FE5F
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hg/zaQe2dWvWWu17zwru47O61a0bYijZrhPqKVs23Ik=;
        b=IIm4eJdqfrjhPyd78+JtVuDqirFLCF4qaUk0YViL/N2pglxCmNfSS2ickmLWFXjxhZ1QTz
        D5ga36HoyQZ58sFnVz8Ctc4DvYOlN7bBFgZDcOUk5cfbi/awN+DchoAMcpeqL32uw+KYRg
        e5FsQk59u6Q3dxU/ThJOZxt6utOhM3Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-nTnph2xCO6uA0swJ03Uz2w-1; Tue, 23 May 2023 17:46:55 -0400
X-MC-Unique: nTnph2xCO6uA0swJ03Uz2w-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75aff1596d3so59640985a.2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878414; x=1687470414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg/zaQe2dWvWWu17zwru47O61a0bYijZrhPqKVs23Ik=;
        b=bdNhMLL9czM/qAxg7KWWWDm8NBsY1dXOziHA8+SqNGoGOt73XvBIVZk9q0y3HfngN0
         cv39Ff9s3hj78cPX3HBo88l9+6nNA+le+CgvMsLpelafktW9aFfWOxtezMuLbG1cCc2o
         RWUBBtGpVPF+cxB57Z6qua0UchSd1wXA+se5F/M0SBaaYx6MPadEewHu7v4vWkLu4MFJ
         YO7jQcHwcF90KmhcOEuU50kA1DyTwbgKTacsI7ZnbH60fVGYE4PeLhInTUPzloidycwU
         oHM9wsN3QvcIxvqNp6WC5iB67tcrnzR0CIRWcAl5zDz11h83GoOTt+77dmDZO6ye/uLd
         PReg==
X-Gm-Message-State: AC+VfDzfCujO0qHAyMwOqd8C/EWn9crbVu8RRUgLyqVzK8BqVHqrCALL
        hmWTRq9iP6wJI45KLxXeodx/KgnF5R+hL6d+J0tMttndDjGJf04s6MGmbXPpzDdjGMeV7qXZT+s
        IqDsswXZphuzvCo2kxqTx28s=
X-Received: by 2002:ae9:e8d5:0:b0:75b:23a1:3631 with SMTP id a204-20020ae9e8d5000000b0075b23a13631mr5071145qkg.66.1684878414662;
        Tue, 23 May 2023 14:46:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ozzKH72v9R1bpoUGZsA0EiGmHkXmMCsqtMN/GguQIaO0RopbV2921RKgsM0ApwdxyDS1rEQ==
X-Received: by 2002:ae9:e8d5:0:b0:75b:23a1:3631 with SMTP id a204-20020ae9e8d5000000b0075b23a13631mr5071138qkg.66.1684878414461;
        Tue, 23 May 2023 14:46:54 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id f25-20020a05620a15b900b0075b196ae392sm1489722qkk.104.2023.05.23.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:46:54 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 39/39] Enable configuration and building of dm-vdo.
Date:   Tue, 23 May 2023 17:45:39 -0400
Message-Id: <20230523214539.226387-40-corwin@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523214539.226387-1-corwin@redhat.com>
References: <20230523214539.226387-1-corwin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds dm-vdo to the drivers/md Kconfig and Makefile.

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/Kconfig  | 16 ++++++++++++++++
 drivers/md/Makefile |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index b0a22e99bad..9fa9dec1029 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -521,6 +521,22 @@ config DM_FLAKEY
 	help
 	 A target that intermittently fails I/O for debugging purposes.
 
+config DM_VDO
+	tristate "VDO: deduplication and compression target"
+	depends on 64BIT
+	depends on BLK_DEV_DM
+	select DM_BUFIO
+	select LZ4_COMPRESS
+	select LZ4_DECOMPRESS
+	help
+	  This device mapper target presents a block device with
+	  deduplication, compression and thin-provisioning.
+
+	  To compile this code as a module, choose M here: the module will
+	  be called dm-vdo.
+
+	  If unsure, say N.
+
 config DM_VERITY
 	tristate "Verity target support"
 	depends on BLK_DEV_DM
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 84291e38dca..47444b393ab 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -25,6 +25,7 @@ dm-ebs-y	+= dm-ebs-target.o
 dm-era-y	+= dm-era-target.o
 dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
 dm-verity-y	+= dm-verity-target.o
+dm-vdo-y	+= dm-vdo-target.o $(patsubst drivers/md/dm-vdo/%.c,dm-vdo/%.o,$(wildcard $(src)/dm-vdo/*.c))
 dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
 
 md-mod-y	+= md.o md-bitmap.o
@@ -74,6 +75,7 @@ obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
 obj-$(CONFIG_DM_RAID)		+= dm-raid.o
 obj-$(CONFIG_DM_THIN_PROVISIONING) += dm-thin-pool.o
 obj-$(CONFIG_DM_VERITY)		+= dm-verity.o
+obj-$(CONFIG_DM_VDO)            += dm-vdo.o
 obj-$(CONFIG_DM_CACHE)		+= dm-cache.o
 obj-$(CONFIG_DM_CACHE_SMQ)	+= dm-cache-smq.o
 obj-$(CONFIG_DM_EBS)		+= dm-ebs.o
-- 
2.40.1

