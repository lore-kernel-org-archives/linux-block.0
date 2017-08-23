Return-Path: <hch@lst.de>
Date: Wed, 23 Aug 2017 20:01:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: don't require a struct block_device to submit a bio
Message-ID: <20170823180143.GA5802@lst.de>
References: <20170823171032.30529-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823171032.30529-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Patch 6 didn't seem to make it through to the list, so here is a
link to the git tree:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bi_bdev
