Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34497 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167964AbcKAISR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 04:18:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id p190so15386809wmp.1
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2016 01:18:16 -0700 (PDT)
Subject: Re: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
To: Scott Bauer <scott.bauer@intel.com>, linux-nvme@lists.infradead.org
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
Cc: Rafael.Antognolli@intel.com, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
Date: Tue, 1 Nov 2016 10:18:13 +0200
MIME-Version: 1.0
In-Reply-To: <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> +struct sed_cb_data {
> +	sec_cb	*cb;
> +	void	*cb_data;
> +	struct nvme_command cmd;
> +};
> +
> +static void sec_submit_endio(struct request *req, int error)
> +{
> +	struct sed_cb_data *sed_data = req->end_io_data;
> +
> +	if (sed_data->cb)
> +		sed_data->cb(error, sed_data->cb_data);
> +
> +	kfree(sed_data);
> +	blk_mq_free_request(req);
> +}
> +
> +static int nvme_insert_rq(struct request_queue *q, struct request *rq,
> +			  int at_head, rq_end_io_fn *done)
> +{
> +	WARN_ON(rq->cmd_type == REQ_TYPE_FS);
> +
> +	rq->end_io = done;
> +
> +	if (!q->mq_ops)
> +		return -EINVAL;
> +
> +	blk_mq_insert_request(rq, at_head, true, true);
> +
> +	return 0;
> +}

No need for this function... you control the call site...

> +
> +static int nvme_sec_submit(void *data, u8 opcode, u16 SPSP,
> +			   u8 SECP, void *buffer, size_t len,
> +			   sec_cb *cb, void *cb_data)
> +{
> +	struct request_queue *q;
> +	struct request *req;
> +	struct sed_cb_data *sed_data;
> +	struct nvme_ns *ns;
> +	struct nvme_command *cmd;
> +	int ret;
> +
> +	ns = data;//bdev->bd_disk->private_data;

??

you don't even have data anywhere in here...

> +
> +	sed_data = kzalloc(sizeof(*sed_data), GFP_NOWAIT);
> +	if (!sed_data)
> +		return -ENOMEM;
> +	sed_data->cb = cb;
> +	sed_data->cb_data = cb_data;
> +	cmd = &sed_data->cmd;
> +
> +	cmd->common.opcode = opcode;
> +	cmd->common.nsid = ns->ns_id;
> +	cmd->common.cdw10[0] = SECP << 24 | SPSP << 8;
> +	cmd->common.cdw10[1] = len;
> +
> +	q = ns->ctrl->admin_q;
> +
> +	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
> +	if (IS_ERR(req)) {
> +		ret = PTR_ERR(req);
> +		goto err_free;
> +	}
> +
> +	req->timeout = ADMIN_TIMEOUT;
> +	req->special = NULL;
> +
> +	if (buffer && len) {
> +		ret = blk_rq_map_kern(q, req, buffer, len, GFP_NOWAIT);
> +		if (ret) {
> +			blk_mq_free_request(req);
> +			goto err_free;
> +		}
> +	}
> +
> +	req->end_io_data = sed_data;
> +	//req->rq_disk = bdev->bd_disk;

??

> +
> +	return nvme_insert_rq(q, req, 1, sec_submit_endio);

No need to introduce nvme_insert_rq at all, just call
blk_mq_insert_request (other examples call blk_execute_rq_nowait
but its pretty much the same...)

> @@ -582,6 +583,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	struct nvme_command cmnd;
>  	unsigned map_len;
>  	int ret = BLK_MQ_RQ_QUEUE_OK;
> +	unsigned long flags;
>
>  	/*
>  	 * If formated with metadata, require the block layer provide a buffer
> @@ -614,18 +616,18 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	cmnd.common.command_id = req->tag;
>  	blk_mq_start_request(req);
>
> -	spin_lock_irq(&nvmeq->q_lock);
> +	spin_lock_irqsave(&nvmeq->q_lock, flags);
>  	if (unlikely(nvmeq->cq_vector < 0)) {
>  		if (ns && !test_bit(NVME_NS_DEAD, &ns->flags))
>  			ret = BLK_MQ_RQ_QUEUE_BUSY;
>  		else
>  			ret = BLK_MQ_RQ_QUEUE_ERROR;
> -		spin_unlock_irq(&nvmeq->q_lock);
> +		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
>  		goto out;
>  	}
>  	__nvme_submit_cmd(nvmeq, &cmnd);
>  	nvme_process_cq(nvmeq);
> -	spin_unlock_irq(&nvmeq->q_lock);
> +	spin_unlock_irqrestore(&nvmeq->q_lock, flags);

No documentation why this is needed...

>  	return BLK_MQ_RQ_QUEUE_OK;
>  out:
>  	nvme_free_iod(dev, req);
> @@ -635,11 +637,11 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  static void nvme_complete_rq(struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -	struct nvme_dev *dev = iod->nvmeq->dev;
> +	struct nvme_queue *nvmeq = iod->nvmeq;
> +	struct nvme_dev *dev = nvmeq->dev;

This is a cleanup that should go in a different patch...

>  	int error = 0;
>
>  	nvme_unmap_data(dev, req);
> -

Same here...

>  	if (unlikely(req->errors)) {
>  		if (nvme_req_needs_retry(req, req->errors)) {
>  			req->retries++;
> @@ -658,7 +660,6 @@ static void nvme_complete_rq(struct request *req)
>  			"completing aborted command with status: %04x\n",
>  			req->errors);
>  	}
> -

Here...

>  	blk_mq_end_request(req, error);
>  }
>
> @@ -1758,10 +1759,11 @@ static void nvme_reset_work(struct work_struct *work)
>  {
>  	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
>  	int result = -ENODEV;
> -
> +	bool was_suspend = false;
>  	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
>  		goto out;
>
> +	was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
>  	/*
>  	 * If we're called to reset a live controller first shut it down before
>  	 * moving on.
> @@ -1789,6 +1791,9 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (result)
>  		goto out;
>
> +	if (was_suspend)
> +		nvme_unlock_from_suspend(&dev->ctrl);
> +
>  	result = nvme_setup_io_queues(dev);
>  	if (result)
>  		goto out;
>
