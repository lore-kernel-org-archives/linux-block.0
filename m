Return-Path: <hch@lst.de>
Date: Tue, 31 Jul 2018 17:19:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 6/6] virtio-blk: modernize sysfs attribute creation
Message-ID: <20180731151906.GA880@lst.de>
References: <20180730071227.22887-1-hare@suse.de> <20180730071227.22887-7-hare@suse.de> <20180731181145-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180731181145-mutt-send-email-mst@kernel.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 31, 2018 at 06:11:59PM +0300, Michael S. Tsirkin wrote:
> On Mon, Jul 30, 2018 at 09:12:27AM +0200, Hannes Reinecke wrote:
> > Use new-style DEVICE_ATTR_RO/DEVICE_ATTR_RW to create the sysfs attributes
> > and register the disk with default sysfs attribute groups.
> > 
> > Signed-off-by: Hannes Reinecke <hare@suse.com>
> > Cc: Michael Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> what's the right tree to merge this?

The whole series should go in through the block tree I think.
