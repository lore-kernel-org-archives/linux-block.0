Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEDCC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 21:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiFQVJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 17:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiFQVJM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 17:09:12 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7819FE00F
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 14:09:11 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id e11so5138424pfj.5
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 14:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6Nm+5QtJPvewaDdFmQxInjq8MXF/D3qFVhIWGpvYkM=;
        b=MQyzwJHVwwkHL1ea6WlsgynFhr1F4brH1IHm6gh+qaepCeG3XugK5YudlpIIKZiMYT
         gneEjxGelreqUMfe1p2zzkmBhpZPYKw3BwAWaRo4hgwZknSvzaOZWiUxRhDi4x91iCMw
         rXzYmeQO1+1npaFzlLAWQ2X9SvrWSyqSxUavte+/fwNFgm8ZfHgbosgP4mkV1EM7feC4
         R8EDFTU/5PmIVwjUV9QLTAI2wVOnDvXCFknIEeG4kbM2Jbeskv1blk36KKUvqH/iuqVl
         J6QhoUwKA6fqTrZco04/rBa5ep9GWsF070AwveQ/BMRKXiKKH/XFghAqj9BKSe3RmP9S
         +l5g==
X-Gm-Message-State: AJIora+YuvcscRTL6MKpZHR9Om0Sx+XRsuTF703yJZGbdtOZMaL+Dnvz
        REy7KJcGDMIwva+1piR5WSY=
X-Google-Smtp-Source: AGRyM1tgwHCMQ4birg8blvWN8UFcvqMPfKmA/yUpo+D/DUiAi4zo8eSiAq52IIDIR3uj0mgr7ZLCSg==
X-Received: by 2002:a63:7443:0:b0:40c:5a6e:3acf with SMTP id e3-20020a637443000000b0040c5a6e3acfmr3313996pgn.557.1655500150790;
        Fri, 17 Jun 2022 14:09:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:49d9:1d0f:f325:18fe])
        by smtp.gmail.com with ESMTPSA id u123-20020a626081000000b00522d329e36esm4256617pfb.140.2022.06.17.14.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 14:09:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] block: bfq: Fix kernel-doc headers
Date:   Fri, 17 Jun 2022 14:08:59 -0700
Message-Id: <20220617210859.106623-1-bvanassche@acm.org>
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

Changes between v1 and v2:
- Fixed bfqg description.
- Fixed __bfq_bic_change_cgroup kernel-doc one-line description.

 block/bfq-cgroup.c | 6 ++++--
 block/bfq-wf2q.c   | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index dc0fa93219df..9fc605791b1e 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -706,10 +706,10 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 }
 
 /**
- * __bfq_bic_change_cgroup - move @bic to @cgroup.
+ * __bfq_bic_change_cgroup - move @bic to @bfqg.
  * @bfqd: the queue descriptor.
  * @bic: the bic to move.
- * @blkcg: the blk-cgroup to move to.
+ * @bfqg: the group to move to.
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
