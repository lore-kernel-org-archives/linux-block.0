Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE115C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 17:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C20F21736
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 17:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laa7rfJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfBJRWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:22:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35507 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfBJRWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 12:22:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id p48so8198301qtk.2;
        Sun, 10 Feb 2019 09:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+BGbKnzjyDx8WuUGVQrygvBh91FJ8/nYvqrgX2NjAj8=;
        b=laa7rfJ3/aup8ab17Zmd4IqSonpVX4q4GmV4QcO8/ZeAtFCpVZbm05N9FHp2qY2gaB
         KxK+DnB6uMcbXi0tSrKoxlLbpd1MSyL1Bn1ISm08H0Jbm3pcZWtrTgmvNJO6gVZ+6OMU
         0xIi5dhyZVvO7ggy6an+YNqpCRJdo4FVKeN18lZO8cPtMIVd2bJuQGuof3IzWCWFwcqX
         P7emHGapxib4kSg3DTm79MxgGe6gXgPyzYrLM8BPq4Bn3d0r+dcc5tY6UZl47ibvGx1l
         7RLlpumcAOK/7N4Kmlb7krm2T74/JWvvO3VDAQawK7Nq3+dvCcnY2a0xXncRVAV4mmTn
         rtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+BGbKnzjyDx8WuUGVQrygvBh91FJ8/nYvqrgX2NjAj8=;
        b=enbEBnBcXmXrr3XTXRvPfE/lt8ambu+jdqKQ//fk8xMeoRktW13OahLSfNTK3hI06G
         qoHHrX9JJBGKqWM/ksdknuPa39yEigiiUSd5BKfRQnsB/E8gJBCISbjl1Otj72l5od6/
         A6Oe0+KR9bDIaxP6u5N8bAuR4CcqlawyZFMTvXGQWI/qYTnMlU4kopuLE+ZHzhniXjgX
         7js2Ozu++fUIg51YAEm3jlhjOPAhs7XfD2sPu7Uresn/Ff22y7RCOx2ZjpK8mKJeGTEb
         dlaMWa5d7vIh9KeeIJQOT3wL2n+69WNpezWE/OYXUpXT1sI+eu6SemZCrBk/XSSYnXyo
         RlOA==
X-Gm-Message-State: AHQUAuaDYXFSki0fMhZq0wg9Z4MvtchhLjM7HizNuy4I9RRJF1EFXbDm
        aI3RjGsZYH/RqIUNJtjLxPJEFBkKwss=
X-Google-Smtp-Source: AHgI3Ia6sf3/hhwRzRvvH7muBi5C/t53A1y9Ay+8nGeBrBGPwLODmNYBJ295N27OnjUCdYsxj35WOQ==
X-Received: by 2002:ac8:4453:: with SMTP id m19mr14065268qtn.303.1549819325855;
        Sun, 10 Feb 2019 09:22:05 -0800 (PST)
Received: from localhost.localdomain (189.26.177.147.dynamic.adsl.gvt.net.br. [189.26.177.147])
        by smtp.gmail.com with ESMTPSA id e4sm6150690qkg.15.2019.02.10.09.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:22:04 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH v2] blk-sysfs: Rework documention of __blk_release_queue
Date:   Sun, 10 Feb 2019 15:22:51 -0200
Message-Id: <20190210172251.17531-1-marcos.souza.org@gmail.com>
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
 Changes from v1:
 * Typos, suggested by Jens Axboe

 block/blk-sysfs.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 590d1ef2f961..94e1b052abbc 100644
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
+ *     This function is called when a block device is being unregistered. The
+ *     process of releasing a request queue starts with blk_cleanup_queue, which
+ *     set the appropriate flags and then calls blk_put_queue, that decrements
+ *     the reference counter of the request queue. Once the reference counter
+ *     of the request queue reaches zero, blk_release_queue is called to release
+ *     all allocated resources of the request queue.
  */
 static void __blk_release_queue(struct work_struct *work)
 {
-- 
2.16.4

