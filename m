Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: mtip32xx: fixes and cleanups
Date: Fri,  9 Nov 2018 14:48:53 +0100
Message-Id: <20181109134902.32057-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Various low hanging fruit, kicked of by seeing one of the few remaining
req->special users.

Compile tested only.
