Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] skd: Remove driver version information
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20170818152228.7236-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <606965b5-3962-da5a-dd38-616a7baa152c@kernel.dk>
Date: Fri, 18 Aug 2017 09:31:37 -0600
MIME-Version: 1.0
In-Reply-To: <20170818152228.7236-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 09:22 AM, Bart Van Assche wrote:
> Remove the driver version information because this information
> is not useful in an upstream kernel driver.

Thanks Bart, applied.

-- 
Jens Axboe
