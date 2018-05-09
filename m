Return-Path: <BATV+e0efdd19ce80d487e3da+5372+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>,
	Geoff Levand <geoff@infradead.org>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	linux-block@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org,
	sparclinux@vger.kernel.org
Subject: make a few block drivers highmem safe
Date: Wed,  9 May 2018 15:59:41 +0200
Message-Id: <20180509135948.20329-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series converts a few random block drivers to be highmem safe,
in preparation of eventually getting rid of the block layer bounce
buffering support.
