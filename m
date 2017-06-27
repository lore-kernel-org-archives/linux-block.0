Return-Path: <BATV+44f69bf97f3b7d1cdb28+5056+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 27 Jun 2017 07:53:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
	martin.petersen@oracle.com
Subject: Re: [PATCH 4/9] fs: add O_DIRECT support for sending down write life
 time hints
Message-ID: <20170627145356.GA3355@infradead.org>
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
 <1498491480-16306-5-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498491480-16306-5-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

> -			bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_SYNC | REQ_IDLE);
> +			bio_set_op_attrs(bio, REQ_OP_WRITE,
> +						REQ_SYNC | REQ_IDLE);

			bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
