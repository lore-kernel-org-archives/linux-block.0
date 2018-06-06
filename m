Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: pass failfast and driver-specific flags to flush
 requests
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20180606142140.64146-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2768f375-53cc-35db-5f6a-915735e9fd01@kernel.dk>
Date: Wed, 6 Jun 2018 08:28:11 -0600
MIME-Version: 1.0
In-Reply-To: <20180606142140.64146-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/6/18 8:21 AM, Hannes Reinecke wrote:
> If flush requests are being sent to the device we need to inherit the
> failfast and driver-specific flags, too, otherwise I/O will fail.

Looks good to me.

-- 
Jens Axboe
