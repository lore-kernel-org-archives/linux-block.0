Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3377AC07E9D
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 10:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A33161026
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 10:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhGSKMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 06:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbhGSKMu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 06:12:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FFFC061574
        for <linux-block@vger.kernel.org>; Mon, 19 Jul 2021 03:01:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g16so21473806wrw.5
        for <linux-block@vger.kernel.org>; Mon, 19 Jul 2021 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMVdrbFUkjN6L9xaCijnChj/XzH7nF/facsqGidaGH4=;
        b=PJirtIIcfA7z6xW/sJmcRAAumFKPKpQNTwz8Q/Lx/eathVzfba4mCfu1cIvbZF+X5m
         dueGewDgJddEcsL/97V09kMo0+ryFsNEMhpxkJAVHLvg9GLDyPEVCwu9J5aEk4qFBvL+
         tqWi7h0q1WZf5r3xqOlWZvfHIFZYai2GWD/GszTgxj0KsuICkCB4R3pgsTKO0Mjvm4Pw
         oEeW4Q9xW+pINOCH/dHP6d7/E3XDqfNov3WraI3TnrJrI4NqoLn7F26NH+JdyskS/NhA
         VnThUyFqxfoo5Ht95oX1y8pS/ecs08//ih8r4HiBCZrTVmjUmO4jmz7Hd7d7SwvvVpEp
         0CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMVdrbFUkjN6L9xaCijnChj/XzH7nF/facsqGidaGH4=;
        b=m3+iqYgWMsZp+uFp7Jp3mPwcFZpXyCsNwcrmQS0bi/b4Bat5mvT7xehSvji1vnlgKC
         SMoT9ned87eI+YH6/Eb70foUkDb5y//O5DeA7Q88ldAI2gsN/YHWBOynn1R4z448anCE
         o+DUhDSHtlQ8BspAohZpzdv9M4FqkCBzla9o9nwm98pEuIJq01zsLum8THOfl6QKsWCl
         /va3rpP4Qw3pCUwfyuZYCZMlKZRU5nqp/F+gyatFMSHzuI2J/kVaRX5enUs8OwcCLuku
         Sm77xIUETypDTHU7lm0Q+eIy0leL56Ln2Ds3A2HSaKBlvTgubYXxnpN45GRuoNrwD7OI
         OVHQ==
X-Gm-Message-State: AOAM533RPi3D3ZvTcOiZ5EP0yN3QXRy/uclOuYd9IBWAQXdEgEOmIB1S
        20kZT9vfJVKhCARipLzaYjY=
X-Google-Smtp-Source: ABdhPJx2az5Kk21AngRfNJvO0LS35h4i5ix5tpUPpgsBgf4ADT5AdnHNpjKV2vqoxAHNyYqL0l5vNw==
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr28538332wrv.323.1626692008230;
        Mon, 19 Jul 2021 03:53:28 -0700 (PDT)
Received: from localhost.localdomain ([148.252.132.204])
        by smtp.gmail.com with ESMTPSA id j16sm19676719wrw.62.2021.07.19.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 03:53:27 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     asml.silence@gmail.com, Keith Busch <kbusch@kernel.org>
Subject: [RFC] bio: fix page leak bio_add_hw_page failure
Date:   Mon, 19 Jul 2021 11:53:00 +0100
Message-Id: <1edfa6a2ffd66d55e6345a477df5387d2c1415d0.1626653825.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__bio_iov_append_get_pages() doesn't put not appended pages on
bio_add_hw_page() failure, so potentially leaking them, fix it. Also, do
the same for __bio_iov_iter_get_pages(), even though it looks like it
can't be triggered by userspace in this case.

Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
Cc: stable@vger.kernel.org # 5.8+
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

I haven't tested the fail path, thus RFC. Would be great if someone can
do it or take over the fix.

 block/bio.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1fab762e079b..d95e3456ba0c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -979,6 +979,14 @@ static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *iter)
 	return 0;
 }
 
+static void bio_put_pages(struct page **pages, size_t size, size_t off)
+{
+	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
+
+	for (i = 0; i < nr; i++)
+		put_page(pages[i]);
+}
+
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
 
 /**
@@ -1023,8 +1031,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			if (same_page)
 				put_page(page);
 		} else {
-			if (WARN_ON_ONCE(bio_full(bio, len)))
-                                return -EINVAL;
+			if (WARN_ON_ONCE(bio_full(bio, len))) {
+				bio_put_pages(pages + i, left, offset);
+				return -EINVAL;
+			}
 			__bio_add_page(bio, page, len, offset);
 		}
 		offset = 0;
@@ -1069,6 +1079,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 		len = min_t(size_t, PAGE_SIZE - offset, left);
 		if (bio_add_hw_page(q, bio, page, len, offset,
 				max_append_sectors, &same_page) != len) {
+			bio_put_pages(pages + i, left, offset);
 			ret = -EINVAL;
 			break;
 		}
-- 
2.32.0

