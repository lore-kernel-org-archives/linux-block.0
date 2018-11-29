Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8B4C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555B621019
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="boDtcOV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555B621019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbeK3GyY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:54:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38456 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3GyY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:54:24 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so5621528ith.3
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 11:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=thTdPhhYpg1xG2DaqyjbKyvqAQeuqNS8PYcMjoyo5tg=;
        b=boDtcOV+7+pqH2KkpGk29DHZC+HTm54JwlMYpP+JfBLfiBpwl1kxz0hIQ8YydN5OOe
         zpiQLUEOGqwJf1ohlP1Kth7Ig8CDtVqha3j3xkqw5JlY257n2vzI4as+MbeksbnzV2vA
         nGk2mCPA3xbS5FovKhYpefNbmaF1+8MC7l8wGDcLKhI7muv+w2EaN5YpZjxnqWxR9Ws8
         XurrWtgZxInSqNWQH9H/cT6mBymNxICQQ+oIJXFkUj5n69LbLYxyYlD78WFphE+jumAY
         T7VetRceqzoWB1Jy/RGRe+1vtJOXQDP+HuDRpo+zedzNHUcJUkFgyOF04PINsk9bCfxh
         mpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=thTdPhhYpg1xG2DaqyjbKyvqAQeuqNS8PYcMjoyo5tg=;
        b=OIy8UkZpsnu2nE7zMXmzcYJmgqv660B33ag+hsaSadIHnXwPS+l4Lar1kqOZpA+VnW
         5NjvadoDAcXubRbx2hECzA74KISnFXcIcpoYLUOxshscgjswWeDGLJWYIgXq7KmY88fr
         kgZbR2Mqa28eTSIlw/VFwCTlcFSzLr+z1z3GjJcXpSQPJVcJ9sAlGGamxnzfm3RXu7Iq
         nYK8lzZD2kXfr7QdIJV38c+C/QiylMi9uFVcGIJfoCXXRkzvQrMZgI9V8k52onjRC0KG
         lzjBZMuJkXeT5hmAJjGiGPQ3qs3iw6yRJbogyA7w95D6JT+blmMmBvwTNyfdKnqgnbwF
         tZVQ==
X-Gm-Message-State: AA+aEWYa3HEhMb23Gqvh669FxLPgyS9WC09Jq5qCswlnqGYDSMRYtZF6
        kkWp0jdk5AcvWLWsKY1bO0vbvE+9syw=
X-Google-Smtp-Source: AFSGD/WpFPV/5PQbePEIzrZfz9tAaYUYk8uJzBReuyfeJh5PW5PK3k/7ch216IkdGaXehrJ8MaljIQ==
X-Received: by 2002:a24:a642:: with SMTP id r2-v6mr2830962iti.55.1543520871241;
        Thu, 29 Nov 2018 11:47:51 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q9sm1022457ioh.32.2018.11.29.11.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:47:50 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Omar Sandoval <osandov@osandov.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] sbitmap: don't loop for find_next_zero_bit() for
 !round_robin
Message-ID: <c9fd77ea-bbba-500d-804f-0e11e48993f3@kernel.dk>
Date:   Thu, 29 Nov 2018 12:47:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we aren't forced to do round robin tag allocation, just use the
allocation hint to find the index for the tag word, don't use it for the
offset inside the word. This avoids a potential extra round trip in the
bit looping, and since we're fetching this cacheline, we may as well
check the whole word from the start.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Since v1:

- Reset alloc_hint if we loop for the round-robin case
- Update commit message

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index fdd1b8aa8ac6..45cab6bbc1c7 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -118,10 +118,19 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 
 	index = SB_NR_TO_INDEX(sb, alloc_hint);
 
+	/*
+	 * Unless we're doing round robin tag allocation, just use the
+	 * alloc_hint to find the right word index. No point in looping
+	 * twice in find_next_zero_bit() for that case.
+	 */
+	if (round_robin)
+		alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
+	else
+		alloc_hint = 0;
+
 	for (i = 0; i < sb->map_nr; i++) {
 		nr = __sbitmap_get_word(&sb->map[index].word,
-					sb->map[index].depth,
-					SB_NR_TO_BIT(sb, alloc_hint),
+					sb->map[index].depth, alloc_hint,
 					!round_robin);
 		if (nr != -1) {
 			nr += index << sb->shift;
@@ -129,13 +138,9 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 		}
 
 		/* Jump to next index. */
-		index++;
-		alloc_hint = index << sb->shift;
-
-		if (index >= sb->map_nr) {
+		alloc_hint = 0;
+		if (++index >= sb->map_nr)
 			index = 0;
-			alloc_hint = 0;
-		}
 	}
 
 	return nr;
-- 
Jens Axboe

