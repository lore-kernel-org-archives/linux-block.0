Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32474C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FF2218FE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116688;
	bh=gJVLxUMzDGBroea7dXJ264VB3+1NpwmAF9TlXaTQB6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aYasapEhX95ISCAJ5QbxiFQ1t1ePDaRoYfp5xEvhyenziZ1rVgWTvNzze+2ir4AOh
	 sawu0hnGcBj7+ucvyeBu6SObt4kZbX6zoirnluVBgJjUrasFXtaWWJ0wc6TpiX6EKY
	 QQkE5y+X9YHy76ZetOGtddwJtHCcvqdJi9MfXEOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfDXOiB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbfDXOfa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 10:35:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 335E6218FE;
        Wed, 24 Apr 2019 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116529;
        bh=gJVLxUMzDGBroea7dXJ264VB3+1NpwmAF9TlXaTQB6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgzUcUTfwStFecIT2tknPj/YV9GeA9QW2uSfveKc8vHjsTLhRLKGTesKYBCbsdWaT
         v3Qf2i2P4GXlYQIweuelO6nlDWIf0Fio6JrLbSjmZlK+kb9R5M16Gl7oZCNNxdDFlD
         nMAAFSmtB0ocjwxNdORYSBdl5RXbbH0sCUlehq/0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 44/66] blk-mq: do not reset plug->rq_count before the list is sorted
Date:   Wed, 24 Apr 2019 10:33:18 -0400
Message-Id: <20190424143341.27665-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit bcc816dfe51ab86ca94663c7b225f2d6eb0fddb9 ]

We would never be able to sort the list if we first reset plug->rq_count
which is used in conditional check later.

Fixes: ce5b009cff19 ("block: improve logic around when to sort a plug list")
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 97eba6d23425..5a2585d69c81 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1716,11 +1716,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	unsigned int depth;
 
 	list_splice_init(&plug->mq_list, &list);
-	plug->rq_count = 0;
 
 	if (plug->rq_count > 2 && plug->multiple_queues)
 		list_sort(NULL, &list, plug_rq_cmp);
 
+	plug->rq_count = 0;
+
 	this_q = NULL;
 	this_hctx = NULL;
 	this_ctx = NULL;
-- 
2.19.1

