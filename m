Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHv4 0/5] genhd: register default groups with
 device_add_disk()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Bart van Assche <bvanassche@acm.org>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20180928061723.13180-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ca3e3be0-2ca4-6474-d8be-697ab7cc133b@kernel.dk>
Date: Fri, 28 Sep 2018 08:30:53 -0600
MIME-Version: 1.0
In-Reply-To: <20180928061723.13180-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/28/18 12:17 AM, Hannes Reinecke wrote:
> device_add_disk() doesn't allow to register with default sysfs groups,
> which introduces a race with udev as these groups have to be created after
> the uevent has been sent.
> This patchset updates device_add_disk() to accept a 'groups' argument to
> avoid this race and updates the obvious drivers to use it.
> There are some more drivers which might benefit from this (eg loop or md),
> but the interface is not straightforward so I haven't attempted it.

Thanks Hannes, applied for 4.20.

-- 
Jens Axboe
