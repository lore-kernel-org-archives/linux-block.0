Return-Path: <BATV+acab11531514b6d0482e+4833+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 16 Nov 2016 09:16:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCHSET] Add support for simplified async direct-io
Message-ID: <20161116171652.GA30008@infradead.org>
References: <20161114173728.GA22167@infradead.org>
 <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
 <20161114180052.GA24476@infradead.org>
 <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
 <20161114180503.GA31126@infradead.org>
 <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
 <20161114181119.GA9396@infradead.org>
 <f8c29e81-7323-7362-b507-1b7c61e8a19a@fb.com>
 <20161116163147.GA25038@infradead.org>
 <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

I've pushed out a new version of my code that avoids atomic ops
for the single bio case:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/new-dio

I think we should take your extension of the existing
__blkdev_direct_IO_simple to kmalloc up to BIO_MAX_PAGES and then use
the above implementation for AIO and large synchronous I/O.

I think I can also kill of blkdev_dio_pool by simply using bio_kmalloc
as we're only doing the allocation at the beginning of the call,
but I'd like to agree on an approach before spending too much time on
it.
