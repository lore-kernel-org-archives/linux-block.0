Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 10/17] nvme: switch controller refcounting to use struct
 device
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-11-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b4e85bf7-f0ae-4ea9-2caa-3ba3645f88ea@grimberg.me>
Date: Thu, 19 Oct 2017 10:17:01 +0300
MIME-Version: 1.0
In-Reply-To: <20171018165258.23212-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



> -	if (!kref_get_unless_zero(&ctrl->ctrl.kref))
> -		return -EBUSY;
> +	nvme_get_ctrl(&ctrl->ctrl);

Given that we take this reference before we are protected with
the state change I think this should still be get_unless_zero.

Maybe we can introduce get_device_unless_zero() for this?
