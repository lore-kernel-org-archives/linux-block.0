Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v6 11/12] block: Change the runtime power management
 approach (2/2)
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
 <20180809194149.15285-12-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e69986b2-1cd4-ad00-5cd8-6500305cdbd1@oracle.com>
Date: Fri, 10 Aug 2018 09:51:12 +0800
MIME-Version: 1.0
In-Reply-To: <20180809194149.15285-12-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 08/10/2018 03:41 AM, Bart Van Assche wrote:
> +
> +	blk_set_pm_only(q);
> +	/*
> +	 * This function only gets called if the most recent
> +	 * pm_request_resume() call occurred at least autosuspend_delay_ms
> +	 * ago. Since blk_queue_enter() is called by the request allocation
> +	 * code before pm_request_resume(), if no requests have a tag assigned
> +	 * it is safe to suspend the device.
> +	 */
> +	ret = -EBUSY;
> +	if (blk_requests_in_flight(q) == 0) {
> +		/*
> +		 * Call synchronize_rcu() such that later blk_queue_enter()
> +		 * calls see the preempt-only state. See also
> +		 * https://urldefense.proofpoint.com/v2/url?u=http-3A__lwn.net_Articles_573497_&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=U9uPCJD2WnkXvdzrWaKPh2wJuk8-IHvxZ9sWDVrg2Tg&s=c9E23TPCpNQkiZpuzGztwHxjWF8qrESfRnPmI-e-Z48&e=.
> +		 */
> +		synchronize_rcu();
> +		if (blk_requests_in_flight(q) == 0)
> +			ret = 0;
> +	}

I still think blk_set_pm_only should be moved after blk_requests_in_flight.
Otherwise, the normal IO will be blocked for a little while if there are still
busy requests.

Thanks
Jianchao
