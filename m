Return-Path: <hch@lst.de>
Date: Tue, 4 Apr 2017 08:40:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 2/5] blk-mq: Make it safe to use RCU to iterate over
	blk_mq_tag_set.tag_list
Message-ID: <20170404064038.GB9168@lst.de>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com> <20170403232228.11208-3-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170403232228.11208-3-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 03, 2017 at 04:22:25PM -0700, Bart Van Assche wrote:
> A later patch in this series will namely use RCU to iterate over
> this list.

It also adds a couple lockdep_assert_held calls, which might be worth
mentionining.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
