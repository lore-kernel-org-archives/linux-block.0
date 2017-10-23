Return-Path: <hch@lst.de>
Date: Mon, 23 Oct 2017 18:57:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 16/17] nvme: implement multipath access to nvme
	subsystems
Message-ID: <20171023165720.GA28944@lst.de>
References: <20171023145126.2471-1-hch@lst.de> <20171023145126.2471-17-hch@lst.de> <68df1af0-7cc8-febc-e2f6-85251f120a76@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <68df1af0-7cc8-febc-e2f6-85251f120a76@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 23, 2017 at 06:32:47PM +0300, Sagi Grimberg wrote:
>>   	struct nvme_queue *nvmeq = hctx->driver_data;
>>   +	printk_ratelimited("%s: called\n", __func__);
>> +
>
> This must be a left-over...

Indeed, it is a left-over debug statement..
