Return-Path: <hch@lst.de>
Date: Fri, 2 Mar 2018 23:27:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] block: Suppress kernel-doc warnings triggered by
	blk-zoned.c
Message-ID: <20180302222719.GB30953@lst.de>
References: <20180301162026.13970-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180301162026.13970-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although I think this should say 'fixes kernel-doc warnings' instead
of supressing them, as the old comments use invalid syntax.
