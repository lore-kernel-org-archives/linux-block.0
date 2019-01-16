Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1875C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B413020651
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 20:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfAPUxn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:53:43 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:18636 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726783AbfAPUxm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 15:53:42 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 17 Jan 2019 07:23:40 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gjsBu-00032d-Gs; Thu, 17 Jan 2019 07:53:38 +1100
Date:   Thu, 17 Jan 2019 07:53:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 12/15] io_uring: add support for pre-mapped user IO
 buffers
Message-ID: <20190116205338.GQ4205@dastard>
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-13-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116175003.17880-13-axboe@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 16, 2019 at 10:50:00AM -0700, Jens Axboe wrote:
> If we have fixed user buffers, we can map them into the kernel when we
> setup the io_context. That avoids the need to do get_user_pages() for
> each and every IO.
.....
> +			return -ENOMEM;
> +	} while (atomic_long_cmpxchg(&ctx->user->locked_vm, cur_pages,
> +					new_pages) != cur_pages);
> +
> +	return 0;
> +}
> +
> +static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
> +{
> +	int i, j;
> +
> +	if (!ctx->user_bufs)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ctx->sq_entries; i++) {
> +		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
> +
> +		for (j = 0; j < imu->nr_bvecs; j++) {
> +			set_page_dirty_lock(imu->bvec[j].bv_page);
> +			put_page(imu->bvec[j].bv_page);
> +		}

Hmmm, so we call set_page_dirty() when the gup reference is dropped...

.....

> +static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
> +				  unsigned nr_args)
> +{

.....

> +		down_write(&current->mm->mmap_sem);
> +		pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
> +						pages, NULL);
> +		up_write(&current->mm->mmap_sem);

Thought so. This has the same problem as RDMA w.r.t. using
file-backed mappings for the user buffer.  It is not synchronised
against truncate, hole punches, async page writeback cleaning the
page, etc, and so can lead to data corruption and/or kernel panics.

It also can't be used with DAX because the above problems are
actually a user-after-free of storage space, not just a dangling
page reference that can be cleaned up after the gup pin is dropped.

Perhaps, at least until we solve the GUP problems w.r.t. file backed
pages and/or add and require file layout leases for these reference,
we should error out if the  user buffer pages are file-backed
mappings?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
