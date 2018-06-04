Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: return when BLK_MQ_S_STOPPED in
 blk_mq_run_work_fn
To: Jianchao Wang <jianchao.w.wang@oracle.com>, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d6cee6a0-d20a-0055-24f7-a3e625c2f5b3@kernel.dk>
Date: Mon, 4 Jun 2018 10:21:14 -0600
MIME-Version: 1.0
In-Reply-To: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/4/18 3:03 AM, Jianchao Wang wrote:
> if hctx is stopped, don't run the queue in blk_mq_run_work_fn.

I was puzzled, so had to look up those changes. That's definitely
a regression caused by 15fe8a9, as you highlighted. Looks good to
me, I'll apply it.

BTW, this should have been explained in the commit message. I'll
change it a bit.

-- 
Jens Axboe
