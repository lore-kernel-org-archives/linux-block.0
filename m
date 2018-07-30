Return-Path: <hch@lst.de>
Date: Mon, 30 Jul 2018 10:57:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/6] block: genhd: add 'groups' argument to
	device_add_disk
Message-ID: <20180730085740.GB12038@lst.de>
References: <20180730071227.22887-1-hare@suse.de> <20180730071227.22887-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730071227.22887-3-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 30, 2018 at 09:12:23AM +0200, Hannes Reinecke wrote:
> Update device_add_disk() to take an 'groups' argument so that
> individual drivers can register a device with additional sysfs
> attributes.
> This avoids race condition the driver would otherwise have if these
> groups were to be created with sysfs_add_groups().
> 
> Signed-off-by: Martin Wilck <martin.wilck@suse.com>
> Signed-off-by: Hannes Reinecke <hare@suse.com>

The first signoff should always be the author.

Otherwise this looks fine (modulo any context changes due to patch 1):

Reviewed-by: Christoph Hellwig <hch@lst.de>
