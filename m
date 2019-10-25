Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DD4CA9EBD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6983B2053B
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409587AbfJYQuV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:50:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36233 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409570AbfJYQuU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:50:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so1906189pgk.3
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 09:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nc1ug63CH73vTb+uKvAKYhTrY+3OfJCTIh8JbxXvNNg=;
        b=ctg0MbzAE1BquUuqiaUa2HyfPjxBD73oDfiHM6iat/yNau4Tat68r+5wTHs8oFdOFb
         1MaULWUFFuxyVXLwFqQBgp7ab+vGSAuCS45pDzvRKt/47QtpzgW7ikka76mIRI1u2wax
         eyK/2CNbUpkkk2dnigYags1WrzkbR24W+KsaQAprfgm47XmA+1C4zyP8rTpvTAedQL9L
         p05nFYQCl5RV+BPeBzxL74Sd3k8Al3WQuQF8wEvYl1Zm0I6H3G3dlfWDjn0/D1836jVA
         m2Gjp5onQPrySD9gwmwqMtR/41SIsyl7PGLoOVFw/i+5k1Wyj1B+l4kkrey7WIn+VOuu
         0fFw==
X-Gm-Message-State: APjAAAXw+1+uf8e2hYfkm/SC1UKunlhSwFCR30vhcwk38mAdixeqkfFg
        ouZ5iJhy9IuuuCFXoHdk8/M=
X-Google-Smtp-Source: APXvYqyOScN7zvGNB4bLBgMIjCypd17KbXq83hzT1zsAWTy3UQ3KvPmrnN6StZGaN3sENMdkaQ9s8w==
X-Received: by 2002:a63:a849:: with SMTP id i9mr5580314pgp.237.1572022219580;
        Fri, 25 Oct 2019 09:50:19 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c8sm4088158pfi.117.2019.10.25.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:50:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 1/3] block: Remove the synchronize_rcu() call from __blk_mq_update_nr_hw_queues()
Date:   Fri, 25 Oct 2019 09:50:08 -0700
Message-Id: <20191025165010.211462-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025165010.211462-1-bvanassche@acm.org>
References: <20191025165010.211462-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the blk_mq_{,un}freeze_queue() calls in __blk_mq_update_nr_hw_queues()
already serialize __blk_mq_update_nr_hw_queues() against
blk_mq_queue_tag_busy_iter(), the synchronize_rcu() call in
__blk_mq_update_nr_hw_queues() is not necessary. Hence remove it.

Note: the synchronize_rcu() call in __blk_mq_update_nr_hw_queues() was
introduced by commit f5bbbbe4d635 ("blk-mq: sync the update nr_hw_queues with
blk_mq_queue_tag_busy_iter"). Commit 530ca2c9bd69 ("blk-mq: Allow blocking
queue tag iter callbacks") removed the rcu_read_{,un}lock() calls that
correspond to the synchronize_rcu() call in __blk_mq_update_nr_hw_queues().

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8538dc415499..7528678ef41f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3242,10 +3242,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
-	/*
-	 * Sync with blk_mq_queue_tag_busy_iter.
-	 */
-	synchronize_rcu();
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
-- 
2.24.0.rc0.303.g954a862665-goog

