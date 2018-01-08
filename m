Return-Path: <BATV+16a315d4c50e4aa35f4a+5251+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 8 Jan 2018 03:54:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [GIT PULL 24/25] lightnvm: pblk: add iostat support
Message-ID: <20180108115457.GA28922@infradead.org>
References: <20180105131621.20808-1-m@bjorling.me>
 <20180105131621.20808-25-m@bjorling.me>
 <20180105154230.GA13829@kernel.dk>
 <2491bb34-2098-32f5-3d5b-e3d89fbce4b3@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2491bb34-2098-32f5-3d5b-e3d89fbce4b3@bjorling.me>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 05, 2018 at 07:33:36PM +0100, Matias Bj�rling wrote:
> On 01/05/2018 04:42 PM, Jens Axboe wrote:
> > On Fri, Jan 05 2018, Matias Bj�rling wrote:
> > > From: Javier Gonz�lez <javier@cnexlabs.com>
> > > 
> > > Since pblk registers its own block device, the iostat accounting is
> > > not automatically done for us. Therefore, add the necessary
> > > accounting logic to satisfy the iostat interface.
> > 
> > Ignorant question - why is it a raw block device, not using blk-mq?
> 
> The current flow is using the raw block device, together with the blk-mq
> nvme device driver. A bio is sent down to the nvme_nvm_submit_io() path in
> the /drivers/nvme/host/lightnvm.c file. From there it attaches the to NVMe
> blk-mq implementation.
> 
> Is there a better way to do it?

I suspect the right way to do things is to split NVMe for different
I/O command sets, and make this an I/O command set.

But before touching much of NVMe, I'd really, really like to see an
actual spec first.
