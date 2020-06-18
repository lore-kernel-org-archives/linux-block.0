Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639A5C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 02:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367CD206E2
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 02:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447503;
	bh=fxuDxoiJw1A3q7eocOnCf3UTJkQcjntDBa6vgDS/uLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B4SFyKi7JZeE08l5j5Ft5cDXx90EaeYDCC+NBt9oWRok8ZN5oEQcM6p3+YCJa0XgZ
	 +aaoYqWYaETdw7CWZ82w+R51ZlIhlWobUGKbWIdZ49AHkqBSo71UFrbPDlqljtqUeb
	 tpfAY104h2R5Mrzozj8vs24+ibl3lbyyFQdwkLHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgFRBP1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgFRBPZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 21:15:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150F221D79;
        Thu, 18 Jun 2020 01:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442924;
        bh=fxuDxoiJw1A3q7eocOnCf3UTJkQcjntDBa6vgDS/uLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gx5f45KtEGYSK8d+8lJCl+AV7KvsOMcDNrQMvmxbHBiHzJlQstg8z+2gsn1P0TEZo
         UV4zwb9WE68Wojeziz2Nt+GiJ2ZoH+kGu3QiHj0G50gLkIUn9gRmwt9X2dDzzItI9F
         hSvAaKp+TrtW5JC+nh9kv6gfz+k60mdZ3e+az2jo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 339/388] blktrace: use errno instead of bi_status
Date:   Wed, 17 Jun 2020 21:07:16 -0400
Message-Id: <20200618010805.600873-339-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
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
index ca39dc3230cb..c6d59a457f50 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -995,8 +995,10 @@ static void blk_add_trace_split(void *ignore,
 
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
@@ -1033,7 +1035,8 @@ static void blk_add_trace_bio_remap(void *ignore,
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

