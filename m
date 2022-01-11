Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C8CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 14:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbiAKOMd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 09:12:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45330 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiAKOMc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 09:12:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BBE141F37D;
        Tue, 11 Jan 2022 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641910351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9lRhOlKm9dnxzXyqY8lcIf6WomYbHt92EMiBkXux2k=;
        b=Gj4ClZvoEM5fSzU9xF6tst/twW/13Xn5w/zat7lwwsHqqZJ/gse4Y6pighmnOdi6VexDvk
        IN73xOILaNE4mTeo08Pk8gpt0Qkp0kQQGmFTX7s9sal/pTCNfBsw5SJMKWXu9k40v4r5m5
        7o7SciYiLTnSAhiFfgBwf5L4vUDzXak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641910351;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9lRhOlKm9dnxzXyqY8lcIf6WomYbHt92EMiBkXux2k=;
        b=P0Pjk3DeMFYYAWNKiu7A2O7Zk/pWZLGvVGpz7QdJ2QN5P4yd7GDTa1deNh30s4NLFYNS/R
        NPhXq2oAZuAafPCg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9C1C9A3B81;
        Tue, 11 Jan 2022 14:12:31 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 514FBA0597; Tue, 11 Jan 2022 15:12:28 +0100 (CET)
Date:   Tue, 11 Jan 2022 15:12:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/5 v2] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <20220111141228.xxr6wiq5x6b34uo3@quack3.lan>
References: <20220105143037.20542-1-jack@suse.cz>
 <527c2294-9a53-872a-330a-f337506cd08b@huawei.com>
 <20220107145853.jvgupijrq2ejnhdt@quack3.lan>
 <db449ed5-85db-37e5-deb6-62fdeb124c90@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db449ed5-85db-37e5-deb6-62fdeb124c90@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 10-01-22 09:49:34, yukuai (C) wrote:
> 在 2022/01/07 22:58, Jan Kara 写道:
> > On Fri 07-01-22 17:15:43, yukuai (C) wrote:
> > > 在 2022/01/05 22:36, Jan Kara 写道:
> > > > Hello,
> > > > 
> > > > here is the second version of my patches to fix use-after-free issues in BFQ
> > > > when processes with merged queues get moved to different cgroups. The patches
> > > > have survived some beating in my test VM but so far I fail to reproduce the
> > > > original KASAN reports so testing from people who can reproduce them is most
> > > > welcome. Thanks!
> > > > 
> > > > Changes since v1:
> > > > * Added fix for bfq_put_cooperator()
> > > > * Added fix to handle move between cgroups in bfq_merge_bio()
> > > > 
> > > > 								Honza
> > > > Previous versions:
> > > > Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
> > > > .
> > > > 
> > > 
> > > Hi,
> > > 
> > > I repoduced the problem again with this patchset...
> > 
> > Thanks for testing!
> > 
> > > [   71.004788] BUG: KASAN: use-after-free in
> > > __bfq_deactivate_entity+0x21/0x290
> > > [   71.006328] Read of size 1 at addr ffff88817a3dc0b0 by task rmmod/801
> > > [   71.007723]
> > > [   71.008068] CPU: 7 PID: 801 Comm: rmmod Tainted: G        W
> > > 5.16.0-rc5-next-2021127
> > > [   71.009995] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > ?-20190727_073836-4
> > > [   71.012274] Call Trace:
> > > [   71.012603]  <TASK>
> > > [   71.012886]  dump_stack_lvl+0x34/0x44
> > > [   71.013379]  print_address_description.constprop.0.cold+0xab/0x36b
> > > [   71.014182]  ? __bfq_deactivate_entity+0x21/0x290
> > > [   71.014795]  ? __bfq_deactivate_entity+0x21/0x290
> > > [   71.015398]  kasan_report.cold+0x83/0xdf
> > > [   71.015904]  ? _raw_read_lock_bh+0x20/0x40
> > > [   71.016433]  ? __bfq_deactivate_entity+0x21/0x290
> > > [   71.017033]  __bfq_deactivate_entity+0x21/0x290
> > > [   71.017617]  bfq_pd_offline+0xc1/0x110
> > > [   71.018105]  blkcg_deactivate_policy+0x14b/0x210
> > ...
> > 
> > > Here is the caller of  __bfq_deactivate_entity:
> > > (gdb) list *(bfq_pd_offline+0xc1)
> > > 0xffffffff81c504f1 is in bfq_pd_offline (block/bfq-cgroup.c:942).
> > > 937                      * entities to the idle tree. It happens if, in some
> > > 938                      * of the calls to bfq_bfqq_move() performed by
> > > 939                      * bfq_reparent_active_queues(), the queue to move
> > > is
> > > 940                      * empty and gets expired.
> > > 941                      */
> > > 942                     bfq_flush_idle_tree(st);
> > > 943             }
> > > 944
> > > 945             __bfq_deactivate_entity(entity, false);
> > 
> > So this is indeed strange. The group has in some of its idle service trees
> > an entity whose entity->sched_data points to already freed cgroup. In
> > particular it means the bfqq_entity_service_tree() leads to somewhere else
> > than the 'st' we called bfq_flush_idle_tree() with. This looks like a
> > different kind of problem AFAICT but still it needs fixing :). Can you
> > please run your reproducer with my patches + the attached debug patch on
> > top? Hopefully it should tell us more about the problematic entity and how
> > it got there... Thanks!
> 
> Hi,
> 
> I'm not sure I understand what you mean... I reporduced again with your
> debug patch applied, however, no extra messages are printed.
> 
> I think this is exactly the same problem we discussed before:
> 
> 1) bfqq->new_bfqq is set, they are under g1
> 2) bfqq is moved to another group, and user thread of new_bfqq exit
> 3) g1 is offlied
> 3) io issued from bfqq will end up in new_bfqq, and the offlined
> g1 will be inserted to st of g1's parent.

