Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E4DC48BE6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 15:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9483761166
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 15:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhFPPxJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 11:53:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46290 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbhFPPxJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 11:53:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 50B3221A2C;
        Wed, 16 Jun 2021 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623858662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ik7/lTKGJ7YaEaouBcxxoQNt5wA3L4QE4PBz9Ub843w=;
        b=xrdFtpbObrTptTAIWPpxB14T+gDVqqlcmsNIjTL1uV01aMJM0XmRo7+NpGSPx4X9pG0m8K
        qZNHH+Rv+bYQgEq1JWijPXm3qaheUesJ/7pODwt9g+pOuLwyI3Gj2w7I/xievlsDBzg67d
        MzGxcsDDbVI5HzNLiVYHbKYIUn5rlAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623858662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ik7/lTKGJ7YaEaouBcxxoQNt5wA3L4QE4PBz9Ub843w=;
        b=z7ys97dxb36HzVRcqXUUziAK7PzQuJuQDWvJJ32kycuqmF8ytuPk7YnTMYwqqRD7ZrxB9J
        9i0DbauxQrJeoyCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 2B605A3BAD;
        Wed, 16 Jun 2021 15:51:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D10B31F2C68; Wed, 16 Jun 2021 17:51:01 +0200 (CEST)
Date:   Wed, 16 Jun 2021 17:51:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v2] block: Do not pull requests from the scheduler when
 we cannot dispatch them
Message-ID: <20210616155101.GB28250@quack2.suse.cz>
References: <20210603104721.6309-1-jack@suse.cz>
 <20210616154038.GA18520@quack2.suse.cz>
 <d61be138-7fc2-76d6-d01f-6ec555e46f29@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d61be138-7fc2-76d6-d01f-6ec555e46f29@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 16-06-21 09:43:06, Jens Axboe wrote:
> On 6/16/21 9:40 AM, Jan Kara wrote:
> > On Thu 03-06-21 12:47:21, Jan Kara wrote:
> >> Provided the device driver does not implement dispatch budget accounting
> >> (which only SCSI does) the loop in __blk_mq_do_dispatch_sched() pulls
> >> requests from the IO scheduler as long as it is willing to give out any.
> >> That defeats scheduling heuristics inside the scheduler by creating
> >> false impression that the device can take more IO when it in fact
> >> cannot.
> >>
> >> For example with BFQ IO scheduler on top of virtio-blk device setting
> >> blkio cgroup weight has barely any impact on observed throughput of
> >> async IO because __blk_mq_do_dispatch_sched() always sucks out all the
> >> IO queued in BFQ. BFQ first submits IO from higher weight cgroups but
> >> when that is all dispatched, it will give out IO of lower weight cgroups
> >> as well. And then we have to wait for all this IO to be dispatched to
> >> the disk (which means lot of it actually has to complete) before the
> >> IO scheduler is queried again for dispatching more requests. This
> >> completely destroys any service differentiation.
> >>
> >> So grab request tag for a request pulled out of the IO scheduler already
> >> in __blk_mq_do_dispatch_sched() and do not pull any more requests if we
> >> cannot get it because we are unlikely to be able to dispatch it. That
> >> way only single request is going to wait in the dispatch list for some
> >> tag to free.
> >>
> >> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> >> Signed-off-by: Jan Kara <jack@suse.cz>
> >> ---
> >>  block/blk-mq-sched.c | 12 +++++++++++-
> >>  block/blk-mq.c       |  2 +-
> >>  block/blk-mq.h       |  2 ++
> >>  3 files changed, 14 insertions(+), 2 deletions(-)
> >>
> >> Jens, can you please merge the patch? Thanks!
> > 
> > Ping Jens?
> 
> Didn't I reply? It's merged for a while:

No, I didn't get email back and didn't notice the patch is already in your
tree. Sorry for the noise.

								Honza

> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.14/block&id=613471549f366cdf4170b81ce0f99f3867ec4d16
> 
> -- 
> Jens Axboe
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
