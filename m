Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D2AC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C11B20840
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbfAPXJc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:09:32 -0500
Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:31607 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731892AbfAPXJb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:09:31 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl2.internode.on.net with ESMTP; 17 Jan 2019 09:39:21 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gjuJE-0003Bq-OE; Thu, 17 Jan 2019 10:09:20 +1100
Date:   Thu, 17 Jan 2019 10:09:20 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 12/15] io_uring: add support for pre-mapped user IO
 buffers
Message-ID: <20190116230920.GT4205@dastard>
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-13-axboe@kernel.dk>
 <20190116205338.GQ4205@dastard>
 <9db63405-6797-9305-3ce1-fdc11edbf49c@kernel.dk>
 <20190116220938.GR4205@dastard>
 <7fd5cb40-2288-3c54-41d1-3163098b25ef@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd5cb40-2288-3c54-41d1-3163098b25ef@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 16, 2019 at 03:21:21PM -0700, Jens Axboe wrote:
> On 1/16/19 3:09 PM, Dave Chinner wrote:
> > On Wed, Jan 16, 2019 at 02:20:53PM -0700, Jens Axboe wrote:
> >> On 1/16/19 1:53 PM, Dave Chinner wrote:
> >> I'd be fine with that restriction, especially since it can get relaxed
> >> down the line. Do we have an appropriate API for this?  And why isn't
> >> get_user_pages_longterm() that exact API already?
> > 
> > get_user_pages_longterm() is the right thing to use to ensure DAX
> > doesn't trip over this - it's effectively just get_user_pages()
> > with a "if (vma_is_fsdax(vma))" check in it to abort and return
> > -EOPNOTSUPP. IOWs, this is safe on DAX but it's not safe on anything
> > else. :/
> > 
> > Unfortunately, disallowing userspace GUP pins on non-DAX file backed
> > pages will break existing "mostly just work" userspace apps all over
> > the place. And so right now there are discussions ongoing about how
> > to map gup references avoid the writeback races and be able to be
> > seen/tracked by other kernel infrastructure (see the long, long
> > thread "[PATCH 0/2] put_user_page*(): start converting the call
> > sites" on -fsdevel). Progress is slow, but I think we're starting to
> > close on a workable solution.
> > 
> > FWIW, this doesn't solve the "long term user pin will block
> > filesystem operations until unpin" problem, that's what moving to
> > using revocable file layout leases is intended to solve. There have
> > been patches posted some time ago to add this user API for this, but
> > we've got to solve the other problems first....
> > 
> >> Would seem that most
> >> (all?) callers of this API is currently broken then.
> > 
> > Yup, there's a long, long history of machines using userspace RDMA
> > panicing because filesystems have detected or tripped over invalid
> > page cache state during writeback attempts. This is not a new
> > problem....
> 
> Thanks for your detailed answer, Dave! I didn't see it before I sent
> out the previous email. FWIW, I've updated the patch:
> 
> http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=0c8f2299f8069af6b2fa8f99a10d81646d1237a7
> 
> Checks for file backed memory, fails the registration with EOPNOTSUPP
> if the check fails.

Doesn't it need to call put_pages() on all the pages picked up by
get_user_pages_longterm() when it returns -EOPNOTSUPP? They haven't
been mapped into the imu->bvec array yet, so AFAICT there's nothing
to release the page references on teardown here.

Also, not a vma expert here, but the vma array contents may only be
valid while the mmap_sem is held - I think vmas can come and go
after it has been dropped and so accessing vmas to check
vma->vm_file after the mmap_sem has been dropped may be open to
read-after-free races.

> That should handle the issue on the io_uring side at least, and it's a
> restriction that can always be relaxed/lifted, when appropriate solutions
> to file backed buffers exists.

Modulo the issue above, that works for me.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
