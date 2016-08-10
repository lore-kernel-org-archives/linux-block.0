Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 9 Aug 2016 23:55:42 -0400
From: Tejun Heo <tj@kernel.org>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] blk-mq: fix hang caused by freeze/unfreeze
 sequence
Message-ID: <20160810035542.GE25053@mtj.duckdns.org>
References: <20160808113908.5445-1-roman.penyaev@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160808113908.5445-1-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Aug 08, 2016 at 01:39:08PM +0200, Roman Pen wrote:
> Long time ago there was a similar fix proposed by Akinobu Mita[1],
> but it seems that time everyone decided to fix this subtle race in
> percpu-refcount and Tejun Heo[2] did an attempt (as I can see that
> patchset was not applied).

So, I probably forgot about it while waiting for confirmation of fix.
Can you please verify that the patchset fixes the issue?  I can apply
the patchset right away.

Thanks.

-- 
tejun
