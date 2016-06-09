Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53052 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbcFIV2r (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 17:28:47 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: <linux-block@vger.kernel.org>
Subject: Re: [PATCH] cfq: priority boost on meta/prio marked IO
References: <20160608204347.GA30146@kernel.dk>
Date: Thu, 09 Jun 2016 17:28:45 -0400
In-Reply-To: <20160608204347.GA30146@kernel.dk> (Jens Axboe's message of "Wed,
	8 Jun 2016 14:43:47 -0600")
Message-ID: <x4937omxd9u.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Jens Axboe <axboe@fb.com> writes:

> At Facebook, we have a number of cases where people use ionice to set a
> lower priority, then end up having tasks stuck for a long time because
> eg meta data updates from an idle priority tasks is blocking out higher
> priority processes. It's bad enough that it will trigger the softlockup
> warning.
>
> This patch adds code to CFQ that bumps the priority class and data for
> an idle task, if is doing IO marked as PRIO or META. With this, we no
> longer see the softlockups.
>
> Signed-off-by: Jens Axboe <axboe@fb.com>
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 32a283eb7274..3cfd67d006fb 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1781,6 +1781,11 @@ get_rq:
>  		rw_flags |= REQ_SYNC;
>  
>  	/*
> +	 * Add in META/PRIO flags, if set, before we get to the IO scheduler
> +	 */
> +	rw_flags |= (bio->bi_rw & (REQ_META | REQ_PRIO));
> +
> +	/*

This needs a docbook update.  It now reads:

 * @rw_flags: RW and SYNC flags

so whatever flags we're adding should be specified, I guess.

Speaking of which, after much waffling, I think I've decided it would be
cleaner to limit the priority boost to REQ_PRIO requests only.

Other than that, I think this looks fine.

Cheers,
Jeff
