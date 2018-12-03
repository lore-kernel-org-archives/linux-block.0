Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DD2C04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 22:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1FC2145D
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 22:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="vOS4FP/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1FC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeLCWpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:45:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51774 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLCWpv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 17:45:51 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so12173044itl.1
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 14:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OIqISCEH8tVp/fKknhIcymwhSUTaEsnQQ2+seQiv4VI=;
        b=vOS4FP/CLRYsZm7jO69+hqjsaiyiI4rOq2fyyMok5tdZKm2ey1u5Q3n/K63fTo8md9
         bcXnbZZyErXuBhMEV94VLsLw0Y2pSkDE3f3rmnNFo+pz7M0IOqbt4i5+ZzERKGl63hhr
         Gr5726BTQNiNSOkpq6glIGHd45dGH+2EEqvUXeA7R7bVS89iIAkfvsodecF4xLXiAJ8J
         kokRJESburWn9ZIGRJI+upE0ZJAI95aCKbArX7OVEOk2CBfznWREuEWfN8f7y0H5RAE1
         R+wlXZmFBMFa+9lGMDwnhZytfVukTaYyVthPnDM04/KU/EDug11r7K8NfhGE+8fsEvc3
         Pk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OIqISCEH8tVp/fKknhIcymwhSUTaEsnQQ2+seQiv4VI=;
        b=UPNQ7t7Mdfz4GjoIeK6cvX/4qrNsssajVaOpSV+w5zHUOU9YZkYdoi0FgdbbzzDynD
         ZjLxau75GGGCx5Tg7lZ85VOCNzE7wj2EKq7W0651SnZyovuGPjHnwOWrJUEMdy2SO9dV
         uQqq2HjF/8k6J0S84Y24rkDGSIyrkSPuiyijQMymrWNNQDvnGgdVkhYIN5X2ajKczKRs
         s8LzDowZQfl9UQxI/2ryJlzU4+FcF4bSLD3YRPdTDZgCj4RbfWf508fA5UjC1fVHbY4v
         tSegypizStsjM5gxD2GnvKuzRBV7KRpcXIBANeI4QEKREAjSn+40gBitIgRpvX4dkAfL
         cnDg==
X-Gm-Message-State: AA+aEWa5V3tVLhFweWSH8u36fcGBid7s2yVh/sfJzTo+RRa1F1rAVcro
        McWaPSU78lL3qwRyh1Nb2ShK363aoUA=
X-Google-Smtp-Source: AFSGD/UvaQGaZTQszHQsYMjX1PqvdBMQLiDyzwXNUbS+AWYi/bNHlYD5y5pIwY6AXjN2V9ZTBDHMKg==
X-Received: by 2002:a24:e4ce:: with SMTP id o197mr2866557ith.116.1543877150089;
        Mon, 03 Dec 2018 14:45:50 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::5:8421])
        by smtp.gmail.com with ESMTPSA id z23sm6395708iob.19.2018.12.03.14.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:45:49 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, kernel-team@fb.com
Subject: [PATCH] sbitmap: fix sbitmap_for_each_set()
Date:   Mon,  3 Dec 2018 14:45:43 -0800
Message-Id: <d83eb1df09213aafdd190fde18f406d1b988af3f.1543877128.git.osandov@fb.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We need to ignore bits in the cleared mask when iterating over all set
bits.

Fixes: ea86ea2cdced ("sbitmap: ammortize cost of clearing bits")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/sbitmap.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 92806a2dbab7..03f50fcedc79 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -265,12 +265,14 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
 	nr = SB_NR_TO_BIT(sb, start);
 
 	while (scanned < sb->depth) {
-		struct sbitmap_word *word = &sb->map[index];
-		unsigned int depth = min_t(unsigned int, word->depth - nr,
+		unsigned long word;
+		unsigned int depth = min_t(unsigned int,
+					   sb->map[index].depth - nr,
 					   sb->depth - scanned);
 
 		scanned += depth;
-		if (!word->word)
+		word = sb->map[index].word & ~sb->map[index].cleared;
+		if (!word)
 			goto next;
 
 		/*
@@ -280,7 +282,7 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
 		 */
 		depth += nr;
 		while (1) {
-			nr = find_next_bit(&word->word, depth, nr);
+			nr = find_next_bit(&word, depth, nr);
 			if (nr >= depth)
 				break;
 			if (!fn(sb, (index << sb->shift) + nr, data))
-- 
2.19.2

