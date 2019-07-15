Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F198EC76191
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 15:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17852054F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563202994;
	bh=fE8MCPhaLGyGE62LvAfXF6y/04ieaUvtCQnj5FQcWUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mp94RM5GEYkELQV6Vp1QSV5vcdb4Q3zUdOE4x0WmINJsDm+5SBYEjW1+PseGE5MZJ
	 aZS0T7rD2eKocbvpDXavgX+YBtar5fsdLzUr/Sb5FMXhEAOpud+Q+10DWpRMLS9mUl
	 L2whfb8lEgyDUvybmHIxJYGCUooOenCSWngZYcw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbfGOOKR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388788AbfGOOKN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 10:10:13 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2563C2182B;
        Mon, 15 Jul 2019 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199813;
        bh=fE8MCPhaLGyGE62LvAfXF6y/04ieaUvtCQnj5FQcWUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0TjPLkAyonBmILuIo+agEiAzEtt0LShzFZtiu0VIax/DnNlyzNrkoNJ92v4YwV/VX
         ruVxZxPMPLBxjgWC4CqHXKt0cArIl8LxRMzoiQwb4wnqNaNlCcDqbbSE7cOgd0z02U
         CQSiqHllVMwJgxwHEyquL+Z44HudyVhMq2Ao4uB0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 113/219] blk-iolatency: only account submitted bios
Date:   Mon, 15 Jul 2019 10:01:54 -0400
Message-Id: <20190715140341.6443-113-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Dennis Zhou <dennis@kernel.org>

[ Upstream commit a3fb01ba5af066521f3f3421839e501bb2c71805 ]

As is, iolatency recognizes done_bio and cleanup as ending paths. If a
request is marked REQ_NOWAIT and fails to get a request, the bio is
cleaned up via rq_qos_cleanup() and ended in bio_wouldblock_error().
This results in underflowing the inflight counter. Fix this by only
accounting bios that were actually submitted.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iolatency.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 507212d75ee2..58bac44ba78a 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -599,6 +599,10 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
 		return;
 
+	/* We didn't actually submit this bio, don't account it. */
+	if (bio->bi_status == BLK_STS_AGAIN)
+		return;
+
 	iolat = blkg_to_lat(bio->bi_blkg);
 	if (!iolat)
 		return;
-- 
2.20.1

