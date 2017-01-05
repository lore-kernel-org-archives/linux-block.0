Return-Path: <jinpuwang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170105095706.GA15566@lst.de>
References: <1483507505-26797-1-git-send-email-hch@lst.de> <1483507505-26797-2-git-send-email-hch@lst.de>
 <CAD9gYJKe5wbQkMGvVhZ0MUbLAAFumubk+k-nVhMDiha9FEQNTg@mail.gmail.com> <20170105095706.GA15566@lst.de>
From: =?UTF-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Date: Thu, 5 Jan 2017 11:37:46 +0100
Message-ID: <CAD9gYJ+w4YshNR_G5zHG2SNb9fAhrF9vMbF6=ee-kYbehfGMyw@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: avoid DMA to stack for the sense buffer
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, mst@redhat.com, jasowang@redhat.com,
	linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

2017-01-05 10:57 GMT+01:00 Christoph Hellwig <hch@lst.de>:
> On Wed, Jan 04, 2017 at 04:47:03PM +0100, =E7=8E=8B=E9=87=91=E6=B5=A6 wro=
te:
>> This sounds scary.
>> Could you share how to reproduce it, this should go into stable if
>> it's the case.
>
> Step 1: Build your kernel with CONFIG_VMAP_STACK=3Dy
> Step 2: issue a SG_IO ioctl, e.g. sg_inq /dev/vda
>
Thanks, so it's only relevant to kernel > 4.9, as  CONFIG_VMAP_STACK
only introduced in 4.9 kernel.

Regards,
Jinpu
