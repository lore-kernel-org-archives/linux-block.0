Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412B1C433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 11:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiAQLpR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 06:45:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57358 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiAQLpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 06:45:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EE6F121136;
        Mon, 17 Jan 2022 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642419915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEDOB1b5QMEk+p74vrb6XllKv30Ay5OutaTSP81qrCo=;
        b=K1uWdnIUz2AE1WRDiXx8eZpgHjU9aZavdJnyULEIaVCwhC764Lhvk7ATn6wNt2eO9SbIYo
        eD5Sh+jS+Wtukw6lwuxlJO7y72Evosi2Hv6aB7fMSaz87Zbupuk9ipdl6VK+5+gykEuiW7
        ObcPCQOBpoTS6VqA2ltDOfd3eqF5oZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642419915;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEDOB1b5QMEk+p74vrb6XllKv30Ay5OutaTSP81qrCo=;
        b=O7RrYlEPHfwJFtOq4t0gcMDjvp+tbyE28WUM9Rze0PbCtTrV5OATDHfqd6pEqz8KXLgoQq
        rn+ykkpfbLUl90Bg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D172AA3B81;
        Mon, 17 Jan 2022 11:45:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 15421A05E4; Mon, 17 Jan 2022 12:45:10 +0100 (CET)
Date:   Mon, 17 Jan 2022 12:45:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/4 v4] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <20220117114510.x6yrhx4nlncso3vd@quack3.lan>
References: <20220114164215.28972-1-jack@suse.cz>
 <9ee09c05-13c4-ec9d-5859-ed91dea39e13@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="byygjjdi76ebnkrh"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ee09c05-13c4-ec9d-5859-ed91dea39e13@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--byygjjdi76ebnkrh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon 17-01-22 16:13:09, yukuai (C) wrote:
> 在 2022/01/15 1:01, Jan Kara 写道:
> > Hello,
> > 
> > here is the third version of my patches to fix use-after-free issues in BFQ
> > when processes with merged queues get moved to different cgroups. The patches
> > have survived some beating in my test VM, but so far I fail to reproduce the
> > original KASAN reports so testing from people who can reproduce them is most
> > welcome. Kuai, can you please give these patches a run in your setup? Thanks
> > a lot for your help with fixing this!
> > 
> > Changes since v3:
> > * Changed handling of bfq group move to handle the case when target of the
> >    merge has moved.
> Hi, Jan
> 
> The problem can still be reporduced...

Drat. Thanks for testing.

> Do you implement this in patch 4? If so, I don't understand how you
> chieve this.

Yes, patch 4 should be handling this.

> For example: 3 bfqqs were merged:
> q1->q2->q3
> 
> If __bfq_bic_change_cgroup() is called with q2, the problem can be
> fixed. However, if __bfq_bic_change_cgroup() is called with q3, can
> the problem be fixed?

Maybe I'm missing something so let's walk through your example where the
bio is submitted for a task attached to q3. Bio is submitted,
__bfq_bic_change_cgroup() is called with sync_bfqq == q3, the loop

               while (sync_bfqq->new_bfqq)
                       sync_bfqq = sync_bfqq->new_bfqq;

won't do anything. Then we check:

               if (sync_bfqq->entity.sched_data != &bfqg->sched_data) {

This should be true because the task got moved and the bio is thus now
submitted for a different cgroup. Then we get to the condition:

                       if (orig_bfqq != sync_bfqq || bfq_bfqq_coop(sync_bfqq))

orig_bfqq == sync_bfqq so that won't help but the idea was that
bfq_bfqq_coop() would trigger in this case so we detach the process from q3
(through bic_set_bfqq(bic, NULL, 1)) and create new queue in the right
cgroup. Eventually, all the processes would detach from q3 and it would get
destroyed. So why do you think this scheme will not work?

And even if q3 is not marked as coop (which should not happen when there
are other queues merged to it), we would move q3 to a cgroup for which IO
is submitted - i.e., a one which is alive.

Hum, but maybe with the above merge setup (q1->q2->q3) if
__bfq_bic_change_cgroup() gets called for q1, q3 is already moved to the root
cgroup by bfq_pd_offline() and bio is for the root cgroup, then we decide
to keep everything as is. But bfq_setup_cooperator() will return q2 and
we queue IO there and q2 may still be pointing to a dead cgroup (but q2
didn't get reparented because it was not in any of the service trees). So
perhaps attached fixup will help?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--byygjjdi76ebnkrh
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="bfq-cgroup-fixup.patch"

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index f6f5f156b9f2..3e8f0564ff0b 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -732,7 +732,7 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 		struct bfq_queue *orig_bfqq = sync_bfqq;
 
 		/* Traverse the merge chain to bfqq we will be using */
-		while (sync_bfqq->new_bfqq)
+		if (sync_bfqq->new_bfqq)
 			sync_bfqq = sync_bfqq->new_bfqq;
 		/*
 		 * Target bfqq got moved to a different cgroup or this process

--byygjjdi76ebnkrh--
