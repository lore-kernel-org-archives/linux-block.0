Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E365C43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3E4206DF
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Y1xz9B5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfEDSjW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:39:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46119 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfEDSiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so7809597ljk.13
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=111n1Q8PXGJzaoGm9JyRCPHdkkw3QXVjBFzlxnZD76A=;
        b=Y1xz9B5Tqg2VixkZD5Mh3Gm/KtlMFaA6xDtI4CoBYvmiMooJFwv+2LbBq/DJQO27P6
         D3ywHDY/B9LpL8++IlGGmKfRypitZI3vBwEJUix+tP0x28iMhM7b9xf+l1ecDWmicp9x
         50LgSjamwXXrzdRTe56oXPSTYx4lv4WOmwCClWlmWp2nEwzdxu7W8l99ITNnCbmZmvNq
         iU/hUeK78uXnynUfd2Vxep8fTiQaG9tuOwBv/pBBRy5npVjkk4ps3VZYg1F0VtODrKyc
         oKhIKr2MgdYO6S24A1VqecspnZdlbW2cbY7Krwhofku8AIs0214r8dK2nL2k2TZc5gwf
         RZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=111n1Q8PXGJzaoGm9JyRCPHdkkw3QXVjBFzlxnZD76A=;
        b=uJQaJExIh6JqjzdNI6zvO0r87WIgFy8VSzitUzkSODdVL0oaA/o72OcLWTzXbROlo0
         7Sa1ABPL9ylE+7+hzzFvoAY+gPR7RTvlNc18JhWtsTWY+vzyFVtR7WkEZIBTOZ5YWM2J
         URPtqMqdQQWQCAjhhI6sdLKqD5kBN3IXEFgjkKvsubEqCC9DEpDOu1X1TRM60/o0joUt
         ZxbkJ/jKTeTZEH0WCBikw3MPu3Sm41C9dGXWLg4HeI85TCj2q2N+YHgQlyiLnwFlm4Pw
         JhPxeleAH0JJntJA6z154oAZ/XHjMNy1DjB7kVeOd6MdEpaeDDmppzUqevNBloT59Q3A
         kY/g==
X-Gm-Message-State: APjAAAWLAEWvg69MgldVapUd0L9HO8w7SL5Y9ooawh5mAbV1nFAWaTQj
        BedkHZ9+alGDkrMP5yrmUQhg5g==
X-Google-Smtp-Source: APXvYqwGAAFAneDP3QNlgjnihVBqXmiUyQzm98O70hpqr5y9l8RQlfomyezX0AvIUpLE3uiiM5MGRA==
X-Received: by 2002:a2e:9241:: with SMTP id v1mr6645240ljg.6.1556995129283;
        Sat, 04 May 2019 11:38:49 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:48 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 23/26] lightnvm: track inflight target creations
Date:   Sat,  4 May 2019 20:38:08 +0200
Message-Id: <20190504183811.18725-24-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

When creation process is still in progress, target is not yet on
targets list. This causes a chance for removing whole lightnvm
subsystem by calling nvm_unregister() in the meantime and finally by
causing kernel panic inside target init function.

This patch changes the behaviour by adding kref variable which tracks
all the users of nvm_dev structure. When nvm_dev is allocated, kref
value is set to 1. Then before every target creation the value is
increased and decreased after target removal. The extra reference
is decreased when nvm subsystem is unregistered.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c  | 41 ++++++++++++++++++++++++++++++----------
 include/linux/lightnvm.h |  1 +
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index e2abe88a139c..0e9f7996ff1d 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -45,6 +45,8 @@ struct nvm_dev_map {
 	int num_ch;
 };
 
+static void nvm_free(struct kref *ref);
+
 static struct nvm_target *nvm_find_target(struct nvm_dev *dev, const char *name)
 {
 	struct nvm_target *tgt;
@@ -501,6 +503,7 @@ static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
 	}
 	__nvm_remove_target(t, true);
 	mutex_unlock(&dev->mlock);
