Return-Path: <hch@lst.de>
Date: Wed, 8 Nov 2017 19:23:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V7 2/8] blokc: mq-deadline: Introduce dispatch helpers
Message-ID: <20171108182345.GA579@lst.de>
References: <20171108081118.7632-1-damien.lemoal@wdc.com> <20171108081118.7632-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171108081118.7632-3-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Except for a bit of mis-spelling in the Subject this looks fine
to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

FYI, I would just simplify the subject to

mq-deadline: Introduce dispatch helpers

and similar in the other patches.
