Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE65C433EF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 15:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiAQPqn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 10:46:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57090 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiAQPqk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 10:46:40 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AC8271F3B8;
        Mon, 17 Jan 2022 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642434398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLq9DzRRZmJQG9Y0ZX/4FTq9dgKbWXgexxIJ8dL85Qw=;
        b=OBRn6jSeZsNr5D03GGQZq9PmYaClVbjYJq4SLBD1ytNhhdjGqvjG4dJO2U1CVxs8+phx9d
        gUIRu2Y99Rpg/v9rVrWAjVGt4AbNyVxAory89rJNGCLrvLE0vU6cWaXmdO/ccCqmIDVxyb
        YXnZFHEH0USryshuIMlztAcmj0zMQNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642434398;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLq9DzRRZmJQG9Y0ZX/4FTq9dgKbWXgexxIJ8dL85Qw=;
        b=rf099jxQO9vDncyjuECFmhuEGHmmn16uo3Xji85ieQSmmLpPgxPJOUZZ0/H0GjBmqv6TUn
        8Rd29eBnynj/qlAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 98111A3B8A;
        Mon, 17 Jan 2022 15:46:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 92BBAA05E4; Mon, 17 Jan 2022 16:46:32 +0100 (CET)
Date:   Mon, 17 Jan 2022 16:46:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/4 v4] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <20220117154632.5r6os2wbwf6xiqhc@quack3.lan>
References: <20220114164215.28972-1-jack@suse.cz>
 <9ee09c05-13c4-ec9d-5859-ed91dea39e13@huawei.com>
 <20220117114510.x6yrhx4nlncso3vd@quack3.lan>
 <f6baffae-7105-556c-3785-7b4fed2bf39c@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="42t4ovr7b6dra56y"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6baffae-7105-556c-3785-7b4fed2bf39c@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--42t4ovr7b6dra56y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon 17-01-22 22:16:23, yukuai (C) wrote:
