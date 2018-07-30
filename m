Return-Path: <hch@lst.de>
Date: Mon, 30 Jul 2018 11:03:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
	Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 6/6] virtio-blk: modernize sysfs attribute creation
Message-ID: <20180730090325.GF12038@lst.de>
References: <20180730071227.22887-1-hare@suse.de> <20180730071227.22887-7-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730071227.22887-7-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 30, 2018 at 09:12:27AM +0200, Hannes Reinecke wrote:
> Use new-style DEVICE_ATTR_RO/DEVICE_ATTR_RW to create the sysfs attributes
> and register the disk with default sysfs attribute groups.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Cc: Michael Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
