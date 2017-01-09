Return-Path: <hch@lst.de>
Date: Mon, 9 Jan 2017 14:35:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Wang <jasowang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, mst@redhat.com,
	linux-block@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: avoid DMA to stack for the sense buffer
Message-ID: <20170109133545.GA24146@lst.de>
References: <1483507505-26797-1-git-send-email-hch@lst.de> <1483507505-26797-2-git-send-email-hch@lst.de> <9e69ed20-aa30-4a9a-7137-a123fab033ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e69ed20-aa30-4a9a-7137-a123fab033ff@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Is someone going to pick the patch up and send it to Linus?  I keep
running into all kinds of boot failures whenever I forget to cherry
pick it into my development trees..
