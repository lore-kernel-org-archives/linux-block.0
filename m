Return-Path: <hch@lst.de>
Date: Fri, 29 Jun 2018 10:58:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Fix blk_mq_end_request() and blk_end_request() for
	WRITE SAME
Message-ID: <20180629085827.GA16441@lst.de>
References: <20180626001009.16557-1-bart.vanassche@wdc.com> <yq1a7rh5yu6.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1a7rh5yu6.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Maybe it is time to remove REQ_OP_WRITE_SAME finally.  We don't have
a user except for drbd which is passing it from the other side, and
it creates way too many special cases like this.
