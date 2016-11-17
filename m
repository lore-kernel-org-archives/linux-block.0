Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 17 Nov 2016 04:46:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCHSET] Add support for simplified async direct-io
Message-ID: <20161117124644.GA14814@infradead.org>
References: <20161114180052.GA24476@infradead.org>
 <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
 <20161114180503.GA31126@infradead.org>
 <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
 <20161114181119.GA9396@infradead.org>
 <f8c29e81-7323-7362-b507-1b7c61e8a19a@fb.com>
 <20161116163147.GA25038@infradead.org>
 <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
 <20161116171652.GA30008@infradead.org>
 <c46c5e60-a5eb-2862-2b1b-f994fd0d3fe3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c46c5e60-a5eb-2862-2b1b-f994fd0d3fe3@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 16, 2016 at 01:02:05PM -0700, Jens Axboe wrote:
> I'm fine with this approach, but I would still REALLY like to see
> blkdev_bio_end_io() split in two, once for sync and once for async. That
> would be a lot cleaner, imho.

Do you still want that?  It's not in your latest tree even with all
the other changes.
