Return-Path: <BATV+d9901c46b23ecc19815a+5342+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@wdc.com,
	willy@infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC] fix confusion around GFP_* flags and blk_get_request
Date: Mon,  9 Apr 2018 17:39:09 +0200
Message-Id: <20180409153916.23901-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series sorts out the mess around how we use gfp flags in the
block layer get_request interface.
