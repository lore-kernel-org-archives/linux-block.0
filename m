Return-Path: <hch@lst.de>
Date: Thu, 18 Jan 2018 17:28:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/3] block: Protect less code with sysfs_lock in
	blk_{un,}register_queue()
Message-ID: <20180118162818.GD26078@lst.de>
References: <20180117194810.26583-1-bart.vanassche@wdc.com> <20180117194810.26583-4-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180117194810.26583-4-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
