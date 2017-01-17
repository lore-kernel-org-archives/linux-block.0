Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [PATCH 3/4] nvme: use blk_rq_payload_bytes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
 <1484306953-3194-4-git-send-email-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7532e18a-6cd3-294f-085d-e1ecdc48af6e@grimberg.me>
Date: Tue, 17 Jan 2017 22:06:51 +0200
MIME-Version: 1.0
In-Reply-To: <1484306953-3194-4-git-send-email-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>


> @@ -1014,9 +1013,9 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
>  	}
>

Christoph, a little above here we still look at blk_rq_bytes(),
shouldn't that look at blk_rq_payload_bytes() too?

>  	if (count == 1) {
> -		if (rq_data_dir(rq) == WRITE &&
> -		    map_len <= nvme_rdma_inline_data_size(queue) &&
> -		    nvme_rdma_queue_idx(queue))
> +		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
> +		    blk_rq_payload_bytes(rq) <=
> +				nvme_rdma_inline_data_size(queue))
>  			return nvme_rdma_map_sg_inline(queue, req, c);
>
>  		if (dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
