Return-Path: <hch@lst.de>
Date: Wed, 4 Oct 2017 08:57:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v5 4/8] block: Convert RQF_PREEMPT into REQ_PREEMPT
Message-ID: <20171004065731.GB20879@lst.de>
References: <20171002225218.18548-1-bart.vanassche@wdc.com> <20171002225218.18548-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002225218.18548-5-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

So as pointed out in the last run (after changing my mind deeper into
the series) I think we should instead use a BLK_MQ_REQ_PREEMPT flag.

The preempt only makes sense at the request level, not for file system
requests.  For the legacy case we can add blk_get_request_flags that
takes the BLK_MQ_REQ_* flags, which is a much saner interface than the
current blk_get_request anyway.
