Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:54328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAWRUX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 12:20:23 -0500
Date: Mon, 23 Jan 2017 09:20:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: BUG: KASAN: Use-after-free
Message-ID: <20170123172021.GA28446@infradead.org>
References: <0b458b92-62ee-bffc-8f3e-fbd6490b26fd@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <0b458b92-62ee-bffc-8f3e-fbd6490b26fd@bjorling.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 23, 2017 at 05:07:52PM +0100, Matias Bj�rling wrote:
> Hi,
> 
> I could use some help verifying an use-after-free bug that I am seeing
> after the new direct I/O work went in.
> 
> When issuing a direct write io using libaio, a bio is referenced in the
> blkdev_direct_IO path, and then put again in the blkdev_bio_end_io path.
> However, there is a case where the bio is put twice, which leads to
> modules that rely on the bio after biodev_bio_end_io() to access it
> prematurely.

Can you reproduce anything like this with a normal block device?

> 
> The KASAN error report:
> 
> [   14.645916]
> ==================================================================
> [   14.648027] BUG: KASAN: use-after-free in
> blkdev_direct_IO+0x50c/0x600 at addr ffff8801ef30ea14

Can you resolve that address for me, please?

> Which boils down to the bio already being freed, when we hit the
> module's endio function.
> 
> The double bio_put() occurs when dio->should_dirty = 0, and dio->is_sync
> = 0. The flow follows:
> 
> Issuing:
>   blkdev_direct_IO
>      get_bio(bio)

bio refcounting in __blkdev_direct_IO is the following

first bio is allocated using bio_alloc_bioset to embedd the dio structure
into it.  We then grab a second reference to that bio and only that one.
Each other new bio just gets it's single reference from bio_alloc.

blkdev_bio_end_io then checks if we hit the last reference on the dio, in
which case it then drops the additional reference on the first bio after
calling the aio completion handler.  Once that is done it always drops the
reference for the current bio - either explicitly or through
bio_check_pages_dirty in the should_dirty case.

>      submit_io()
>        rrpc make_request(bio)
>          get_bio(bio)
> Completion:
>   blkdev_bio_end_io
>     bio_put(bio)
>     bio_put(bio) - bio is freed

Yes, and that's how it's intended.

>   rrpc_end_io
>     bio_put(bio) (use-after-free access)

Can you check this is the same bio that got submitted and it didn't
get bounced somewhere?
