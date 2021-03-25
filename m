Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6189DC433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2773361A1E
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhCYV1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhCYV1O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:14 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01C5C06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:14 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f20so4935409pgj.6
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QKM/4VqqpmQG/v1vBmAPZ1ISyc7q5p1Ut3IkXJNTNn8=;
        b=HnZP67MIz1eIz5tJHXkYxrlB8XA9q1/hNkdl64gZMD8f1fs8z86c1elcZMmZdB/nuX
         6P9jm3LlxYD5GOYi1ujnffTpXxivasaXLyKswn65Ol5OPrEAi4wI+/A+FnJp6E0f8D5X
         3pyybitU+IYLhnjIw91JgrNv00utQRdL1aJ2lqJk0Oq1pQ/DH9vwu2ndEp9NpmewwOm5
         rYqa+yhnRYdPlvSaHasT2eg0tUjqw7DT+LVWuIja4ZNs7XWUzSFNovoUHtL76JTah/x5
         LEudfg6bZ1EC6cESObW51z9UUaOazOTGb56yvMbwSYZtgrDGBpxLWOJWOLP9huNS/pv6
         Ud3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QKM/4VqqpmQG/v1vBmAPZ1ISyc7q5p1Ut3IkXJNTNn8=;
        b=BC8D8pQyPei8vpCDJgYFhrVRMT+mRYA4oktuvDZrcjHxorTMdZSpClOTPs3XmVcpl0
         FTe62VsZBRRr+9tLLB2yV8CM3dP/G9lp0/ydJCcXjzE01TxhIyINIqnsIpXRwnZN1mTd
         QTAwnLnF1nqi+NVYxvq6gwMoEsQOOXd5x+WCamIXQ7zdr7RepqlgvB5i/q8+yTlJS44n
         31/Gg7MMwFZNEuGn8strududk5q9PSHfoRITSPTHHnQQOcLLH9JAmkHN1crjFe0XIqte
         +2jUct6KN4uvDP1fWyn8IkyLRce+YnbTL5ppaXHxVqoG3l6+23tSOmHFB9OLIfKyVXVu
         hm+w==
X-Gm-Message-State: AOAM530yCNtQYS5F+MgFAqmZWc1TttecnfyKVSBtoCnrWvrATZEasfZd
        A/MEa+W0UCBvYlRU1tW2a9c91LrojL21bSP5COWkpVtndubBvYm5sAO+PWcq15A8CgWlPF4YiG9
        jDb/x4zhCU4z8y4KVS9UStbHmh8JPuvBC4qC0hvc72Vr6IqCFaOPHk8VpGg6buj5Ho6Ob
X-Google-Smtp-Source: ABdhPJzjoTfGpe0TgBdqASEdyBajTp1H9OebPba0STb+/HWBLKkUrFjrqDgv+AdBd422n4nIJ88hy9WUxEg=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:902:56c:b029:e7:1052:a7c6 with SMTP id
 99-20020a170902056cb02900e71052a7c6mr11045345plf.75.1616707633890; Thu, 25
 Mar 2021 14:27:13 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:04 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-4-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 3/8] block: blk-crypto: introduce blk_crypto_bio_sectors_alignment()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The size of any bio must be aligned to the data unit size of the bio crypt
context (if it exists) of that bio. This must also be ensured whenever a
bio is split. Introduce blk_crypto_bio_sectors_alignment() that returns
the required alignment in sectors. The number of sectors passed to
any call of bio_split() should be aligned to
blk_crypto_bio_sectors_alignment().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-internal.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7..304e90ed99f5 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -60,6 +60,19 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+/*
+ * Returns the alignment requirement for the number of sectors in this bio based
+ * on its bi_crypt_context. Any bios split from this bio must follow this
+ * alignment requirement as well.
+ */
+static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
+{
+	if (!bio_has_crypt_ctx(bio))
+		return 1;
+	return bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size >>
+								SECTOR_SHIFT;
+}
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
@@ -93,6 +106,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return false;
 }
 
+static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
+{
+	return 1;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
-- 
2.31.0.291.g576ba9dcdaf-goog

