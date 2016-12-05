Return-Path: <BATV+942a091854393eb11ca5+4852+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 5 Dec 2016 04:37:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nicolai Stange <nicstange@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>,
	Shaun Tancheff <shaun.tancheff@seagate.com>,
	Damien Le Moal <damien.lemoal@hgst.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix unintended fallthrough in
 generic_make_request_checks()
Message-ID: <20161205123707.GA29220@infradead.org>
References: <20161204135639.7016-1-nicstange@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161204135639.7016-1-nicstange@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Oops, thanks for the fix:

Reviewed-by: Christoph Hellwig <hch@lst.de>
