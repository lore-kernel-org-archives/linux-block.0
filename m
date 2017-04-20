Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Fix poll_stat for new size-based bucketing.
To: sbates@raithlin.com
References: <1492729151-20983-1-git-send-email-sbates@raithlin.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Damien.LeMoal@wdc.com, osandov@osandov.com, sagi@grimberg.me
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <44a0b09e-d150-a0e8-f5e2-5792f4d4f74a@kernel.dk>
Date: Thu, 20 Apr 2017 17:12:08 -0600
MIME-Version: 1.0
In-Reply-To: <1492729151-20983-1-git-send-email-sbates@raithlin.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/20/2017 04:59 PM, sbates@raithlin.com wrote:
> From: Stephen Bates <sbates@raithlin.com>
> 
> Fixes an issue where the size of the poll_stat array in request_queue
> does not match the size expected by the new size based bucketing for
> IO completion polling.
> 
> Should be applied on top of commit 720b8ccc4500 ("blk-mq: Add a
> polling specific stats function").

Thanks, added. BTW, in the future, we have a format for specifying
if a patch fixes another patch. This should have been:

Fixes: 720b8ccc4500 ("blk-mq: Add a polling specific stats function")

-- 
Jens Axboe
