Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] virtio_blk: avoid DMA to stack for the sense buffer
To: Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>
References: <1483507505-26797-1-git-send-email-hch@lst.de>
 <1483507505-26797-2-git-send-email-hch@lst.de>
 <9e69ed20-aa30-4a9a-7137-a123fab033ff@redhat.com>
 <20170109133545.GA24146@lst.de>
Cc: mst@redhat.com, linux-block@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f7e3ee2e-ebe6-5a8e-2043-afcdd62f2865@kernel.dk>
Date: Mon, 9 Jan 2017 08:56:43 -0700
MIME-Version: 1.0
In-Reply-To: <20170109133545.GA24146@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/09/2017 06:35 AM, Christoph Hellwig wrote:
> Is someone going to pick the patch up and send it to Linus?  I keep
> running into all kinds of boot failures whenever I forget to cherry
> pick it into my development trees..

I'll add it.

-- 
Jens Axboe
