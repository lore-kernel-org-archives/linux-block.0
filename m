Return-Path: <hch@lst.de>
Date: Thu, 19 Oct 2017 09:20:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/17] nvme: switch controller refcounting to use
	struct device
Message-ID: <20171019072053.GA12168@lst.de>
References: <20171018165258.23212-1-hch@lst.de> <20171018165258.23212-11-hch@lst.de> <b4e85bf7-f0ae-4ea9-2caa-3ba3645f88ea@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b4e85bf7-f0ae-4ea9-2caa-3ba3645f88ea@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 19, 2017 at 10:17:01AM +0300, Sagi Grimberg wrote:
>
>
>> -	if (!kref_get_unless_zero(&ctrl->ctrl.kref))
>> -		return -EBUSY;
>> +	nvme_get_ctrl(&ctrl->ctrl);
>
> Given that we take this reference before we are protected with
> the state change I think this should still be get_unless_zero.

Because we now refcount the device we must have a reference on it
when we call the sysfs file for it, and for the fabrics file
we have an explicit reference already.  So there should not be
any need to do the unless_zero.

> Maybe we can introduce get_device_unless_zero() for this?

I thought about it for the other open coded versions and my decision
was that I want to send a patch for it next merge window, but not
now to avoid having to coordinate with the driver core tree.
