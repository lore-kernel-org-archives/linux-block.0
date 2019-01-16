Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24901C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 22:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDF420675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 22:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbfAPWOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:14:46 -0500
Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:65372 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732540AbfAPWOq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 17:14:46 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2019 17:14:44 EST
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail02.adl2.internode.on.net with ESMTP; 17 Jan 2019 08:39:39 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gjtNS-000380-VF; Thu, 17 Jan 2019 09:09:39 +1100
Date:   Thu, 17 Jan 2019 09:09:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 12/15] io_uring: add support for pre-mapped user IO
 buffers
Message-ID: <20190116220938.GR4205@dastard>
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-13-axboe@kernel.dk>
 <20190116205338.GQ4205@dastard>
 <9db63405-6797-9305-3ce1-fdc11edbf49c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db63405-6797-9305-3ce1-fdc11edbf49c@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 16, 2019 at 02:20:53PM -0700, Jens Axboe wrote:
> On 1/16/19 1:53 PM, Dave Chinner wrote:
> > On Wed, Jan 16, 2019 at 10:50:00AM -0700, Jens Axboe wrote:
> >> If we have fixed user buffers, we can map them into the kernel when we
> >> setup the io_context. That avoids the need to do get_user_pages() for
> >> each and every IO.
> > .....
> >> +			return -ENOMEM;
> >> +	} while (atomic_long_cmpxchg(&ctx->user->locked_vm, cur_pages,
> >> +					new_pages) != cur_pages);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
> >> +{
> >> +	int i, j;
> >> +
> >> +	if (!ctx->user_bufs)
> >> +		return -EINVAL;
> >> +
> >> +	for (i = 0; i < ctx->sq_entries; i++) {
> >> +		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
> >> +
> >> +		for (j = 0; j < imu->nr_bvecs; j++) {
> >> +			set_page_dirty_lock(imu->bvec[j].bv_page);
> >> +			put_page(imu->bvec[j].bv_page);
> >> +		}
> > 
> > Hmmm, so we call set_page_dirty() when the gup reference is dropped...
> > 
> > .....
> > 
> >> +static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
> >> +				  unsigned nr_args)
> >> +{
> > 
> > .....
> > 
> >> +		down_write(&current->mm->mmap_sem);
> >> +		pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
> >> +						pages, NULL);
> >> +		up_write(&current->mm->mmap_sem);
> > 
> > Thought so. This has the same problem as RDMA w.r.t. using
> > file-backed mappings for the user buffer.  It is not synchronised
> > against truncate, hole punches, async page writeback cleaning the
> > page, etc, and so can lead to data corruption and/or kernel panics.
> > 
> > It also can't be used with DAX because the above problems are
> > actually a user-after-free of storage space, not just a dangling
> > page reference that can be cleaned up after the gup pin is dropped.
> > 
> > Perhaps, at least until we solve the GUP problems w.r.t. file backed
> > pages and/or add and require file layout leases for these reference,
> > we should error out if the  user buffer pages are file-backed
> > mappings?
> 
> Thanks for taking a look at this.
> 
> I'd be fine with that restriction, especially since it can get relaxed
> down the line. Do we have an appropriate API for this?  And why isn't
> get_user_pages_longterm() that exact API already?

get_user_pages_longterm() is the right thing to use to ensure DAX
doesn't trip over this - it's effectively just get_user_pages()
with a "if (vma_is_fsdax(vma))" check in it to abort and return
-EOPNOTSUPP. IOWs, this is safe on DAX but it's not safe on anything
else. :/

Unfortunately, disallowing userspace GUP pins on non-DAX file backed
pages will break existing "mostly just work" userspace apps all over
the place. And so right now there are discussions ongoing about how
to map gup references avoid the writeback races and be able to be
seen/tracked by other kernel infrastructure (see the long, long
thread "[PATCH 0/2] put_user_page*(): start converting the call
sites" on -fsdevel). Progress is slow, but I think we're starting to
close on a workable solution.

FWIW, this doesn't solve the "long term user pin will block
filesystem operations until unpin" problem, that's what moving to
using revocable file layout leases is intended to solve. There have
been patches posted some time ago to add this user API for this, but
we've got to solve the other problems first....

> Would seem that most
> (all?) callers of this API is currently broken then.

Yup, there's a long, long history of machines using userspace RDMA
panicing because filesystems have detected or tripped over invalid
page cache state during writeback attempts. This is not a new
problem....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
