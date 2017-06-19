Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 00/12] More patches for kernel v4.13
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20170608173355.25898-1-bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <578cb92c-4ebd-c5b7-903a-b248f709928f@kernel.dk>
Date: Sun, 18 Jun 2017 20:55:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170608173355.25898-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/08/2017 11:33 AM, Bart Van Assche wrote:
> Hello Jens,
> 
> This patch series contains one patch that reduces the size of struct
> blk_mq_hw_ctx, a few patches that simplify some of the block layer code and
> also patches that improve the block layer documentation. Please consider these
> patches for kernel v4.13.
> 
> The basis for these patches is a merge of your for-next and for-linus
> branches. Please note that the first patch in this series applies fine on top
> of the merge of these two branches but not on top of your for-next branch.

I seem to be missing some of the patches in this series, and I'm assuming
high likely hood of rejects due to recent churn. Would you mind resending
this series?

-- 
Jens Axboe
