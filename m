Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9197DC77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 06:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjEPGZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 02:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjEPGZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 02:25:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F84215
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 23:24:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7E6BF68C7B; Tue, 16 May 2023 08:24:13 +0200 (CEST)
Date:   Tue, 16 May 2023 08:24:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't
 called for passthrough request
Message-ID: <20230516062409.GB7325@lst.de>
References: <20230515144601.52811-1-ming.lei@redhat.com> <20230515144601.52811-3-ming.lei@redhat.com> <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org> <ZGKUehOEnKThjFpR@kbusch-mbp> <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 16, 2023 at 09:20:55AM +0800, Ming Lei wrote:
> > That sounds like a good idea. It changes more behavior than what Ming is
> > targeting here, but after looking through each use for RQF_ELV, I think
> > not having that set really is the right thing to do in all cases for
> > passthrough requests.
> 
> I did consider that approach. But:
> 
> - RQF_ELV actually means that the request & its tag is allocated from sched tags.
> 
> - if RQF_ELV is cleared for passthrough request, request may be
>   allocated from sched tags(normal IO) and driver tags(passthrough) at the same time.
>   This way may cause other problem, such as, breaking blk_mq_hctx_has_requests().
>   Meantime it becomes not likely to optimize tags resource utilization in future,
>   at least for single LUN/NS, no need to keep sched tags & driver tags
>   in memory at the same time.

Then make that obvious.  That is:

 - rename RQF_ELV to RQV_SCHED_TAGS
 - add the RQV_SCHED_TAGS check to your blk_mq_bypass_sched helper.
   I'd also invert the return value and rename it to someting like
   blk_rq_use_sched.
