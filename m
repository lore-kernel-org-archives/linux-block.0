Return-Path: <BATV+8132ee8c7e24eb087ca3+5055+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 26 Jun 2017 02:52:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add support for write hints in a bio
Message-ID: <20170626095221.GC14057@infradead.org>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-3-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498004526-4543-3-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Looks fine for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(although I suspect we'll eventually move to a hints field
separate from the REQ_* flags).