> 在 2022/01/17 19:45, Jan Kara 写道:
> > On Mon 17-01-22 16:13:09, yukuai (C) wrote:
> > > 在 2022/01/15 1:01, Jan Kara 写道:
> > > > Hello,
> > > > 
> > > > here is the third version of my patches to fix use-after-free issues in BFQ
> > > > when processes with merged queues get moved to different cgroups. The patches
> > > > have survived some beating in my test VM, but so far I fail to reproduce the
> > > > original KASAN reports so testing from people who can reproduce them is most
> > > > welcome. Kuai, can you please give these patches a run in your setup? Thanks
> > > > a lot for your help with fixing this!
> > > > 
> > > > Changes since v3:
> > > > * Changed handling of bfq group move to handle the case when target of the
> > > >     merge has moved.
> > > Hi, Jan
> > > 
> > > The problem can still be reporduced...
> > 
> > Drat. Thanks for testing.
> > 
> > > Do you implement this in patch 4? If so, I don't understand how you
> > > chieve this.
> > 
> > Yes, patch 4 should be handling this.
> > 
> > > For example: 3 bfqqs were merged:
> > > q1->q2->q3
> > > 
> > > If __bfq_bic_change_cgroup() is called with q2, the problem can be
> > > fixed. However, if __bfq_bic_change_cgroup() is called with q3, can
> > > the problem be fixed?
> > 
> > Maybe I'm missing something so let's walk through your example where the
> > bio is submitted for a task attached to q3. Bio is submitted,
> > __bfq_bic_change_cgroup() is called with sync_bfqq == q3, the loop
> > 
> >                 while (sync_bfqq->new_bfqq)
> >                         sync_bfqq = sync_bfqq->new_bfqq;
> > 
> > won't do anything. Then we check:
> > 
> >                 if (sync_bfqq->entity.sched_data != &bfqg->sched_data) {
> > 
> > This should be true because the task got moved and the bio is thus now
> > submitted for a different cgroup. Then we get to the condition:
> > 
> >                         if (orig_bfqq != sync_bfqq || bfq_bfqq_coop(sync_bfqq))
> > 
> > orig_bfqq == sync_bfqq so that won't help but the idea was that
> > bfq_bfqq_coop() would trigger in this case so we detach the process from q3
> > (through bic_set_bfqq(bic, NULL, 1)) and create new queue in the right
> > cgroup. Eventually, all the processes would detach from q3 and it would get
> > destroyed. So why do you think this scheme will not work?
> 
> Hi, Jan
> 
> I repoduced again with some debug info:

Thanks for your help with debugging!

> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index f6f5f156b9f2..f62ebc4bbe56 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -732,8 +732,11 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct
> bfq_data *bfqd,
>                 struct bfq_queue *orig_bfqq = sync_bfqq;
> 
>                 /* Traverse the merge chain to bfqq we will be using */
> -               while (sync_bfqq->new_bfqq)
> +               while (sync_bfqq->new_bfqq) {
> +                       printk("%s: bfqq %px, new_bfqq %px\n", __func__,
> +                                       sync_bfqq, sync_bfqq->new_bfqq);
>                         sync_bfqq = sync_bfqq->new_bfqq;
> +               }
>                 /*
>                  * Target bfqq got moved to a different cgroup or this
> process
>                  * started submitting bios for different cgroup?
> @@ -756,6 +759,8 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct
> bfq_data *bfqd,
>                                 bic_set_bfqq(bic, NULL, 1);

Maybe it would be nice to add a debug message here, saying we are detaching
the process from orig_bfqq. Just that we know that this branch executed.

>                                 return bfqg;
>                         }
> +                       printk("%s: bfqq %px move from %px to %px\n",
> __func__,
> +                               sync_bfqq, bfqq_group(sync_bfqq), bfqg);
>                         /* We are the only user of this bfqq, just move it
> */
>                         bfq_bfqq_move(bfqd, sync_bfqq, bfqg);

...

> -       if (bfqq->new_bfqq)
> +       if (bfqq->new_bfqq) {
> +               if (bfqq->entity.parent != bfqq->new_bfqq->entity.parent) {
> +                       printk("%s: bfqq %px(%px) new_bfqq %px(%px)\n",
> __func__,
> +                               bfqq, bfqq_group(bfqq), bfqq->new_bfqq,
> +                               bfqq_group(bfqq->new_bfqq));
> +                       BUG_ON(1);

OK, so I can see why this triggered. We have:

Set new_bfqq for bfqq *eec0:
[   50.207263] bfq_setup_merge: set bfqq ffff88816b16eec0 new_bfqq ffff8881133e1340 parent ffff88814380b000/ffff88814380b000
Move new_bfqq to a root cgroup:
[   50.485933] bfq_reparent_leaf_entity: bfqq ffff8881133e1340 move from ffff88814380b000 to ffff88810b1f1000
Submit bio for root cgroup through *eec0:
[   50.519910] __bfq_bic_change_cgroup: bfqq ffff88816b16eec0, new_bfqq ffff8881133e1340
__bfq_bic_change_cgroup() does nothing as the bio is for the cgroup to which
target queue belongs.
[   50.520640] bfq_setup_cooperator: bfqq ffff88816b16eec0(ffff88814380b000) new_bfqq ffff8881133e1340(ffff88810b1f1000)
The BUG_ON trips. 

So at this moment the BUG_ON was just too eager to trigger as we would be
submitting IO to a bfq queue belonging to an appropriate cgroup. But I
guess it does not make sence to keep unfinished merges over cgroup
migration and __bfq_bic_change_cgroup() should have detached task from its
bfqq anyway. Can you please try running with a new version of patch 4 which
is attached? And perhaps with your debug patch as well... Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--42t4ovr7b6dra56y
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-bfq-Update-cgroup-information-before-merging-bio.patch"

From 2c32c74eccc94f1f5c689132423cbe5fc9616871 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 5 Jan 2022 14:21:04 +0100
Subject: [PATCH] bfq: Update cgroup information before merging bio

When the process is migrated to a different cgroup (or in case of
writeback just starts submitting bios associated with a different
cgroup) bfq_merge_bio() can operate with stale cgroup information in
bic. Thus the bio can be merged to a request from a different cgroup or
it can result in merging of bfqqs for different cgroups or bfqqs of
already dead cgroups and causing possible use-after-free issues. Fix the
problem by updating cgroup information in bfq_merge_bio().

CC: stable@vger.kernel.org
Fixes: e21b7a0b9887 ("block, bfq: add full hierarchical scheduling and cgroups support")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-cgroup.c  | 37 +++++++++++++++++++++----------------
 block/bfq-iosched.c | 11 +++++++++--
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index dbc117e00783..de4db8a0d796 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -729,30 +729,35 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 	}
 
 	if (sync_bfqq) {
-		entity = &sync_bfqq->entity;
-		if (entity->sched_data != &bfqg->sched_data) {
+		struct bfq_queue *target_bfqq = NULL;
+
+		if (sync_bfqq->new_bfqq)
+			target_bfqq = sync_bfqq->new_bfqq;
+		/*
+		 * Target bfqq got moved to a different cgroup or this process
+		 * started submitting bios for different cgroup?
+		 */
+		if ((target_bfqq &&
+		     sync_bfqq->entity.parent != target_bfqq->entity.parent) ||
+		    sync_bfqq->entity.sched_data != &bfqg->sched_data) {
 			/*
 			 * Was the queue we use merged to a different queue?
-			 * Detach process from the queue as merge need not be
-			 * valid anymore. We cannot easily cancel the merge as
-			 * there may be other processes scheduled to this
-			 * queue.
+			 * Detach process from the queue as the merge is not
+			 * valid anymore. We cannot easily just cancel the
+			 * merge (by clearing new_bfqq) as there may be other
+			 * processes using this queue and holding refs to all
+			 * queues below sync_bfqq->new_bfqq. Similarly if the
+			 * merge already happened, we need to detach from bfqq
+			 * now so that we cannot merge bio to a request from
+			 * the old cgroup.
 			 */
-			if (sync_bfqq->new_bfqq) {
+			if (target_bfqq || bfq_bfqq_coop(sync_bfqq)) {
 				bfq_put_cooperator(sync_bfqq);
 				bfq_release_process_ref(bfqd, sync_bfqq);
 				bic_set_bfqq(bic, NULL, 1);
 				return bfqg;
 			}
-			/*
-			 * Moving bfqq that is shared with another process?
-			 * Split the queues at the nearest occasion as the
-			 * processes can be in different cgroups now.
-			 */
-			if (bfq_bfqq_coop(sync_bfqq)) {
-				bic->stably_merged = false;
-				bfq_mark_bfqq_split_coop(sync_bfqq);
-			}
+			/* We are the only user of this bfqq, just move it */
 			bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
 		}
 	}
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 361d321b012a..8a088d77a0b6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2337,10 +2337,17 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 
 	spin_lock_irq(&bfqd->lock);
 
-	if (bic)
+	if (bic) {
+		/*
+		 * Make sure cgroup info is uptodate for current process before
+		 * considering the merge.
+		 */
+		bfq_bic_update_cgroup(bic, bio);
+
 		bfqd->bio_bfqq = bic_to_bfqq(bic, op_is_sync(bio->bi_opf));
-	else
+	} else {
 		bfqd->bio_bfqq = NULL;
+	}
 	bfqd->bio_bic = bic;
 
 	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
-- 
2.31.1


--42t4ovr7b6dra56y--
