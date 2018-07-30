Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: blk_init_allocated_queue() set q->fq as NULL in
 the fail case
To: xiao jin <jin.xiao@intel.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: tom.leiming@gmail.com, bart.vanassche@wdc.com, stable@vger.kernel.org,
 yanmin.zhang@intel.com, Ming Lei <ming.lei@redhat.com>
References: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0bd7c6a3-4c55-d2f4-9b48-01f3898891b8@kernel.dk>
Date: Mon, 30 Jul 2018 08:28:49 -0600
MIME-Version: 1.0
In-Reply-To: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/30/18 12:11 AM, xiao jin wrote:
> We find the memory use-after-free issue in __blk_drain_queue()
> on the kernel 4.14. After read the latest kernel 4.18-rc6 we
> think it has the same problem.
> 
> Memory is allocated for q->fq in the blk_init_allocated_queue().
> If the elevator init function called with error return, it will
> run into the fail case to free the q->fq.
> 
> Then the __blk_drain_queue() uses the same memory after the free
> of the q->fq, it will lead to the unpredictable event.
> 
> The patch is to set q->fq as NULL in the fail case of
> blk_init_allocated_queue().

Applied, thanks.

-- 
Jens Axboe
