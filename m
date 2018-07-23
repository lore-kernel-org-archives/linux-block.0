Return-Path: <BATV+57f4d657a4d3ec61a87c+5447+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 23 Jul 2018 00:18:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: ioprio: Replace GFP_ATOMIC with GFP_KERNEL in
 set_task_ioprio()
Message-ID: <20180723071803.GA30817@infradead.org>
References: <20180723022116.6919-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180723022116.6919-1-baijiaju1990@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

But to me it seems that btrfs and maybe ext4 as well would be much
better off just setting a per-IO priority in the bio.

Any chance yo could look into that?
