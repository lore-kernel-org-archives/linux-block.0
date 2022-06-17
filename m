Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6653DC43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 20:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiFQUob (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiFQUo2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 16:44:28 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5213CCF
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 13:44:27 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d5so4793949plo.12
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 13:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I+coexUdYl/cmHoLzQGmfZtjWnMmyqLiGn7ntk2+ivY=;
        b=FnALRXLE/Z8RAku4VATPpmqQt4ppSTxisqGjJGpNLVamwiGCZZ+r2iMK2lKRdahe85
         2yTitd9wZWz/dohmHORgPgmWlcq//KD39xiHrHxjmcUJ0OdmHB4Kcqlpkk8YzYmrMPDm
         asn2JOFgd3xbamNHzEQOUJvvqmlnfQ2PTsWCY4tULCwoN/y5B0eXVBl+AZ8qyt+VFsHp
         TDNRoTBVY4qOwpCpX8OzGiIM69mQSSTkLZkfua7Z8TAGKuy0SmndYd9pTmlfJkdzSNOs
         FKWVqyEHhnPLbvEAqmm1Entgxus4e+s52yiRwOLNSSufoJQDbeU6FRztZcn3CFBOjsr/
         HGtQ==
X-Gm-Message-State: AJIora+kqaa9bNHCurbp8S+UYCEZLjaciqSIDVqOfgWTFe7IhyAHc0n2
        Gx04XDpKHM0rlUQB8tmt+j0=
X-Google-Smtp-Source: AGRyM1th1T9fOcWw5JCC9lgg99jvc39E4NKAZSMIKCcaNWnkFf15w0OzdxJspywMRVd8XGJ96BSTZQ==
X-Received: by 2002:a17:90b:3a87:b0:1e8:8740:43e7 with SMTP id om7-20020a17090b3a8700b001e8874043e7mr12574035pjb.41.1655498666462;
        Fri, 17 Jun 2022 13:44:26 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:49d9:1d0f:f325:18fe])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d48500b0015ea95948ebsm4038914plg.134.2022.06.17.13.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:44:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] block: bfq: Fix kernel-doc headers
Date:   Fri, 17 Jun 2022 13:44:19 -0700
Message-Id: <20220617204419.101985-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following warnings:

block/bfq-cgroup.c:721: warning: Function parameter or member 'bfqg' not described in '__bfq_bic_change_cgroup'
block/bfq-cgroup.c:721: warning: Excess function parameter 'blkcg' description in '__bfq_bic_change_cgroup'
block/bfq-cgroup.c:870: warning: Function parameter or member 'ioprio_class' not described in 'bfq_reparent_leaf_entity'
block/bfq-cgroup.c:900: warning: Function parameter or member 'ioprio_class' not described in 'bfq_reparent_active_queues'

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-cgroup.c | 4 +++-
 block/bfq-wf2q.c   | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index dc0fa93219df..abc251902e28 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -709,7 +709,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
  * __bfq_bic_change_cgroup - move @bic to @cgroup.
  * @bfqd: the queue descriptor.
  * @bic: the bic to move.
- * @blkcg: the blk-cgroup to move to.
+ * @bfqg: the blk-cgroup to move to.
  *
  * Move bic to blkcg, assuming that bfqd->lock is held; which makes
  * sure that the reference to cgroup is valid across the call (see
@@ -863,6 +863,7 @@ static void bfq_flush_idle_tree(struct bfq_service_tree *st)
  * @bfqd: the device data structure with the root group.
  * @entity: the entity to move, if entity is a leaf; or the parent entity
  *	    of an active leaf entity to move, if entity is not a leaf.
+ * @ioprio_class: I/O priority class to reparent.
  */
 static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
 				     struct bfq_entity *entity,
@@ -892,6 +893,7 @@ static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
  * @bfqd: the device data structure with the root group.
  * @bfqg: the group to move from.
  * @st: the service tree to start the search from.
+ * @ioprio_class: I/O priority class to reparent.
  */
 static void bfq_reparent_active_queues(struct bfq_data *bfqd,
 				       struct bfq_group *bfqg,
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 089d07022066..983413cdefad 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1360,6 +1360,8 @@ static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st,
 /**
  * __bfq_lookup_next_entity - return the first eligible entity in @st.
  * @st: the service tree.
+ * @in_service: whether or not there is an in-service entity for the sched_data
+ *	this active tree belongs to.
  *
  * If there is no in-service entity for the sched_data st belongs to,
  * then return the entity that will be set in service if:
