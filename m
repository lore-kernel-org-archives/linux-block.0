Return-Path: <BATV+8132ee8c7e24eb087ca3+5055+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 26 Jun 2017 02:56:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] xfs: add support for passing in write hints for
 buffered writes
Message-ID: <20170626095617.GF14057@infradead.org>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-8-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498004526-4543-8-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

> +	ioend->io_bio->bi_opf |= write_hint_to_opf(inode_write_hint(ioend->io_inode));

Too long line again.

I think simply adding an inode_hint_to_opf() flag would make the various
opencoded versions of the above call a little easier to read.
