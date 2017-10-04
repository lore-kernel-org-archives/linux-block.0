Return-Path: <hch@lst.de>
Date: Wed, 4 Oct 2017 09:06:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v5 8/8] block: Make SCSI device suspend and resume work
	reliably
Message-ID: <20171004070642.GF20879@lst.de>
References: <20171002225218.18548-1-bart.vanassche@wdc.com> <20171002225218.18548-9-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002225218.18548-9-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

As mentioned before - if you pass BLK_MQ_REQ_* to blk_queue_enter
this should become a bit nicer without the need for two magic bool
parameters.
