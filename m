Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 16/17] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-17-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b975ad9e-a40a-0e89-1a8d-fc9e417ff681@grimberg.me>
Date: Mon, 23 Oct 2017 20:43:13 +0300
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-17-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>   static inline bool nvme_req_needs_retry(struct request *req)
>   {
>   	if (blk_noretry_request(req))
> @@ -143,6 +204,11 @@ static inline bool nvme_req_needs_retry(struct request *req)
>   void nvme_complete_rq(struct request *req)
>   {
>   	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
> +		if (nvme_req_needs_failover(req)) {
> +			nvme_failover_req(req);
> +			return;
> +		}
> +
>   		nvme_req(req)->retries++;
>   		blk_mq_requeue_request(req, true);
>   		return;

Nit, consider having the !nvme_req_needs_failover() case in an else
clause, just a suggestion though.



> @@ -171,6 +237,18 @@ void nvme_cancel_request(struct request *req, void *data, bool reserved)
>   }
>   EXPORT_SYMBOL_GPL(nvme_cancel_request);

Question,

Does the statement in nvme_cancel_request:

         if (blk_queue_dying(req->q))
                 status |= NVME_SC_DNR;

still holds?
