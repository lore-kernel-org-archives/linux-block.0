Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD9C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0600920868
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="01+LZ4pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0600920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeK3Gkp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:40:45 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38280 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK3Gkp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:40:45 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so2557241ioj.5
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=4tiF8sgr+ZepUWVY+ZETNvJLh7RwgDFnbSWL867I2uQ=;
        b=01+LZ4pPMNvI4YvSSLDigAyl4UpgpGlWE8V0PGKHOuEJzsolXxgI7yEk7x/lESjFd3
         /lUzTb9hXCbewyb3gXd5k18hMuhpJRyiTrdnk5epRnszVLcYhmgeLOlyrIFYf77QVyCK
         UuCa9usYdQUdNUllhLRyxdCRAKyKpcvZ7kmb0p4aq7n9dod0D5SWgweyR12XqqqQNVvj
         bf8wzT2p05WiSslEhQ6r2akjwIjzh/RVKWSfBm4lpNPvip6l/nMbyKvkEuXJdvpgYT8y
         2ClLE3Cu7WkERUUAabtWYJRdEf2wDABMtlrCploRtQ/b/1e3fXzMeI8oTEqL7E58ErlQ
         8pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=4tiF8sgr+ZepUWVY+ZETNvJLh7RwgDFnbSWL867I2uQ=;
        b=eWSGCXYKqrRMOjPGiEjYTPjdDHbFGkaVs0/eEHkzf2Hb7Y9f1BxqBUL2WKahtK1IXG
         v7I6twZPr7t/dkCE+NVFA+mqveJRZPPzmlSTEFZ4gFiRHOpMFB3nS/ekUoKGYMLphgx5
         MB3MI8yUG/yjnTcL+xcfsry/7jx1zBzHN+xoUHnLm48CLaF6iv240xAfUCCrWUc4NXBK
         vjQWMWYHmtTEmINPICAvs0QAqrrj/WobeR6EkJvUCIAgGCBKH9vO1oXf2BAaO3ARbPt2
         sRw2RETXxL5aDhZIi9NfOPiHftROkeAWBItL39LgGyGj7xSsMeEg5b8tZJLa+ltqbCM2
         BtfA==
X-Gm-Message-State: AA+aEWa487DMu2JKkZUvhXA9VkTA9Fslh0bFpwpDJ+bCMC/UopQRC5iZ
        CkmoAXRMect+KYEj3HVaK9GcHGRdP8Y=
X-Google-Smtp-Source: AFSGD/WcNUTDbP4+JI0PrgPCmgSuNbkA3LvBvC9OPKJaYMvFSQRVqykm1nhVel2cfz5ZvMBg9Lx3hA==
X-Received: by 2002:a5e:d702:: with SMTP id v2mr2152213iom.17.1543520054210;
        Thu, 29 Nov 2018 11:34:14 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a24sm959219ioc.45.2018.11.29.11.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:34:13 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Omar Sandoval <osandov@osandov.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] sbitmap: don't loop for find_next_zero_bit() for !round_robin
Message-ID: <de7c5294-7f97-6fa9-9729-66992a58a1db@kernel.dk>
Date:   Thu, 29 Nov 2018 12:34:12 -0700
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
bit looping.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index fdd1b8aa8ac6..2987b2ac8ed7 100644
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
@@ -130,12 +139,8 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
 
 		/* Jump to next index. */
 		index++;
-		alloc_hint = index << sb->shift;
-
-		if (index >= sb->map_nr) {
+		if (index >= sb->map_nr)
 			index = 0;
-			alloc_hint = 0;
-		}
 	}
 
 	return nr;

-- 
Jens Axboe

