Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411A1C43217
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 20:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203796135F
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 20:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhJTUFm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhJTUFl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 16:05:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B94C06161C;
        Wed, 20 Oct 2021 13:03:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y3so49277014wrl.1;
        Wed, 20 Oct 2021 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqvGiRpysvfIvZi1p/Sn/aAVIjsT/b9K5dksSdMrSoY=;
        b=cWuRWk5S1CRqG3q/d+rkURGCqlYEvwkYRUqyTLWS4/5tF9RqNtsQGgswqhlGcRXdLu
         ZyS8TnEAh2zGEKobN7O9CDqEQGGG8m7dibMPTqZGdXRCkqhgtY6zhJ9EgLvPw/wrQ8VI
         jioysauEyb6VzpfESEelAw/bgOiXcDJLeBUGx3LpZJ549ze0pfaIiUuNME5tSOza1WcD
         SrJrEh6DuBanfO8y0QJTRVyGZHKoFEerHfrYNjCAE7w7VmWMl6YlmzmyQUo65rfPfY2f
         2TPcZWNcSYIHSSiqJzhRIrzfl7hSV7PR/RZ8MZXGQrR6O7vtWI7trLopfKAgVec3WupJ
         IddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqvGiRpysvfIvZi1p/Sn/aAVIjsT/b9K5dksSdMrSoY=;
        b=jIgXhZOK9AQFKcH10+yqtOHC0NlOpN0N70rY7iK3LLbMwtp8qIZE+yqL+H4L3KiEgV
         yhmssw0QnKAJnqtnOcfJbikMvqzQnL6hrR02w79aLm/mQ05X1M8neSpeGsn0LmiWCfB6
         8wZJV66ecxAhGGHrCdEuN1GD5n0CG5yr0ioSTHgiIFsogyEmfIRSG0rtMPjaept51xiH
         w+nT2tvrE3xUeOAtxf3+CVjYO4XbVKOmWMmKxUPsXNUxGb8gJGxaOTMWcNrXBb2KnLjI
         bmMYnAqzEInBzN05Md1ohnOwlIOFGeXBDdP3Muvs02S3qGsuIoVMaCFKrsasWd2w4aqW
         vzIg==
X-Gm-Message-State: AOAM533w3zRdFFJGEzWZW78A3sexgRitTX80OQv8HteFh5hxrWj6ykEG
        Z2SlTMibguwJ6VQYhNLebC76pdnGX/k3jg==
X-Google-Smtp-Source: ABdhPJyFBwhXslFRXmjC0EbulCHD1qDNtij5tJ2u4UmyXrF3BTQbLcf8Qk11SX+HkuZyx8uWeZGsmg==
X-Received: by 2002:adf:f305:: with SMTP id i5mr1606208wro.155.1634760205048;
        Wed, 20 Oct 2021 13:03:25 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id m14sm3600119wms.25.2021.10.20.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:03:24 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/2] percpu_ref: percpu_ref_tryget_live() version holding RCU
Date:   Wed, 20 Oct 2021 21:03:18 +0100
Message-Id: <d65d6d60faf773293e5189bd2b95c7bbc034976b.1634759754.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634759754.git.asml.silence@gmail.com>
References: <cover.1634759754.git.asml.silence@gmail.com>
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
 include/linux/percpu-refcount.h | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index ae16a9856305..13e26add7d5c 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -266,6 +266,26 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
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
@@ -283,20 +303,11 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
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

