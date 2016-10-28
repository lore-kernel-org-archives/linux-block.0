Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Always schedule hctx->next_cpu
To: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
References: <1475033064-31848-1-git-send-email-krisman@linux.vnet.ibm.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <30903392-09d5-9b0f-d139-d36af7fe9071@kernel.dk>
Date: Fri, 28 Oct 2016 15:54:26 -0600
MIME-Version: 1.0
In-Reply-To: <1475033064-31848-1-git-send-email-krisman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/27/2016 09:24 PM, Gabriel Krisman Bertazi wrote:
> Commit 0e87e58bf60e ("blk-mq: improve warning for running a queue on the
> wrong CPU") attempts to avoid triggering the WARN_ON in
> __blk_mq_run_hw_queue when the expected CPU is dead.  Problem is, in the
> last batch execution before round robin, blk_mq_hctx_next_cpu can
> schedule a dead CPU and also update next_cpu to the next alive CPU in
> the mask, which will trigger the WARN_ON despite the previous
> workaround.
>
> The following patch fixes this scenario by always scheduling the value
> in hctx->next_cpu.  This changes the moment when we round-robin the CPU
> running the hctx, but it really doesn't matter, since it still executes
> BLK_MQ_CPU_WORK_BATCH times in a row before switching to another CPU.

Thanks, this looks good. Applied for 4.9.

-- 
Jens Axboe
