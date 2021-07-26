Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B2C4320A
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 11:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6728960F22
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 11:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhGZLT0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 07:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhGZLT0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 07:19:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8083C061764
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 04:59:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jg2so11136839ejc.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3JoJQ61zupUbIrtHIo8D6FnplLiROdqQZmClBD1yIY=;
        b=NK5H2gRbeC6gFjlGTwlgSQm5FrROITlbCKLnibM1biKApbEM0+3u7agsZ6FECNkept
         bUmuwVMvqZ3PSFkfhUmJsRCCBewEYXj/hcr4E1Zly7+nfoJI4YsyRXd4WBMvqytY2DHr
         wTvVqHDVYhNAgwj0PEVg4HtwVJ1HfushrHD9csUwQr0w3Xo2ZXGpkvnCJO6bnEh/4Log
         A4WN4c0qQHZtIwF1pMta+j+t4geFTUrTsULX/+t7SzH/lCbXbZpTWVA23tLtOQtSp3ux
         SYWNGSY1z4r9aRP+3QIZfvjIQ126t9WTNlVz5qTGB83NW18fJVbWB1YOHoK3BcKHb1xF
         SpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3JoJQ61zupUbIrtHIo8D6FnplLiROdqQZmClBD1yIY=;
        b=P+EDZ1gxnizXpBr1LdqZkAM4wPw79Gq1BUtWe120S6VPs7uDYWrUq/btW+abrtU/GL
         s/Z5tprrTx8Y+VAoe5QSVN8EVYjXpdnEmEIv4rGgDolC5UNWZTYxmqWVJJ8jP0mzL/e6
         N5Ydo1BgmNOkSVSgLcZamy3KeLTZ/dANtXgsi6aAoip4b5uz1U0CuwGcVM+NlDzKtQhC
         KNLYLffoGHFftVKC1COsSWeiu5fHxxKGItFVfded9hBjY5DSsXQZHBhWc6mSsSjRL26w
         O6sTaCgjVRYVUFy+4N5c/mGqTh5Y5/P/TC53h09faX4hdUaf+x1PcHgJcxvek1589k94
         icYQ==
X-Gm-Message-State: AOAM533ORyqfKuhqU2gq/KefIZOirDpmQUYrEZVnzWw5t4IeTjyYpw8x
        nyvlPDIfQR7JPLWuAFcqhh78zWCjYgPreA==
X-Google-Smtp-Source: ABdhPJyziCn0HYlzwyZ4QE4+JtVk326x9LGLbedj64ej7q+du4972UCKmNvWDEOVZBb+dTaMqgf6XQ==
X-Received: by 2002:a17:906:33d0:: with SMTP id w16mr16546484eja.376.1627300793211;
        Mon, 26 Jul 2021 04:59:53 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49ed:6f00:7449:2292:4806:d4e5])
        by smtp.gmail.com with ESMTPSA id y8sm731408eds.91.2021.07.26.04.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:59:52 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 2/2] block/rnbd: Use sysfs_emit instead of s*printf function for sysfs show
Date:   Mon, 26 Jul 2021 13:59:50 +0200
Message-Id: <20210726115950.470543-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726115950.470543-1-jinpu.wang@ionos.com>
References: <20210726115950.470543-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@ionos.com>

sysfs_emit function was added to be aware of the PAGE_SIZE maximum of
the temporary buffer used for outputting sysfs content, so there is no
possible overruns. So replace the uses of any s*printf functions for
the sysfs show functions with sysfs_emit.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 33 +++++++++++++----------------
 drivers/block/rnbd/rnbd-srv-sysfs.c | 14 ++++++------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 324afdd63a96..4b93fd83bf79 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -227,17 +227,17 @@ static ssize_t state_show(struct kobject *kobj,
 
 	switch (dev->dev_state) {
 	case DEV_STATE_INIT:
-		return snprintf(page, PAGE_SIZE, "init\n");
+		return sysfs_emit(page, "init\n");
 	case DEV_STATE_MAPPED:
 		/* TODO fix cli tool before changing to proper state */
-		return snprintf(page, PAGE_SIZE, "open\n");
+		return sysfs_emit(page, "open\n");
 	case DEV_STATE_MAPPED_DISCONNECTED:
 		/* TODO fix cli tool before changing to proper state */
-		return snprintf(page, PAGE_SIZE, "closed\n");
+		return sysfs_emit(page, "closed\n");
 	case DEV_STATE_UNMAPPED:
-		return snprintf(page, PAGE_SIZE, "unmapped\n");
+		return sysfs_emit(page, "unmapped\n");
 	default:
-		return snprintf(page, PAGE_SIZE, "unknown\n");
+		return sysfs_emit(page, "unknown\n");
 	}
 }
 
@@ -263,7 +263,7 @@ static ssize_t mapping_path_show(struct kobject *kobj,
 
 	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
 
-	return scnprintf(page, PAGE_SIZE, "%s\n", dev->pathname);
+	return sysfs_emit(page, "%s\n", dev->pathname);
 }
 
 static struct kobj_attribute rnbd_clt_mapping_path_attr =
