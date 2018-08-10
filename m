Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v6 05/12] block, scsi: Rename QUEUE_FLAG_PREEMPT_ONLY into
 DV_ONLY and introduce PM_ONLY
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
 <20180809194149.15285-6-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <dacf2f33-f1d7-2708-d2b8-50fd26d768ca@oracle.com>
Date: Fri, 10 Aug 2018 09:39:00 +0800
MIME-Version: 1.0
In-Reply-To: <20180809194149.15285-6-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 08/10/2018 03:41 AM, Bart Van Assche wrote:
> +/*
> + * Whether or not blk_queue_enter() should proceed. RQF_PM requests are always
> + * allowed. RQF_DV requests are allowed if the PM_ONLY queue flag has not been
> + * set. Other requests are only allowed if neither PM_ONLY nor DV_ONLY has been
> + * set.
> + */
> +static inline bool blk_enter_allowed(struct request_queue *q,
> +				     blk_mq_req_flags_t flags)
> +{
> +	return flags & BLK_MQ_REQ_PM ||
> +		(!blk_queue_pm_only(q) &&
> +		 (flags & BLK_MQ_REQ_DV || !blk_queue_dv_only(q)));
> +}

If a new state is indeed necessary, I think this kind of checking in hot path is inefficient.
How about introduce a new state into request_queue, such as request_queue->gate_state.
Set the PM_ONLY and DV_ONLY into this state, then we could just check request_queue->gate_state > 0
before do further checking.

Thanks
Jianchao
