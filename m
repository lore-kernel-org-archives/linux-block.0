Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70ECC4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 07:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9921660FA0
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 07:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhHCHGZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 03:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29605 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233677AbhHCHGY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Aug 2021 03:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627974373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L0B7QUtlv2FOnyMQ55a9J0cwwEhFix0LxlKlBBYzOVU=;
        b=dbNp49HpqmNqWuxBXM/6HQDaUof2ZMhFKtQjw0/pUbDIGDkC6X4P+4RzEVzmHTFNwSVXlK
        cEMMPCW6qfKjr9q2bRBd3X1Oe66IwU1HdgBVdYP6K2Y/uMFF2Daa7WnmZf2cEYdxUFp+ap
        iAU9MwShr8Bj3xbxmKSOSE+OS5eOYcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-HXNv5PS1NiCZOZg2fhSebg-1; Tue, 03 Aug 2021 03:06:12 -0400
X-MC-Unique: HXNv5PS1NiCZOZg2fhSebg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3195107ACF5;
        Tue,  3 Aug 2021 07:06:10 +0000 (UTC)
Received: from localhost (ovpn-13-115.pek2.redhat.com [10.72.13.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CBA760C25;
        Tue,  3 Aug 2021 07:06:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
Subject: [PATCH] blk-iocost: fix lockdep warning on blkcg->lock
Date:   Tue,  3 Aug 2021 15:06:08 +0800
Message-Id: <20210803070608.1766400-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg->lock depends on q->queue_lock which may depend on another driver
lock required in irq context, one example is dm-thin:

	Chain exists of:
	  &pool->lock#3 --> &q->queue_lock --> &blkcg->lock

	 Possible interrupt unsafe locking scenario:

	       CPU0                    CPU1
	       ----                    ----
	  lock(&blkcg->lock);
	                               local_irq_disable();
	                               lock(&pool->lock#3);
	                               lock(&q->queue_lock);
	  <Interrupt>
	    lock(&pool->lock#3);

Fix the issue by using spin_lock_irq(&blkcg->lock) in ioc_weight_write().

Cc: Tejun Heo <tj@kernel.org>
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Link: https://lore.kernel.org/linux-block/CA+QYu4rzz6079ighEanS3Qq_Dmnczcf45ZoJoHKVLVATTo1e4Q@mail.gmail.com/T/#u
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-iocost.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5fac3757e6e0..0e56557cacf2 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3061,19 +3061,19 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 		if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
 			return -EINVAL;
 
-		spin_lock(&blkcg->lock);
+		spin_lock_irq(&blkcg->lock);
 		iocc->dfl_weight = v * WEIGHT_ONE;
 		hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
 			struct ioc_gq *iocg = blkg_to_iocg(blkg);
 
 			if (iocg) {
-				spin_lock_irq(&iocg->ioc->lock);
+				spin_lock(&iocg->ioc->lock);
 				ioc_now(iocg->ioc, &now);
 				weight_updated(iocg, &now);
-				spin_unlock_irq(&iocg->ioc->lock);
+				spin_unlock(&iocg->ioc->lock);
 			}
 		}
-		spin_unlock(&blkcg->lock);
+		spin_unlock_irq(&blkcg->lock);
 
 		return nbytes;
 	}
-- 
2.31.1

