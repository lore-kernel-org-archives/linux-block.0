Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7B7C73C63
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 03:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF01320656
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 03:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfGJDKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 23:10:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfGJDKS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jul 2019 23:10:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8850430917A8;
        Wed, 10 Jul 2019 03:10:17 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3DB85FCB1;
        Wed, 10 Jul 2019 03:10:09 +0000 (UTC)
Date:   Wed, 10 Jul 2019 11:10:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
Message-ID: <20190710031003.GB2621@ming.t460p>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
 <20190709142915.GA30082@ming.t460p>
 <BYAPR04MB58162A2087D53F27BAF8176BE7F10@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58162A2087D53F27BAF8176BE7F10@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 10 Jul 2019 03:10:17 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 09, 2019 at 02:47:12PM +0000, Damien Le Moal wrote:
> Hi Ming,
> 
> On 2019/07/09 23:29, Ming Lei wrote:
> > On Tue, Jul 09, 2019 at 06:02:19PM +0900, Damien Le Moal wrote:
> >> Simultaneously writing to a sequential zone of a zoned block device
> >> from multiple contexts requires mutual exclusion for BIO issuing to
> >> ensure that writes happen sequentially. However, even for a well
> >> behaved user correctly implementing such synchronization, BIO plugging
> >> may interfere and result in BIOs from the different contextx to be
> >> reordered if plugging is done outside of the mutual exclusion section,
> >> e.g. the plug was started by a function higher in the call chain than
> >> the function issuing BIOs.
> >>
> >>       Context A                           Context B
> >>
> >>    | blk_start_plug()
> >>    | ...
> >>    | seq_write_zone()
> >>      | mutex_lock(zone)
> >>      | submit_bio(bio-0)
> >>      | submit_bio(bio-1)
> >>      | mutex_unlock(zone)
> >>      | return
> >>    | ------------------------------> | seq_write_zone()
> >>   				       | mutex_lock(zone)
> >> 				       | submit_bio(bio-2)
> >> 				       | mutex_unlock(zone)
> >>    | <------------------------------ |
> >>    | blk_finish_plug()
> >>
> >> In the above example, despite the mutex synchronization resulting in the
> >> correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being
> >> issued after BIO 2 when the plug is released with blk_finish_plug().
> > 
> > I am wondering how you guarantee that context B is always run after
> > context A.
> 
> My example was a little too oversimplified. Think of a file system allocating
> blocks sequentially and issuing page I/Os for the allocated blocks sequentially.
> The typical sequence is:
> 
> mutex_lock(zone)
> alloc_block_extent(zone)
> for all blocks in the extent
> 	submit_bio()
> mutex_unlock(zone)
> 
> This way, it does not matter which context gets the lock first, all write BIOs
> for the zone remain sequential. The problem with plugs as explained above is

But wrt. the example in the commit log, it does matter which context gets the lock
first, and it implies that context A has to run seq_write_zone() first,
because you mentioned bio-2 has to be issued after bio-0 and bio-1.

If there is 3rd context which is holding the lock, then either context A or
context B can win in getting the lock first. So looks the zone lock itself
isn't enough for maintaining the IO order. But that may not be related
with this patch.

Also seems there is issue with REQ_NOWAIT for zone support, for example,
context A may see out-of-request and return earlier, however context B
may get request and move on.

> that if the plug start/finish is not within the zone lock, reordering can happen
> for the 2 sequences of BIOs issued by the 2 contexts.
> 
> We hit this problem with btrfs writepages (page writeback) where plugging is
> done before the above sequence execution, in the caller function of the page
> writeback processing, resulting in unaligned write errors.
> 
> >> To fix this problem, introduce the internal helper function
> >> blk_mq_plug() to access the current context plug, return the current
> >> plug only if the target device is not a zoned block device or if the
> >> BIO to be plugged not a write operation. Otherwise, ignore the plug and
> >> return NULL, resulting is all writes to zoned block device to never be
> >> plugged.
> > 
> > Another candidate approach is to run the following code before
> > releasing 'zone' lock:
> > 
> > 	if (current->plug)
> > 		blk_finish_plug(context->plug)
> > 
> > Then we can fix zone specific issue in zone code only, and avoid generic
> > blk-core change for zone issue.
> 
> Yes indeed, that would work too. But this patch is precisely to avoid having to
> add such code and simplify implementing support for zoned block device in
> existing code. Furthermore, plugging for writes to sequential zones has no real
> value because mq-deadline will dispatch at most one write per zone. So writes
> for a single zone tend to accumulate in the scheduler queue, and that creates
> plenty of opportunities for merging small sequential writes (e.g. file system
> page BIOs).
> 
> If you think this patch is really not appropriate, we can still address the
> problem case by case in the support we add for zoned devices. But again, a
> generic solution makes things simpler I think.

OK, then I am fine with this simple generic approach.

Thanks,
Ming