+	kref_put(&dev->ref, nvm_free);
 
 	return 0;
 }
@@ -1094,15 +1097,16 @@ static int nvm_core_init(struct nvm_dev *dev)
 	return ret;
 }
 
-static void nvm_free(struct nvm_dev *dev)
+static void nvm_free(struct kref *ref)
 {
-	if (!dev)
-		return;
+	struct nvm_dev *dev = container_of(ref, struct nvm_dev, ref);
 
 	if (dev->dma_pool)
 		dev->ops->destroy_dma_pool(dev->dma_pool);
 
-	nvm_unregister_map(dev);
+	if (dev->rmap)
+		nvm_unregister_map(dev);
+
 	kfree(dev->lun_map);
 	kfree(dev);
 }
@@ -1139,7 +1143,13 @@ static int nvm_init(struct nvm_dev *dev)
 
 struct nvm_dev *nvm_alloc_dev(int node)
 {
-	return kzalloc_node(sizeof(struct nvm_dev), GFP_KERNEL, node);
+	struct nvm_dev *dev;
+
+	dev = kzalloc_node(sizeof(struct nvm_dev), GFP_KERNEL, node);
+	if (dev)
+		kref_init(&dev->ref);
+
+	return dev;
 }
 EXPORT_SYMBOL(nvm_alloc_dev);
 
@@ -1147,12 +1157,16 @@ int nvm_register(struct nvm_dev *dev)
 {
 	int ret, exp_pool_size;
 
-	if (!dev->q || !dev->ops)
+	if (!dev->q || !dev->ops) {
+		kref_put(&dev->ref, nvm_free);
 		return -EINVAL;
+	}
 
 	ret = nvm_init(dev);
-	if (ret)
+	if (ret) {
+		kref_put(&dev->ref, nvm_free);
 		return ret;
+	}
 
 	exp_pool_size = max_t(int, PAGE_SIZE,
 			      (NVM_MAX_VLBA * (sizeof(u64) + dev->geo.sos)));
@@ -1162,7 +1176,7 @@ int nvm_register(struct nvm_dev *dev)
 						  exp_pool_size);
 	if (!dev->dma_pool) {
 		pr_err("nvm: could not create dma pool\n");
-		nvm_free(dev);
+		kref_put(&dev->ref, nvm_free);
 		return -ENOMEM;
 	}
 
@@ -1184,6 +1198,7 @@ void nvm_unregister(struct nvm_dev *dev)
 		if (t->dev->parent != dev)
 			continue;
 		__nvm_remove_target(t, false);
+		kref_put(&dev->ref, nvm_free);
 	}
 	mutex_unlock(&dev->mlock);
 
@@ -1191,13 +1206,14 @@ void nvm_unregister(struct nvm_dev *dev)
 	list_del(&dev->devices);
 	up_write(&nvm_lock);
 
-	nvm_free(dev);
+	kref_put(&dev->ref, nvm_free);
 }
 EXPORT_SYMBOL(nvm_unregister);
 
 static int __nvm_configure_create(struct nvm_ioctl_create *create)
 {
 	struct nvm_dev *dev;
+	int ret;
 
 	down_write(&nvm_lock);
 	dev = nvm_find_nvm_dev(create->dev);
@@ -1208,7 +1224,12 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 		return -EINVAL;
 	}
 
-	return nvm_create_tgt(dev, create);
+	kref_get(&dev->ref);
+	ret = nvm_create_tgt(dev, create);
+	if (ret)
+		kref_put(&dev->ref, nvm_free);
+
+	return ret;
 }
 
 static long nvm_ioctl_info(struct file *file, void __user *arg)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index d3b02708e5f0..4d0d5655c7b2 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -428,6 +428,7 @@ struct nvm_dev {
 	char name[DISK_NAME_LEN];
 	void *private_data;
 
+	struct kref ref;
 	void *rmap;
 
 	struct mutex mlock;
-- 
2.19.1

