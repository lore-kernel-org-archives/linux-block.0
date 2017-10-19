Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 03/17] block: provide a direct_make_request helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d8605553-ef38-4aa2-1513-39ae49de3856@grimberg.me>
Date: Thu, 19 Oct 2017 13:35:58 +0300
MIME-Version: 1.0
In-Reply-To: <20171018165258.23212-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> +/**
> + * direct_make_request - hand a buffer directly to its device driver for I/O
> + * @bio:  The bio describing the location in memory and on the device.
> + *
> + * This function behaves like generic_make_request(), but does not protect
> + * against recursion.  Must only be used if the called driver is known
> + * to not call generic_make_request (or direct_make_request) again from
> + * its make_request function.  (Calling direct_make_request again from
> + * a workqueue is perfectly fine as that doesn't recurse).

Question: are the double spaces on purpose?
