Return-Path: <hch@lst.de>
Date: Mon, 10 Apr 2017 09:10:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v4 1/6] blk-mq: Make it safe to use RCU to iterate over
	blk_mq_tag_set.tag_list
Message-ID: <20170410071036.GA5559@lst.de>
References: <20170407181654.27836-1-bart.vanassche@sandisk.com> <20170407181654.27836-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170407181654.27836-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
