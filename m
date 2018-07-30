Return-Path: <hch@lst.de>
Date: Mon, 30 Jul 2018 11:01:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
	"Ed L . Cachin" <ed.cashin@acm.org>
Subject: Re: [PATCH 4/6] aoe: use device_add_disk_with_groups()
Message-ID: <20180730090137.GD12038@lst.de>
References: <20180730071227.22887-1-hare@suse.de> <20180730071227.22887-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730071227.22887-5-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 30, 2018 at 09:12:25AM +0200, Hannes Reinecke wrote:
> Use device_add_disk_with_groups() to avoid a race condition with
> udev during startup.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Cc: Ed L. Cachin <ed.cashin@acm.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
