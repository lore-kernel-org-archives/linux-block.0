Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159CBC7EE22
	for <linux-block@archiver.kernel.org>; Tue,  9 May 2023 01:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjEIBHf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 May 2023 21:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjEIBHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 May 2023 21:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14FD44AF
        for <linux-block@vger.kernel.org>; Mon,  8 May 2023 18:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683594409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+Po/YGLPsWcIlkgYz6PdAWjTef+2U9MEWrAq6EdiQM=;
        b=KX3VSH4ZNhxym2JxiwLMCJjMuV5ItDftsxa82Zp+ssfwhzBE2kbHZ0uvSG+Mk1S8KRdmjH
        wice3o6wclRMm7nSP95xZp8PJsa34z+0oFUWXuwTxcXfpjSMuglIDYzhjm9r6QbICCpIZy
        +jVuAVt9zlBpv1Y9GGe3bjvqOJ/jKYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-njWj6tefMYi0gjzN2S98dQ-1; Mon, 08 May 2023 21:06:48 -0400
X-MC-Unique: njWj6tefMYi0gjzN2S98dQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51AD3101A55C
        for <linux-block@vger.kernel.org>; Tue,  9 May 2023 01:06:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.11.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EA7C492C13;
        Tue,  9 May 2023 01:06:48 +0000 (UTC)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     corwin <corwin@redhat.com>
Subject: [PATCH 5/5] Enable configuration and building of dm-vdo.
Date:   Mon,  8 May 2023 21:05:45 -0400
Message-Id: <20230509010545.72448-6-corwin@redhat.com>
In-Reply-To: <20230509010545.72448-1-corwin@redhat.com>
References: <20230509010545.72448-1-corwin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: corwin <corwin@redhat.com>

This adds dm-vdo to the drivers/md Kconfig and Makefile.

Signed-off-by: corwin <corwin@redhat.com>
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
2.40.0