@@ -276,8 +276,7 @@ static ssize_t access_mode_show(struct kobject *kobj,
 
 	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
 
-	return snprintf(page, PAGE_SIZE, "%s\n",
-			rnbd_access_mode_str(dev->access_mode));
+	return sysfs_emit(page, "%s\n", rnbd_access_mode_str(dev->access_mode));
 }
 
 static struct kobj_attribute rnbd_clt_access_mode =
@@ -286,8 +285,8 @@ static struct kobj_attribute rnbd_clt_access_mode =
 static ssize_t rnbd_clt_unmap_dev_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *page)
 {
-	return scnprintf(page, PAGE_SIZE, "Usage: echo <normal|force> > %s\n",
-			 attr->attr.name);
+	return sysfs_emit(page, "Usage: echo <normal|force> > %s\n",
+			  attr->attr.name);
 }
 
 static ssize_t rnbd_clt_unmap_dev_store(struct kobject *kobj,
@@ -357,9 +356,8 @@ static ssize_t rnbd_clt_resize_dev_show(struct kobject *kobj,
 					 struct kobj_attribute *attr,
 					 char *page)
 {
-	return scnprintf(page, PAGE_SIZE,
-			 "Usage: echo <new size in sectors> > %s\n",
-			 attr->attr.name);
+	return sysfs_emit(page, "Usage: echo <new size in sectors> > %s\n",
+			  attr->attr.name);
 }
 
 static ssize_t rnbd_clt_resize_dev_store(struct kobject *kobj,
@@ -390,8 +388,7 @@ static struct kobj_attribute rnbd_clt_resize_dev_attr =
 static ssize_t rnbd_clt_remap_dev_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *page)
 {
-	return scnprintf(page, PAGE_SIZE, "Usage: echo <1> > %s\n",
-			 attr->attr.name);
+	return sysfs_emit(page, "Usage: echo <1> > %s\n", attr->attr.name);
 }
 
 static ssize_t rnbd_clt_remap_dev_store(struct kobject *kobj,
@@ -436,7 +433,7 @@ static ssize_t session_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
 
-	return scnprintf(page, PAGE_SIZE, "%s\n", dev->sess->sessname);
+	return sysfs_emit(page, "%s\n", dev->sess->sessname);
 }
 
 static struct kobj_attribute rnbd_clt_session_attr =
@@ -499,8 +496,8 @@ static ssize_t rnbd_clt_map_device_show(struct kobject *kobj,
 					 struct kobj_attribute *attr,
 					 char *page)
 {
-	return scnprintf(page, PAGE_SIZE,
-			 "Usage: echo \"[dest_port=server port number] sessname=<name of the rtrs session> path=<[srcaddr@]dstaddr> [path=<[srcaddr@]dstaddr>] device_path=<full path on remote side> [access_mode=<ro|rw|migration>] [nr_poll_queues=<number of queues>]\" > %s\n\naddr ::= [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]\n",
+	return sysfs_emit(page,
+			  "Usage: echo \"[dest_port=server port number] sessname=<name of the rtrs session> path=<[srcaddr@]dstaddr> [path=<[srcaddr@]dstaddr>] device_path=<full path on remote side> [access_mode=<ro|rw|migration>] [nr_poll_queues=<number of queues>]\" > %s\n\naddr ::= [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]\n",
 			 attr->attr.name);
 }
 
diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index acf5fced11ef..4db98e0e76f0 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -90,8 +90,8 @@ static ssize_t read_only_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
 
-	return scnprintf(page, PAGE_SIZE, "%d\n",
-			 !(sess_dev->open_flags & FMODE_WRITE));
+	return sysfs_emit(page, "%d\n",
+			  !(sess_dev->open_flags & FMODE_WRITE));
 }
 
 static struct kobj_attribute rnbd_srv_dev_session_ro_attr =
@@ -105,8 +105,8 @@ static ssize_t access_mode_show(struct kobject *kobj,
 
 	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
 
-	return scnprintf(page, PAGE_SIZE, "%s\n",
-			 rnbd_access_mode_str(sess_dev->access_mode));
+	return sysfs_emit(page, "%s\n",
+			  rnbd_access_mode_str(sess_dev->access_mode));
 }
 
 static struct kobj_attribute rnbd_srv_dev_session_access_mode_attr =
@@ -119,7 +119,7 @@ static ssize_t mapping_path_show(struct kobject *kobj,
 
 	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
 
-	return scnprintf(page, PAGE_SIZE, "%s\n", sess_dev->pathname);
+	return sysfs_emit(page, "%s\n", sess_dev->pathname);
 }
 
 static struct kobj_attribute rnbd_srv_dev_session_mapping_path_attr =
@@ -128,8 +128,8 @@ static struct kobj_attribute rnbd_srv_dev_session_mapping_path_attr =
 static ssize_t rnbd_srv_dev_session_force_close_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *page)
 {
-	return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
-			 attr->attr.name);
+	return sysfs_emit(page, "Usage: echo 1 > %s\n",
+			  attr->attr.name);
 }
 
 static ssize_t rnbd_srv_dev_session_force_close_store(struct kobject *kobj,
-- 
2.25.1

