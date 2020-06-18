Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6DCC433E3
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 01:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C389A20897
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 01:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444870;
	bh=mFoaddF+m9JiGC5ftJhBtqlH9k/GWcHFK59nfe0L50s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iBbr6Xa68RsVwj/S2HyfZIHvj16G2zvsA57x3eYXpqyNzonVXcaDv6qoBTKHGuSRt
	 3POm/v/0o9vdii/MOcfZW7NyNJ9vmxUBNtZcoNwLgM6BdXSmtxJ5XjoFR/uVxUu+Ig
	 pGD33OAMp3SoebBK2PVO2MC22oBmMzlEfpg6IHPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbgFRBr1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbgFRB2K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 21:28:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C4922203;
        Thu, 18 Jun 2020 01:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443689;
        bh=mFoaddF+m9JiGC5ftJhBtqlH9k/GWcHFK59nfe0L50s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuDnO718t1NBLRSQfGb64S+rSDKT1q3OjvUby/TVMWyL9YHbZprZE1fo8mgEFYZdd
         JnIjV43w2lu0Jqlf9ZKK0Nc5KrPj6aKehbI2vdhQLFShuPYXJ9d0//+C7/cfpE6fru
         mZA7nlwzxVI73QievjQ/fxEN2TRRWWNZiB7ySi00=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 101/108] blktrace: use errno instead of bi_status
Date:   Wed, 17 Jun 2020 21:25:53 -0400
Message-Id: <20200618012600.608744-101-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit 48bc3cd3e07a1486f45d9971c75d6090976c3b1b ]

In blk_add_trace_spliti() blk_add_trace_bio_remap() use
blk_status_to_errno() to pass the error instead of pasing the bi_status.
This fixes the sparse warning.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/blktrace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a60c09e0bda8..30a98156f474 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1022,8 +1022,10 @@ static void blk_add_trace_split(void *ignore,
 
 		__blk_add_trace(bt, bio->bi_iter.bi_sector,
 				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
-				BLK_TA_SPLIT, bio->bi_status, sizeof(rpdu),
-				&rpdu, blk_trace_bio_get_cgid(q, bio));
+				BLK_TA_SPLIT,
+				blk_status_to_errno(bio->bi_status),
+				sizeof(rpdu), &rpdu,
+				blk_trace_bio_get_cgid(q, bio));
 	}
 	rcu_read_unlock();
 }
@@ -1060,7 +1062,8 @@ static void blk_add_trace_bio_remap(void *ignore,
 	r.sector_from = cpu_to_be64(from);
 
 	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, BLK_TA_REMAP, bio->bi_status,
+			bio_op(bio), bio->bi_opf, BLK_TA_REMAP,
+			blk_status_to_errno(bio->bi_status),
 			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio));
 	rcu_read_unlock();
 }
-- 
2.25.1

