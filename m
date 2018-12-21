Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74582C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEC12192C
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="u2oqI2Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391637AbeLUTWo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:22:44 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55288 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391630AbeLUTWn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:22:43 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so8436530ita.4
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zqdn6xdQwD4/orgPmDG/qEuzoeNaehaKqwxbMi6hTAw=;
        b=u2oqI2UoaEm8eyMELctOvD3BYLDqDd58nTJa3vM0vf+3ZGr1PWyGzBw6yQ1YgFoFV3
         oaKHmzQ19XsAELUC6bItRA/5Nwuag461dYb3+B1pga0OD3s5tPeJqgcsQqj78jaioPXb
         mO+bF86rezjXVehWF/qa5tOTfx0Ju8odOd9qAnDFMRNuQ4kBbgsebRNY5TBPTMLwvg9+
         pSi7BatvwhGBxmGcHWyTZw9qk+3ET0uBDQAqLLk3ExPRz9X3qCjgCn6QDWq0MLJrZTiZ
         tmw2gqlYWl0lJZKQCJcgfMlwCrdBvhTphpHl8eX2zxreW5xf65Njm5gPbOk5/Ma6pTPK
         bMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zqdn6xdQwD4/orgPmDG/qEuzoeNaehaKqwxbMi6hTAw=;
        b=K9xt3YUOY6Ih7Kpdi35WDCFpMJsW3gW5okYGMe3OoOF2GBIEAwoBy0RzFPgqu2UgLT
         pi+H6PoTAQVL7FaD8SpIxiY0/+elHjrSHmka5g1KY/Puj4IJKu0jmOJY/IBWOnTbr4zk
         Kbnc0IPg3dfbktzoD1GTnhWLRthQ+rvMbLEdDi6vXGHwU1hKCun5S2zUyUskFMQbvA0Z
         YHicS5UiEAQRWFLLTvmKYu7q8mJGqUT3QJOSe56lFpO1oSdEXdphdUwk7dnoMTVARImm
         qutfX71D63dmM1g2JVqiBbzVlYpgISTTnz2bhpN+G78j3jZP7AdDx10hG53/tHcTVqbE
         qqMA==
X-Gm-Message-State: AA+aEWYJQgRx6pPmqJY6XO0BQWc+WBJCWf88wJNyRueC52Fa8zj0yIfb
        cojMWTJ/y9/RsQwDRSprUIQ9TQ==
X-Google-Smtp-Source: AFSGD/V0SaDcTJc8OGhIxUIMEvLGAHeV4abj33ymM1DkbXTM5APqAvfwp5bvWpa9Vb1EH3xbjqM9zw==
X-Received: by 2002:a24:b242:: with SMTP id h2mr2557944iti.2.1545420162923;
        Fri, 21 Dec 2018 11:22:42 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/22] block: add bio_set_polled() helper
Date:   Fri, 21 Dec 2018 12:22:16 -0700
Message-Id: <20181221192236.12866-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the upcoming async polled IO, we can't sleep allocating requests.
If we do, then we introduce a deadlock where the submitter already
has async polled IO in-flight, but can't wait for them to complete
since polled requests must be active found and reaped.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/bio.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7380b094dcca..f6f0a2b3cbc8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -823,5 +823,19 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+/*
+ * Mark a bio as polled. Note that for async polled IO, the caller must
+ * expect -EWOULDBLOCK if we cannot allocate a request (or other resources).
+ * We cannot block waiting for requests on polled IO, as those completions
+ * must be found by the caller. This is different than IRQ driven IO, where
+ * it's safe to wait for IO to complete.
+ */
+static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
+{
+	bio->bi_opf |= REQ_HIPRI;
+	if (!is_sync_kiocb(kiocb))
+		bio->bi_opf |= REQ_NOWAIT;
+}
+
 #endif /* CONFIG_BLOCK */
 #endif /* __LINUX_BIO_H */
-- 
2.17.1

