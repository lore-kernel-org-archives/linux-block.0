Return-Path: <hch@lst.de>
Date: Thu, 5 Jan 2017 10:57:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	mst@redhat.com, jasowang@redhat.com, linux-block@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_blk: avoid DMA to stack for the sense buffer
Message-ID: <20170105095706.GA15566@lst.de>
References: <1483507505-26797-1-git-send-email-hch@lst.de> <1483507505-26797-2-git-send-email-hch@lst.de> <CAD9gYJKe5wbQkMGvVhZ0MUbLAAFumubk+k-nVhMDiha9FEQNTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAD9gYJKe5wbQkMGvVhZ0MUbLAAFumubk+k-nVhMDiha9FEQNTg@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 04, 2017 at 04:47:03PM +0100, 王金浦 wrote:
> This sounds scary.
> Could you share how to reproduce it, this should go into stable if
> it's the case.

Step 1: Build your kernel with CONFIG_VMAP_STACK=y
Step 2: issue a SG_IO ioctl, e.g. sg_inq /dev/vda
