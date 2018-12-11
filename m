Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC97C07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84AD20811
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84AD20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeLKNlh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:41:37 -0500
Received: from verein.lst.de ([213.95.11.211]:55408 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeLKNlh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 08:41:37 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D4AF268DD2; Tue, 11 Dec 2018 14:41:35 +0100 (CET)
Date:   Tue, 11 Dec 2018 14:41:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/5] nvme-tcp: support separate queue maps for read and
 write
Message-ID: <20181211134135.GD20614@lst.de>
References: <20181211104936.25333-1-sagi@grimberg.me> <20181211104936.25333-5-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211104936.25333-5-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 02:49:34AM -0800, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/tcp.c | 53 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 15543358e245..5c0ba99fb105 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1215,7 +1215,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>  	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>  	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>  	struct linger sol = { .l_onoff = 1, .l_linger = 0 };
> -	int ret, opt, rcv_pdu_size;
> +	int ret, opt, rcv_pdu_size, n;
>  
>  	queue->ctrl = ctrl;
>  	INIT_LIST_HEAD(&queue->send_list);
> @@ -1271,7 +1271,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>  	}
>  
>  	queue->sock->sk->sk_allocation = GFP_ATOMIC;
> -	queue->io_cpu = (qid == 0) ? 0 : qid - 1;
> +	n = (qid ? qid - 1 : 0) % num_online_cpus();
> +	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
>  	queue->request = NULL;
>  	queue->data_remaining = 0;
>  	queue->ddgst_remaining = 0;
> @@ -1433,6 +1434,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
>  		set->driver_data = ctrl;
>  		set->nr_hw_queues = nctrl->queue_count - 1;
>  		set->timeout = NVME_IO_TIMEOUT;
> +		set->nr_maps = 2 /* default + read */;
>  	}
>  
>  	ret = blk_mq_alloc_tag_set(set);
> @@ -1527,7 +1529,12 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>  
>  static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
>  {
> -	return min(ctrl->queue_count - 1, num_online_cpus());
> +	unsigned int nr_io_queues;
> +
> +	nr_io_queues = min(ctrl->opts->nr_io_queues, num_online_cpus());
> +	nr_io_queues += min(ctrl->opts->nr_write_queues, num_online_cpus());
> +
> +	return nr_io_queues;
>  }
>  
>  static int nvme_alloc_io_queues(struct nvme_ctrl *ctrl)
> @@ -2052,6 +2059,38 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	return BLK_STS_OK;
>  }
>  
> +static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
> +{
> +	struct nvme_tcp_ctrl *ctrl = set->driver_data;
> +	struct blk_mq_queue_map *map;
> +
> +	if (ctrl->ctrl.opts->nr_write_queues) {
> +		/* separate read/write queues */
> +		map = &set->map[HCTX_TYPE_DEFAULT];
> +		map->queue_offset = 0;
> +		map->nr_queues = ctrl->ctrl.opts->nr_write_queues;
> +		blk_mq_map_queues(map);

Shouldn't this use nr_io_queues?

> +		map = &set->map[HCTX_TYPE_READ];
> +		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
> +		map->queue_offset = ctrl->ctrl.opts->nr_write_queues;
> +		blk_mq_map_queues(map);
> +	} else {
> +		/* mixed read/write queues */
> +		map = &set->map[HCTX_TYPE_DEFAULT];
> +		map->queue_offset = 0;
> +		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
> +		blk_mq_map_queues(map);
> +
> +		map = &set->map[HCTX_TYPE_READ];
> +		map->queue_offset = 0;
> +		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
> +		blk_mq_map_queues(map);

Also I find the reused local map variable a little odd and not helpful
for readability.  What about something like:

static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
{
	struct nvme_tcp_ctrl *ctrl = set->driver_data;

	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
	set->map[HCTX_TYPE_DEFAULT].nr_queues = ctrl->ctrl.opts->nr_io_queues;
	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);

	if (ctrl->ctrl.opts->nr_write_queues) {
		/* separate read/write queues */
		set->map[HCTX_TYPE_READ].queue_offset =
				ctrl->ctrl.opts->nr_io_queues;
		set->map[HCTX_TYPE_READ].nr_queues =
				ctrl->ctrl.opts->nr_write_queues;
	} else {
		/* mixed read/write queues */
		set->map[HCTX_TYPE_READ].queue_offset = 0;
		set->map[HCTX_TYPE_READ].nr_queues =
				ctrl->ctrl.opts->nr_io_queues;
	}
	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
	return 0;
}
