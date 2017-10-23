Return-Path: <hch@lst.de>
Date: Mon, 23 Oct 2017 09:30:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Israel Rukshin <israelr@mellanox.com>,
	Linux-nvme <linux-nvme-bounces@lists.infradead.org>,
	linux-block@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Iterate also over sched_tags requests at
	blk_mq_tagset_iter()
Message-ID: <20171023073009.GB17954@lst.de>
References: <1508680074-2417-1-git-send-email-israelr@mellanox.com> <2c27d643-a7d9-3077-2875-cea768cbf386@grimberg.me> <20171023062627.GD16899@lst.de> <68bf7dff-d186-eb09-b853-254d0ae6f3e5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <68bf7dff-d186-eb09-b853-254d0ae6f3e5@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 23, 2017 at 10:27:29AM +0300, Sagi Grimberg wrote:
> Note that it does introduce a new spinlock to our hot-path, but given
> the current over-allocation scheme with schedulers, its probably better
> off.

We could look into llists if it matters.
