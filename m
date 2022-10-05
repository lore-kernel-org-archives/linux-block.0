Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1A7C433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 14:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJEOUL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJEOUH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 10:20:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8CE22502
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 07:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D5A1B81E0E
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 14:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7A4C433C1;
        Wed,  5 Oct 2022 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664979604;
        bh=J4LvHXg4Q3IG9Xuu/C8ZiHp05LrKnIyPnVCmA9dmmLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nq6BwKm7dsAnHwKS0KOcq5hI9a+QPU1DN87g67dmrnywX8vVfUQe+6PNa7bLOrPgJ
         Fd7DDJZ345nRp12nKsuJEJxx2dv/QF7RhspOvUoCC+dwEy0ejZNW5/92RBDEk/hsHC
         QNiLThFm9V2m/xgZ9HJc/spiLmXCtokCDQCSGq9Bc/6/2k1ZT6zVmjAjWr8CflyN/x
         hVsZegRFDPBDXhoTVA7+7IAKBYYGKC8Dy1jpq6JBl/sLkYskgnBKyhZnJmcNWem51N
         ytSQrkpM1I/8yLZBTVsaBOfUedt2+nGSRr4bb3kksiK/HPD3Hu2u8OirftCOsB5+bv
         rxv1JZG1kUWzg==
Date:   Wed, 5 Oct 2022 08:20:00 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: lockdep WARNING at blktests block/011
Message-ID: <Yz2SkNORASzmL+jq@kbusch-mbp.dhcp.thefacebook.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <20221004104456.ik42oxynyujsu5vb@shindev>
 <63e14e00-e877-cb5a-a69a-ff44bed8b5a5@I-love.SAKURA.ne.jp>
 <20221004122354.xxqpughpvnisz5qs@shindev>
 <20221005083104.2k7nqohqcqcrdpn4@shindev>
 <15c6e51f-a2a4-38ff-15a4-9efee32824d3@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c6e51f-a2a4-38ff-15a4-9efee32824d3@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 05, 2022 at 07:00:30PM +0900, Tetsuo Handa wrote:
> On 2022/10/05 17:31, Shinichiro Kawasaki wrote:
> > @@ -5120,11 +5120,27 @@ EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
> >  void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
> >  {
> >  	struct nvme_ns *ns;
> > +	LIST_HEAD(splice);
> >  
> > -	down_read(&ctrl->namespaces_rwsem);
> > -	list_for_each_entry(ns, &ctrl->namespaces, list)
> > +	/*
> > +	 * blk_sync_queues() call in ctrl->snamespaces_rwsem critical section
> > +	 * triggers deadlock warning by lockdep since cancel_work_sync() in
> > +	 * blk_sync_queue() waits for nvme_timeout() work completion which may
> > +	 * lock the ctrl->snamespaces_rwsem. To avoid the deadlock possibility,
> > +	 * call blk_sync_queues() out of the critical section by moving the
> > +         * ctrl->namespaces list elements to the stack list head temporally.
> > +	 */
> > +
> > +	down_write(&ctrl->namespaces_rwsem);
> > +	list_splice_init(&ctrl->namespaces, &splice);
> > +	up_write(&ctrl->namespaces_rwsem);
> 
> Does this work?
> 
> ctrl->namespaces being empty when calling blk_sync_queue() means that
> e.g. nvme_start_freeze() cannot find namespaces to freeze, doesn't it?

There can't be anything to timeout at this point. The controller is disabled
prior to syncing the queues. Not only is there no IO for timeout work to
operate on, the controller state is already disabled, so a subsequent freeze
would be skipped.
 
>   blk_mq_timeout_work(work) { // Is blocking __flush_work() from cancel_work_sync().
>     blk_mq_queue_tag_busy_iter(blk_mq_check_expired) {
>       bt_for_each(blk_mq_check_expired) == blk_mq_check_expired() {
>         blk_mq_rq_timed_out() {
>           req->q->mq_ops->timeout(req) == nvme_timeout(req) {
>             nvme_dev_disable() {
>               mutex_lock(&dev->shutdown_lock); // Holds dev->shutdown_lock
>               nvme_start_freeze(&dev->ctrl) {
>                 down_read(&ctrl->namespaces_rwsem); // Holds ctrl->namespaces_rwsem which might block
>                 //blk_freeze_queue_start(ns->queue); // <= Never be called because ctrl->namespaces is empty.
>                 up_read(&ctrl->namespaces_rwsem);
>               }
>               mutex_unlock(&dev->shutdown_lock);
>             }
>           }
>         }
>       }
>     }
>   }
> 
> Are you sure that down_read(&ctrl->namespaces_rwsem) users won't run
> when ctrl->namespaces is temporarily made empty? (And if you are sure
> that down_read(&ctrl->namespaces_rwsem) users won't run when
> ctrl->namespaces is temporarily made empty, why ctrl->namespaces_rwsem
> needs to be a rw-sem rather than a plain mutex or spinlock ?)

We iterate the list in some target fast paths, so we don't want this to be an
exclusive section for readers.
 
> > +	list_for_each_entry(ns, &splice, list)
> >  		blk_sync_queue(ns->queue);
> > -	up_read(&ctrl->namespaces_rwsem);
> > +
> > +	down_write(&ctrl->namespaces_rwsem);
> > +	list_splice(&splice, &ctrl->namespaces);
> > +	up_write(&ctrl->namespaces_rwsem);
> >  }
> >  EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
> 
> I don't know about dependency chain, but you might be able to add
> "struct nvme_ctrl"->sync_io_queue_mutex which is held for serializing
> nvme_sync_io_queues() and down_write(&ctrl->namespaces_rwsem) users?
> 
> If we can guarantee that ctrl->namespaces_rwsem => ctrl->sync_io_queue_mutex
> is impossible, nvme_sync_io_queues() can use ctrl->sync_io_queue_mutex
> rather than ctrl->namespaces_rwsem, and down_write(&ctrl->namespaces_rwsem)/
> up_write(&ctrl->namespaces_rwsem) users are replaced with
>   mutex_lock(&ctrl->sync_io_queue_mutex);
>   down_write(&ctrl->namespaces_rwsem);
> and
>   up_write(&ctrl->namespaces_rwsem);
>   mutex_unlock(&ctrl->sync_io_queue_mutex);
> sequences respectively.
> 
