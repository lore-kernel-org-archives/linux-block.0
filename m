Return-Path: <hch@lst.de>
Date: Wed, 9 Nov 2016 03:05:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
Message-ID: <20161109020517.GA759@lst.de>
References: <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com> <a74de948-3026-d9b3-6b2e-b9cc1f3c05d4@deltatee.com> <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com> <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com> <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com> <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com> <20161109010959.GA32126@lst.de> <b3d8c5fa-b930-b21f-3986-1ff94611c7f9@wdc.com> <a6d1d368-04a2-e999-a610-abd96add81a9@fb.com> <03cda65e-3a82-6ccd-861b-67a55888eb19@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <03cda65e-3a82-6ccd-861b-67a55888eb19@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 08, 2016 at 07:02:52PM -0700, Jens Axboe wrote:
> It smells like an accounting error. One thing that I don't like with the
> current scheme is the implicit knowledge that certain flags imply sync
> as well. If we clear any of those flags, then we screw up accounting at
> the end.
>
> Does this make a difference?

That looks interesting.  In the meantime I reproduced a similar
hang, but only half-way through an xfstests run with a non-mq device.
I'll see how far I can narrow it down and will give your patch a try as
well.
