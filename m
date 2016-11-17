Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 17 Nov 2016 04:50:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCHSET] Add support for simplified async direct-io
Message-ID: <20161117125037.GB14814@infradead.org>
References: <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
 <20161114180503.GA31126@infradead.org>
 <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
 <20161114181119.GA9396@infradead.org>
 <f8c29e81-7323-7362-b507-1b7c61e8a19a@fb.com>
 <20161116163147.GA25038@infradead.org>
 <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
 <20161116171652.GA30008@infradead.org>
 <c46c5e60-a5eb-2862-2b1b-f994fd0d3fe3@kernel.dk>
 <c2e20890-16ce-a3bd-c696-c53ae14a583a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c2e20890-16ce-a3bd-c696-c53ae14a583a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 16, 2016 at 09:43:57PM -0700, Jens Axboe wrote:
> OK, I'm getting reasonably happy with it now:
> 
> http://git.kernel.dk/cgit/linux-block/log/?h=for-4.10/hch-dio
> 
> Sharing the FUA setting to avoid the manual flush between the two, and
> removing the remnants of SYNC support from __blkdev_direct_IO().
> 
> I'll fire off some overnight testing now and leave it for the day.

This looks reasonable, a couple questions and comments:

 - why the 8 * BIO_MAX_PAGES in the call to iov_iter_npages,
   that probably needs a comment
 - I'll probably need to write up a proper changelog and fold
   in at least the multi_bio patch.
 - I'd just return the op from dio_bio_set_write_op instead of
   passing the bio, that reads a lot easier.
 - I should probably get rid of blkdev_dio_pool in favour
   of bio_kmalloc

I can look into doing these fixups this afternoon and prepare a tre
for you.
