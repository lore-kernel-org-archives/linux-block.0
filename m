Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A55C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 13:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E2B61212
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 13:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJUNdP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhJUNdO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 09:33:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21EC0613B9;
        Thu, 21 Oct 2021 06:30:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso7238498wmn.1;
        Thu, 21 Oct 2021 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E65W5rHcRhwN48L7vjwZwLiwyU/1qg2FCqyrEx/BzFo=;
        b=A4Db4wOCuN4vfKzOeCn6fAKweaT7ITHTa5kuw6/YGTHV6ttOFo4kWjnssYmv6jaMRF
         Gfdn8DL2mVcKkW0lSly0/ROor4GCHXnrCLqdMfxgfi3dJ1lKXAXAf6tMX5QCfQidGUDE
         0OaQh9/xTdsXXR7jMZFU2Vsz5Yrrt0HFMwWABV7sPUbhezb/e0+SDUu34ytTTM1T3FG4
         PBSpUjg0jhAn+7XY7icgULt3E/wMvO9xuUvG04YXVTZSuix9L23CxbxMWIA2TAsWijzO
         AkTTnnvjdR30umdjFNPLqg2mgn63z4bcPUh7IsIP5FGG7JXHe7aus0aVs38HCSbJj5O4
         vuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E65W5rHcRhwN48L7vjwZwLiwyU/1qg2FCqyrEx/BzFo=;
        b=wcgICp9Ko9rE04KNGLE8oELhn7Xvwn08sNdrN9AtlO6K6oou2jJNlVgF9Q0q2M5eVM
         2i6rfxc1aRKoAjRDKJ5phH9epn03tXEWhwK4vWccGi8KnOEhrefjeUjUHZ0xdttR0eqQ
         mfGZsOiqg16Qn9ynPLFeNvjlMIfEeqgjgv1xiGfMhsye8obz/WAOHOByO53bd/IOyyts
         bBHEyV+Evm++PAYi5a4LKUwZ/uTYITUgQD/O/B5FRQh8D6U1yRjWTQ73XDx3I0BKexcS
         HCXNirjVdqZ6GIfDrxqAzhv/Xq+UQqPxuIrJj5iVfOPUO6sqUo93cnfH8jmRPjICfHM1
         EkWA==
X-Gm-Message-State: AOAM531k03sy1ZJJyty71QGYy9bbYYeBiE5lG+rLF54C/In8OD0ml6/F
        c7/L51E43PibN5Lp+LhqIYezUTYgaHNMyA==
X-Google-Smtp-Source: ABdhPJyNo19TUXl1tAqCwlEvPsAOMdycnYyGTzCu7W5uXLrZT4E7XWnC+iUocVNRyw6J8dkZ2OfdNw==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr6721166wmc.24.1634823056793;
        Thu, 21 Oct 2021 06:30:56 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id q188sm1753987wma.1.2021.10.21.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:30:56 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 1/2] percpu_ref: percpu_ref_tryget_live() version holding RCU
Date:   Thu, 21 Oct 2021 14:30:51 +0100
Message-Id: <3066500d7a6eb3e03f10adf98b87fdb3b1c49db8.1634822969.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634822969.git.asml.silence@gmail.com>
References: <cover.1634822969.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add percpu_ref_tryget_live_rcu(), which is a version of
percpu_ref_tryget_live() but the user is responsible for enclosing it in
a RCU read lock section.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/percpu-refcount.h | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index ae16a9856305..b31d3f3312ce 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -266,6 +266,28 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
 	return percpu_ref_tryget_many(ref, 1);
 }
 
+/**
+ * percpu_ref_tryget_live_rcu - same as percpu_ref_tryget_live() but the
+ * caller is responsible for taking RCU.
+ *
+ * This function is safe to call as long as @ref is between init and exit.
+ */
+static inline bool percpu_ref_tryget_live_rcu(struct percpu_ref *ref)
+{
+	unsigned long __percpu *percpu_count;
+	bool ret = false;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (likely(__ref_is_percpu(ref, &percpu_count))) {
+		this_cpu_inc(*percpu_count);
+		ret = true;
+	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
+		ret = atomic_long_inc_not_zero(&ref->data->count);
+	}
+	return ret;
+}
+
 /**
  * percpu_ref_tryget_live - try to increment a live percpu refcount
  * @ref: percpu_ref to try-get
@@ -283,20 +305,11 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
  */
 static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 {
-	unsigned long __percpu *percpu_count;
 	bool ret = false;
 
 	rcu_read_lock();
-
-	if (__ref_is_percpu(ref, &percpu_count)) {
-		this_cpu_inc(*percpu_count);
-		ret = true;
-	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
-		ret = atomic_long_inc_not_zero(&ref->data->count);
-	}
-
+	ret = percpu_ref_tryget_live_rcu(ref);
 	rcu_read_unlock();
-
 	return ret;
 }
 
-- 
2.33.1

