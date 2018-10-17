Return-Path: <hch@lst.de>
Date: Wed, 17 Oct 2018 08:21:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	anton.ivanov@cambridgegreys.com, dwalter@google.com
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
Message-ID: <20181017062150.GA22028@lst.de>
References: <20181015065637.1860-1-hch@lst.de> <2132215.oDDApMmxLa@blindfold> <4bd66e34-acc5-053f-888e-d4e58c3cf440@kernel.dk> <5155064.LnyfiXsD0j@blindfold> <da877cdc-7873-30fd-fa33-72cd48419d46@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <da877cdc-7873-30fd-fa33-72cd48419d46@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 16, 2018 at 08:26:31AM -0600, Jens Axboe wrote:
> > Yes. Shall I send a patch with your suggestion or will you?
> 
> Christoph should just fold it in, the bug only exists after his
> change to it.

Sorry, I missed what suggestion we had.  Is that the patch form Jens
earlier?

> 
> > I have one more question, in your first conversion you set queue_depth to 2.
> > How does one know this value?
> > My conversion has 64, which is more or less an educated guess... ;)
> 
> 64 is most likely just fine. Some drivers rely on having 1 in flight and
> it's easier to manage to just let blk-mq take care of that. Outside of that,
> there aren't any magic values. We should probably just use BLKDEV_MAX_RQ
> for ones that don't have a specific hw limit or need.

Is a queue depth > 1 actually safe for ubd?  There are some odd global
variables tracking struct io_thread_req.
