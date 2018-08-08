Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v5 5/9] block: Change the runtime power management
 approach (1/2)
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
 <20180807225133.27221-6-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <414b8689-f04a-abaa-d659-f29dffed7d3e@oracle.com>
Date: Wed, 8 Aug 2018 14:11:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180807225133.27221-6-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 08/08/2018 06:51 AM, Bart Van Assche wrote:
> @@ -391,6 +393,9 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>  		}
>  	}
>  	data->hctx->queued++;
> +
> +	blk_pm_add_request(q, rq);
> +
>  	return rq;
>  }

The request_queue is in pm_only mode when suspended, who can reach here to do the resume ?

Thanks
Jianchao
