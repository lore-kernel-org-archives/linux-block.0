Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08867C76190
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 03:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83E02229A
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 03:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbfGWDbU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:31:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731320AbfGWDbT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 23:31:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 336FF3082A49;
        Tue, 23 Jul 2019 03:31:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B6AC19C6A;
        Tue, 23 Jul 2019 03:31:09 +0000 (UTC)
Date:   Tue, 23 Jul 2019 11:31:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] blk-mq: Export blk_mq_hctx_has_pending() function
Message-ID: <20190723033103.GA13829@ming.t460p>
References: <cover.1563782844.git.baolin.wang@linaro.org>
 <94a0d20e6304b909391abd9a425c71c376cad964.1563782844.git.baolin.wang@linaro.org>
 <20190722141940.GA26528@ming.t460p>
 <CAMz4ku+R8OdAQ2S91Xe=V-nZL1Nu5g=_xpHqQCzNF6JeBHY3rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4ku+R8OdAQ2S91Xe=V-nZL1Nu5g=_xpHqQCzNF6JeBHY3rw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 23 Jul 2019 03:31:19 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 23, 2019 at 11:12:57AM +0800, Baolin Wang wrote:
> Hi Ming,
> 
> On Mon, 22 Jul 2019 at 22:19, Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Jul 22, 2019 at 09:09:36PM +0800, Baolin Wang wrote:
> > > Some SD/MMC host controllers can support packed command or packed request,
> > > that means we can package several requests to host controller at one time
> > > to improve performence. And this patch set will introduce MMC packed function
> > > to support this feature by following patches.
> > >
> > > To support MMC packed function, the MMC layer need to know if there are
> > > requests are pending now in hardware queue to help to combine requests
> > > as much as possible. If we know there are requests pending in hardware
> > > queue, then we should not package requests to host controller immediately,
> > > instead we should collect more requests into MMC packed queue to be packed
> > > to host controller with packed condition.
> > >
> > > Thus export this function for MMC packed function.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  block/blk-mq.c         |    3 ++-
> > >  include/linux/blk-mq.h |    1 +
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index b038ec6..5bd4ef9 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -63,12 +63,13 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
> > >   * Check if any of the ctx, dispatch list or elevator
> > >   * have pending work in this hardware queue.
> > >   */
> > > -static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
> > > +bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
> > >  {
> > >       return !list_empty_careful(&hctx->dispatch) ||
> > >               sbitmap_any_bit_set(&hctx->ctx_map) ||
> > >                       blk_mq_sched_has_work(hctx);
> > >  }
> > > +EXPORT_SYMBOL_GPL(blk_mq_hctx_has_pending);
> >
> > Just wondering why you don't use the 'last' field of 'struct blk_mq_queue_data',
> > which is passed to .queue_rq(), and supposed for implementing batch submission.
> 
> The 'last' field of 'struct blk_mq_queue_data' does not indicate the
> last request in the hardware queue, since we want to collect more
> requests from block layer as much as possible to be packed later.
> 
> And from blk_mq_do_dispatch_sched()--->blk_mq_dispatch_rq_list()--->
> queue_rq(), I always get 'bd.last = true', which is not useful to
> combine requests for MMC packed queue. Maybe I missed anything?

That is one flaw of current implementation, and we may improve it,
so other drivers(virtio-io, ...) can benefit from it too.


Thanks,
Ming
