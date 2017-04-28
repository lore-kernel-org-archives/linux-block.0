Return-Path: <hch@lst.de>
Date: Fri, 28 Apr 2017 16:24:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] blk-mq: update ->init_request and ->exit_request
	prototypes
Message-ID: <20170428142444.GA1082@lst.de>
References: <20170427174501.18965-1-hch@lst.de> <20170427174501.18965-2-hch@lst.de> <x49inlpsoey.fsf@segfault.boston.devel.redhat.com> <20170428140923.GA32073@lst.de> <e97a7758-075f-f48a-9a5f-52ce9ac8c1ec@kernel.dk> <588c2352-08f8-721b-37d5-ba90a1794c5d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <588c2352-08f8-721b-37d5-ba90a1794c5d@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 28, 2017 at 08:20:26AM -0600, Jens Axboe wrote:
> Actually, I'll leave it as-is, just base things on top of for-next for
> now.

Ok.  I'll resend the init_request changes then, as having request_idx
around in a blk-mq iosched world is actively harmful.
