Return-Path: <SRS0=pi9Y=DZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51698C433E7
	for <linux-block@archiver.kernel.org>; Sun, 18 Oct 2020 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169D7206CA
	for <linux-block@archiver.kernel.org>; Sun, 18 Oct 2020 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603050065;
	bh=acmOn8DqEDhDyakHFgwde4nbqmaXmf1ElTBFFceAZyo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D3t1gGcyEvL/efnVgMD5XYjAezeaAI4wmRjDPsPsEY8pbs8lBE+YAKwBrQvm6fNI6
	 iPEGb8NxAuFEH2gElAG1LPTez+jsXGhXguklV1l3GTdyR1d+kzySh52oEHaPjVFG1h
	 dJtvZNq0uWIG+LW2mojla3liAfDkxFAKwXmqaV8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgJRTYU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbgJRTYT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Oct 2020 15:24:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE94E2137B;
        Sun, 18 Oct 2020 19:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049059;
        bh=acmOn8DqEDhDyakHFgwde4nbqmaXmf1ElTBFFceAZyo=;
        h=From:To:Cc:Subject:Date:From;
        b=L04Q6Zrc5gxwjBB9N54ITtyLYbTWuJD09dnf6Z20rfv0kfWWJ6buLUvcCu8MC0IIk
         lksPhReK3oDaXi3vwT2irbRvlcrxlTt+dI2hgcLPK6w/6JpaRRtpCG5MSoi3kvWPvT
         LZVByhpJFKrejrlcQG8Yp/XIuR98d2iONfr4mvlo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/56] block: ratelimit handle_bad_sector() message
Date:   Sun, 18 Oct 2020 15:23:22 -0400
Message-Id: <20201018192417.4055228-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit f4ac712e4fe009635344b9af5d890fe25fcc8c0d ]

syzbot is reporting unkillable task [1], for the caller is failing to
handle a corrupted filesystem image which attempts to access beyond
the end of the device. While we need to fix the caller, flooding the
console with handle_bad_sector() message is unlikely useful.

[1] https://syzkaller.appspot.com/bug?id=f1f49fb971d7a3e01bd8ab8cff2ff4572ccf3092

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ce3710404544c..445b878e35194 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2127,11 +2127,10 @@ static void handle_bad_sector(struct bio *bio, sector_t maxsector)
 {
 	char b[BDEVNAME_SIZE];
 
-	printk(KERN_INFO "attempt to access beyond end of device\n");
-	printk(KERN_INFO "%s: rw=%d, want=%Lu, limit=%Lu\n",
-			bio_devname(bio, b), bio->bi_opf,
-			(unsigned long long)bio_end_sector(bio),
-			(long long)maxsector);
+	pr_info_ratelimited("attempt to access beyond end of device\n"
+			    "%s: rw=%d, want=%llu, limit=%llu\n",
+			    bio_devname(bio, b), bio->bi_opf,
+			    bio_end_sector(bio), maxsector);
 }
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
-- 
2.25.1

