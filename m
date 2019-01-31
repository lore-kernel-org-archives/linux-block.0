Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDE4C282D7
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 01:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD8220989
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 01:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B03Rrf0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfAaBLK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:11:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43354 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaBLK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 20:11:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so659269plb.10;
        Wed, 30 Jan 2019 17:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GyEcPoXgNXrtjeMYiCYnP5UTpN6S7ZaIihBq844d7Lk=;
        b=B03Rrf0dthPdoHdErqn3Q+xokGwZLuA7O3ewO8AmoONLlTTJfzpQCd20OrKx0ODd1w
         Hu6eP4+DU6TVMq/IMz/xraJ8mebjs1EuRlYEs3XJFSl5uqgkScxIZzuASwQYSAaKsPkP
         nVuCMDVzZi41/qWyoJwJ4Cuh5s8ocbpz9Pu/Htjw0cXXcdzzU8tUbJwerQCHj1MDLW6Y
         sLBs2tuZz+fDeVYOlu+vMQET5pxyCB9eZJNWa0sBNv9XwL7QUvgop9f3xe9IpFgGRk7+
         QFT9L0YxoyxhO6MKkJUNNOatuHOcFVyVPyEQi20/tmnc+hlv4HfiAR8vVPmrNcAP2HX9
         FYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GyEcPoXgNXrtjeMYiCYnP5UTpN6S7ZaIihBq844d7Lk=;
        b=qrWFeRMkbChxV4tlVVX5OfafDWygS5S6rXbPjDlthsTHjF3RqCbW2VbijT9IyhXLsS
         +uNh9qoyFXLtCdJ1itDXqBtD+PNpsv64kNciYDk8CuMq6AtOz2Y9QXXuBH66C5rgsoaK
         WiaD201qhUvviO3aGhWg9IJkDcu0oJhQz605cgGE+UaqVaLIsmfPFxyFSDTLvX0Ryu2e
         DtyfTPuPfCVCHz8hFnAdqOv3jkvAHIjv1PCdfsEkC/NK/Jq2ATMnLZr41PGBBQtM6LHO
         sf+HmejqylZkCsZcQIRixu36F7ocKh3uCWI/eu81bnO1UqPDF3ghQ7YOmMTfoI4IhZ1G
         ++Gw==
X-Gm-Message-State: AJcUuke5jO+nDSPVbjD9tgF/y3O7QPLZx3O/nb5WSQm0SChL5wx1gSg7
        GljygqAU7sz+US2GLcLolf+BdvyTtAw=
X-Google-Smtp-Source: ALg8bN4l58W8UzAKwAn+20cMbOKxw68EXKciQ3Q2luPhS/yZoVLLvJOIzO80A1dIjcW0Ykitkmc09w==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr30749390pls.124.1548897068856;
        Wed, 30 Jan 2019 17:11:08 -0800 (PST)
Received: from bebop.suse.de ([179.185.209.200])
        by smtp.gmail.com with ESMTPSA id d18sm4308642pfj.47.2019.01.30.17.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 17:11:07 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH] blk-sysfs: Rework documention of __blk_release_queue
Date:   Wed, 30 Jan 2019 23:11:39 -0200
Message-Id: <20190131011139.2264742-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The Notes section of the comment was removed, because now
blk_release_queue can only be executed from blk_cleanup_queue (being
called when the q->kobj reaches zero), and also blk_init_queue was removed
in a1ce35fa4985.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 This is basically a v2 of https://lkml.org/lkml/2019/1/14/1098

 But, I tried to describe when this function is called, removing redundancies.
 Maybe it would be better placed in blk-core.c, where the q->kobj is initialized
 with blk_queue_ktype (which .release pointer points to blk_release_queue)?

 block/blk-sysfs.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 590d1ef2f961..d4dea9179fa6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -817,21 +817,16 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 }
 
 /**
- * __blk_release_queue - release a request queue when it is no longer needed
+ * __blk_release_queue - release a request queue
  * @work: pointer to the release_work member of the request queue to be released
  *
  * Description:
- *     blk_release_queue is the counterpart of blk_init_queue(). It should be
- *     called when a request queue is being released; typically when a block
- *     device is being de-registered. Its primary task it to free the queue
- *     itself.
- *
- * Notes:
- *     The low level driver must have finished any outstanding requests first
- *     via blk_cleanup_queue().
- *
- *     Although blk_release_queue() may be called with preemption disabled,
- *     __blk_release_queue() may sleep.
+ *     This function is called when a block device is being de-registered. The
+ *     process of releasing a request queue starts with blk_cleanup_queue, which
+ *     set the appropriate flags and the calls blk_put_queue, that decrements
+ *     the reference counter of the request queue. Once the reference counter
+ *     of the request queue reaches zero, blk_release_queue is called to release
+ *     all allocated resources of the request queue.
  */
 static void __blk_release_queue(struct work_struct *work)
 {
-- 
2.16.4

