Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: bart.vanassche@wdc.com, tj@kernel.org, ming.lei@redhat.com,
 Martin@Lichtvoll.de, stable@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f1e278d0-bcf8-506d-7298-0a194f4893f0@kernel.dk>
Date: Mon, 16 Apr 2018 21:56:20 -0600
MIME-Version: 1.0
In-Reply-To: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/16/18 9:46 PM, Jianchao Wang wrote:
> rq->gstate and rq->aborted_gstate both are zero before rqs are
> allocated. If we have a small timeout, when the timer fires,
> there could be rqs that are never allocated, and also there could
> be rq that has been allocated but not initialized and started. At
> the moment, the rq->gstate and rq->aborted_gstate both are 0, thus
> the blk_mq_terminate_expired will identify the rq is timed out and
> invoke .timeout early.
> 
> For scsi, this will cause scsi_times_out to be invoked before the
> scsi_cmnd is not initialized, scsi_cmnd->device is still NULL at
> the moment, then we will get crash.

Oops, this looks good to me. Applied.

-- 
Jens Axboe
