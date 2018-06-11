Return-Path: <hch@lst.de>
Date: Mon, 11 Jun 2018 08:24:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: linux-block@vger.kernel.org, Jinpu Wang <jinpu.wang@profitbricks.com>,
	Gi-Oh Kim <gi-oh.kim@profitbricks.com>,
	Danil Kipnis <danil.kipnis@profitbricks.com>,
	Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/1] blk-mq: reinit q->tag_set_list entry only after
	grace period
Message-ID: <20180611062424.GB32641@lst.de>
References: <20180610203824.16512-1-roman.penyaev@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180610203824.16512-1-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
