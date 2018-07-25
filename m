Return-Path: <axboe@kernel.dk>
Subject: Re: [Regression] Linux-Next Merge 25Jul2018 breaks mmc on Tegra.
To: Peter Geis <pgwipeout@gmail.com>, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <dacd3c28-2bfc-dd42-18a2-641217848126@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <835eb17a-e192-d991-04b6-f0c82c32311e@kernel.dk>
Date: Wed, 25 Jul 2018 11:17:24 -0700
MIME-Version: 1.0
In-Reply-To: <dacd3c28-2bfc-dd42-18a2-641217848126@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/25/18 10:28 AM, Peter Geis wrote:
> Good Afternoon,
> 
> I have encountered an issue on both Tegra 2 and Tegra 3 devices 
> accessing emmc following the 25 July 2018 remote tracking merge.
> 
> The offending commit is:
> 6ce3dd6eec114930cf2035a8bcb1e80477ed79a8
> blk-mq: issue directly if hw queue isn't busy in case of 'none'.

Can you try my current for-next? This should fix it:

commit 8824f62246bef288173a6624a363352f0d4d3b09
Author: Ming Lei <ming.lei@redhat.com>
Date:   Sun Jul 22 14:10:15 2018 +0800

    blk-mq: fail the request in case issue failure


-- 
Jens Axboe
