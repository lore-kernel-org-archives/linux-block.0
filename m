Return-Path: <BATV+fb72f72259c0915ed969+5064+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 5 Jul 2017 11:27:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: bcache@lists.ewheeler.net
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	hch@infradead.org, axboe@kernel.dk,
	Liang Chen <liangchen.linux@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 06/19] bcache: explicitly destory mutex while exiting
Message-ID: <20170705182729.GE10673@infradead.org>
References: <20170629134510.GA32385@infradead.org>
 <1498855388-16990-1-git-send-email-bcache@lists.ewheeler.net>
 <1498855388-16990-6-git-send-email-bcache@lists.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498855388-16990-6-git-send-email-bcache@lists.ewheeler.net>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 30, 2017 at 01:42:55PM -0700, bcache@lists.ewheeler.net wrote:
> From: Liang Chen <liangchen.linux@gmail.com>
> 
> mutex_destroy does nothing most of time, but it's better to call
> it to make the code future proof and it also has some meaning
> for like mutex debug.

It shouldn't really - we should get the destroy behavior for free
when doing a slab free of the area.

What issue are you trying to solve?
