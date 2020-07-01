Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC3C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DF4206A1
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 08:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgGAIKR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:10:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59528 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728143AbgGAIKQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 04:10:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 35897AED521D87ABDEB2;
        Wed,  1 Jul 2020 16:10:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Jul 2020 16:10:08 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <bvanassche@acm.org>, <osandov@fb.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] sbitmap: Consider cleared bits in sbitmap_bitmap_show()
Date:   Wed, 1 Jul 2020 16:06:25 +0800
Message-ID: <1593590785-191512-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sbitmap works by maintaining separate bitmaps of set and cleared bits.
The set bits are cleared in a batch, to save the burden of continuously
locking the "word" map to unset.

sbitmap_bitmap_show() only shows the set bits (in "word"), which is not
too much use, so mask out the cleared bits.

Fixes: ea86ea2cdced ("sbitmap: ammortize cost of clearing bits")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index af88d1346dd7..267aa7709416 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -292,8 +292,11 @@ void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m)
 
 	for (i = 0; i < sb->map_nr; i++) {
 		unsigned long word = READ_ONCE(sb->map[i].word);
+		unsigned long cleared = READ_ONCE(sb->map[i].cleared);
 		unsigned int word_bits = READ_ONCE(sb->map[i].depth);
 
+		word &= ~cleared;
+
 		while (word_bits > 0) {
 			unsigned int bits = min(8 - byte_bits, word_bits);
 
-- 
2.26.2

