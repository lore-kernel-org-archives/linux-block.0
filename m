Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E9FC04AB5
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 22:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09F02083E
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 22:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfFFWoI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:44:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfFFWoI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Jun 2019 18:44:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B85430832C6;
        Thu,  6 Jun 2019 22:44:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6C1559442;
        Thu,  6 Jun 2019 22:43:55 +0000 (UTC)
Date:   Fri, 7 Jun 2019 06:43:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Benjamin Block <bblock@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <rong.a.chen@intel.com>,
        Jens Remus <jremus@linux.ibm.com>
Subject: Re: [PATCH] block: free sched's request pool in blk_cleanup_queue
Message-ID: <20190606224349.GB2165@ming.t460p>
References: <20190604130802.17076-1-ming.lei@redhat.com>
 <20190606144714.GA6549@t480-pf1aa2c2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606144714.GA6549@t480-pf1aa2c2>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 06 Jun 2019 22:44:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 06, 2019 at 04:47:14PM +0200, Benjamin Block wrote:
> On Tue, Jun 04, 2019 at 09:08:02PM +0800, Ming Lei wrote:
> > In theory, IO scheduler belongs to request queue, and the request pool
> > of sched tags belongs to the request queue too.
> > 
> > However, the current tags allocation interfaces are re-used for both
> > driver tags and sched tags, and driver tags is definitely host wide,
> > and doesn't belong to any request queue, same with its request pool.
> > So we need tagset instance for freeing request of sched tags.
> > 
> > Meantime, blk_mq_free_tag_set() often follows blk_cleanup_queue() in case
> > of non-BLK_MQ_F_TAG_SHARED, this way requires that request pool of sched
> > tags to be freed before calling blk_mq_free_tag_set().
> > 
> > Commit 47cdee29ef9d94e ("block: move blk_exit_queue into __blk_release_queue")
> > moves blk_exit_queue into __blk_release_queue for simplying the fast
> > path in generic_make_request(), then causes oops during freeing requests
> > of sched tags in __blk_release_queue().
> > 
> > Fix the above issue by move freeing request pool of sched tags into
> > blk_cleanup_queue(), this way is safe becasue queue has been frozen and no any
> > in-queue requests at that time. Freeing sched tags has to be kept in queue's
> > release handler becasue there might be un-completed dispatch activity
> > which might refer to sched tags.
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Fixes: 47cdee29ef9d94e485eb08f962c74943023a5271 ("block: move blk_exit_queue into __blk_release_queue")
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Our CI meanwhile also crashes regularly because of this:
> 
>   run blktests block/002 at 2019-06-06 14:44:55
>   Unable to handle kernel pointer dereference in virtual kernel address space, Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803
>   Fault in home space mode while using kernel ASCE.
>   AS:0000000057290007 R3:0000000000000024
>   Oops: 0038 ilc:3 [#1] PREEMPT SMP
>   Modules linked in: ...
>   CPU: 4 PID: 139 Comm: kworker/4:2 Kdump: loaded Not tainted 5.2.0-rc3-master-05489-g55f909514069 #3
>   Hardware name: IBM 3906 M03 703 (LPAR)
>   Workqueue: events __blk_release_queue
>   Krnl PSW : 0704e00180000000 000000005657db18 (blk_mq_free_rqs+0x48/0x128)
>              R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>   Krnl GPRS: 00000000a8309db5 6b6b6b6b6b6b6b6b 000000008beb3858 00000000a2befbc8
>              0000000000000000 0000000000000001 0000000056bb16c8 00000000b4070aa8
>              000000008beb3858 000000008bc46b38 00000000a2befbc8 0000000000000000
>              00000000bafb8100 00000000568e8040 000003e0092b3c30 000003e0092b3be0
>   Krnl Code: 000000005657db0a: a7f4006e            brc     15,5657dbe6
>              000000005657db0e: e31020380004       lg      %r1,56(%r2)
>             #000000005657db14: b9040082           lgr     %r8,%r2
>             >000000005657db18: e31010500002       ltg     %r1,80(%r1)
>              000000005657db1e: a784ffee           brc     8,5657dafa
>              000000005657db22: e32030000012       lt      %r2,0(%r3)
>              000000005657db28: a784ffe9           brc     8,5657dafa
>              000000005657db2c: b9040074           lgr     %r7,%r4
>   Call Trace:
>   ([<000000008ff8ed00>] 0x8ff8ed00)
>    [<0000000056582958>] blk_mq_sched_tags_teardown+0x68/0x98
>    [<0000000056583396>] blk_mq_exit_sched+0xc6/0xd8
>    [<0000000056569324>] elevator_exit+0x54/0x70
>    [<0000000056570644>] __blk_release_queue+0x84/0x110
>    [<0000000055f416c6>] process_one_work+0x3a6/0x6b8
>    [<0000000055f41c50>] worker_thread+0x278/0x478
>    [<0000000055f49e08>] kthread+0x160/0x178
>    [<00000000568d83e8>] ret_from_fork+0x34/0x38
>   INFO: lockdep is turned off.
>   Last Breaking-Event-Address:
>    [<000000005657daf6>] blk_mq_free_rqs+0x26/0x128
>   Kernel panic - not syncing: Fatal exception: panic_on_oops
>   run blktests block/003 at 2019-06-06 14:44:56
> 
> When I tried to reproduced this with this patch, it went away (at least all of
> blktest/block ran w/o crash).
> 
> I don't feel competent enough to review this patch right now, but it would be
> good if we get something upstream for this.

Hi Jens, Christoph and Guys,

Could you take a look at this patch? We have at least 3 reports on this
issue, and I believe more will come if it isn't fixed.

Jens, sorry for interrupting your vocation.

Thanks,
Ming