Hmm, you are right. I was confused by the fact that bfq_setup_merge() is
always immediately (under big bfq lock) followed by bfq_merge_bfqqs() but
that redirects BIC of just one process pointing to the new bfqq. So the
following is a bit more detailed and graphical version of your scenario for
future reference :):

Initial state, bfqq2 is shared by Process 2 & Process 3:

Process 1 (blkcg1)	Process 2 (blkcg1)	Process 3 (blkcg1)
 (BIC)			 (BIC)			 (BIC)
   |			   |			   |
   |			   |			  /
   v			   v			 /
 bfqq1			bfqq2<-------------------
   \			  /
    \			 /
     \			/
      ----> BFQ group1<-

Now while processing request for Process 2 we decide to merge bfqq2 to
bfqq1. Situation after the merge:

Process 1 (blkcg1)	Process 2 (blkcg1)	Process 3 (blkcg1)
 (BIC)			 (BIC)			 (BIC)
   |			   /			   |
   |/---------------------/   			  /
   vv		new_bfqq   			 /
 bfqq1<-----------------bfqq2<-------------------
   \			  /
    \			 /
     \			/
      ----> BFQ group1<-

Processes 1 and 2 exit:
					Process 3 (blkcg1)
					 (BIC)
					   |
					  /
		new_bfqq		 /
 bfqq1<-----------------bfqq2<-----------
   \			  /
    \			 /
     \			/
      ----> BFQ group1<-

Process 3 is moved to blkcg2 and submits IO, blkcg1 is offlined.
bfq_bic_update_cgroup() will change the picture to:

					Process 3 (blkcg2)
					 (BIC)
					   |
					  /
		new_bfqq		 /
 bfqq1<-----------------bfqq2<-----------
   |			  |
   |			  |
   v 			  v
BFQ group1		BFQ group2

and following bfq_merge_bfqqs() when submitting the request will further
modify the picture to:
					Process 3 (blkcg2)
					 (BIC)
					   |
     /-------------------------------------/
     v		new_bfqq
 bfqq1<-----------------bfqq2
   |			  |
   |			  |
   v 			  v
BFQ group1		BFQ group2

and boom, we queue again offlined BFQ group1.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
