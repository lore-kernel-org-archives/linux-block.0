Return-Path: <BATV+229e43960758331738db+4848+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 1 Dec 2016 02:16:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	Wei Fang <fangwei1@huawei.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Rabin Vincent <rabinv@axis.com>, stable@vger.kernel.org
Subject: Re: [PATCH] block: protect iterate_bdevs() against concurrent close
Message-ID: <20161201101601.GC13993@infradead.org>
References: <1480580308-15342-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480580308-15342-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
