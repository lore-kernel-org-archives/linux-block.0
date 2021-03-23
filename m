Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA49C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 14:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5130619BD
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 14:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhCWOyw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhCWOxh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 10:53:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A56D860232;
        Tue, 23 Mar 2021 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616511217;
        bh=h5LZB7DGfoEeckCd6NF3dO8C/UBNfhNOFjdcQ4pFMt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUeIkHRN1lvzu9REhSjwjHepwClYcjwIyh2KpHpjtDLX2h1KiSJfJD5TGvNMnPsr2
         QqIYGHbPwd98xYrzTgH9Mzk3x6MH0UjqxjqNxYTqwGaiufZ7IMiH5TZfwUDdn9rOty
         v3HcpSj7iI7fH2Xxfbcie+7MxzLmQ6rpmnxp4vrGjhBdvVKZLN6WlLpSaKdIOQHOtI
         dMh1FEYp01HKZ/k9XcnP0Da5Gjv6DZnG9jhX1Yg4PhdiPbvHOLoUnXhwED3t5sAlxm
         7sYKw6FCzJ2y5gegAq55rTo3ZNx6BFtQ7HBKD7BmqPOssaNcMRBrC/zMjPE0az1exN
         f9euHlxucs8ww==
Date:   Tue, 23 Mar 2021 23:53:30 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323145330.GB21687@redsun51.ssa.fujisawa.hgst.com>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de>
 <608f8198-8c0d-b59c-180b-51666840382d@grimberg.me>
 <250dc97d-8781-1655-02ca-5171b0bd6e24@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <250dc97d-8781-1655-02ca-5171b0bd6e24@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 09:36:47AM +0100, Hannes Reinecke wrote:
> On 3/23/21 8:31 AM, Sagi Grimberg wrote:
> > 
> > > Actually, I had been playing around with marking the entire bio as
> > > 'NOWAIT'; that would avoid the tag stall, too:
> > > 
> > > @@ -313,7 +316,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
> > >          ns = nvme_find_path(head);
> > >          if (likely(ns)) {
> > >                  bio_set_dev(bio, ns->disk->part0);
> > > -               bio->bi_opf |= REQ_NVME_MPATH;
> > > +               bio->bi_opf |= REQ_NVME_MPATH | REQ_NOWAIT;
> > >                  trace_block_bio_remap(bio, disk_devt(ns->head->disk),
> > >                                        bio->bi_iter.bi_sector);
> > >                  ret = submit_bio_noacct(bio);
> > > 
> > > 
> > > My only worry here is that we might incur spurious failures under
> > > high load; but then this is not necessarily a bad thing.
> > 
> > What? making spurious failures is not ok under any load. what fs will
> > take into account that you may have run out of tags?
> 
> Well, it's not actually a spurious failure but rather a spurious failover,
> as we're still on a multipath scenario, and bios will still be re-routed to
> other paths. Or queued if all paths are out of tags.
> Hence the OS would not see any difference in behaviour.

Failover might be overkill. We can run out of tags in a perfectly normal
situation, and simply waiting may be the best option, or even scheduling
on a different CPU may be sufficient to get a viable tag  rather than
selecting a different path.

Does it make sense to just abort all allocated tags during a reset and
let the original bio requeue for multipath IO?

 
> But in the end, we abandoned this attempt, as the crash we've been seeing
> was in bio_endio (due to bi_bdev still pointing to the removed path device):
> 
> [ 6552.155251]  bio_endio+0x74/0x120
> [ 6552.155260]  nvme_ns_head_submit_bio+0x36f/0x3e0 [nvme_core]
> [ 6552.155271]  submit_bio_noacct+0x175/0x490
> [ 6552.155284]  ? nvme_requeue_work+0x5a/0x70 [nvme_core]
> [ 6552.155290]  nvme_requeue_work+0x5a/0x70 [nvme_core]
> [ 6552.155296]  process_one_work+0x1f4/0x3e0
> [ 6552.155299]  worker_thread+0x2d/0x3e0
> [ 6552.155302]  ? process_one_work+0x3e0/0x3e0
> [ 6552.155305]  kthread+0x10d/0x130
> [ 6552.155307]  ? kthread_park+0xa0/0xa0
> [ 6552.155311]  ret_from_fork+0x35/0x40
> 
> So we're not blocked on blk_queue_enter(), and it's a crash, not a deadlock.
> Blocking on blk_queue_enter() certainly plays a part here,
> but is seems not to be the full picture.
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
> HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
