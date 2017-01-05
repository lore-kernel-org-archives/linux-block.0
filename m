Return-Path: <hch@lst.de>
Date: Thu, 5 Jan 2017 12:17:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	mst@redhat.com, jasowang@redhat.com, linux-block@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_blk: avoid DMA to stack for the sense buffer
Message-ID: <20170105111759.GA17051@lst.de>
References: <1483507505-26797-1-git-send-email-hch@lst.de> <1483507505-26797-2-git-send-email-hch@lst.de> <CAD9gYJKe5wbQkMGvVhZ0MUbLAAFumubk+k-nVhMDiha9FEQNTg@mail.gmail.com> <20170105095706.GA15566@lst.de> <CAD9gYJ+w4YshNR_G5zHG2SNb9fAhrF9vMbF6=ee-kYbehfGMyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAD9gYJ+w4YshNR_G5zHG2SNb9fAhrF9vMbF6=ee-kYbehfGMyw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 05, 2017 at 11:37:46AM +0100, 王金浦 wrote:
> Thanks, so it's only relevant to kernel > 4.9, as  CONFIG_VMAP_STACK
> only introduced in 4.9 kernel.

kernel >= 4.9, but otherwise, yes.
