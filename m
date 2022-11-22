Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D6FC4332F
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 08:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiKVIAY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 03:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKVIAV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 03:00:21 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4590B1EAFB
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 00:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669104020; x=1700640020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6vCpRY1jJzGjM5SfNJJuYvYU9rpJEwQG93X6AIbHITo=;
  b=O7jYqGShGUwpuOH0NXbKfOGp5G8doEQLW+mra6ELbglW7WvmtukMAe55
   R+Xxsao/mO9enyg1Zeb71ED+yTDH7OoPp6N5fyhUnc/rQ/T8KDlGtifQi
   Yxt6UQakrBo3OPvbNLe3x7hqDlOcZSFpaGXh+fXcaaqPerTMpD72GE/Jf
   99iUGzF/c+ek7Gj8ZsYMjT1SFN7n3Jr52fRjMvWj4JgT9C72sJTxfJuSs
   v6cG5G/reSn60H4Z+AHG8iiR7X3BL3SvlpNRVABlejgUPYKttTadpB7Vo
   GZqbf/WB3h+QlCGVZyyLuntbpFVtxiKxE6n/enL2ERb8hp1QlIiXQAN3q
   A==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="222028964"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 16:00:19 +0800
IronPort-SDR: 6JJQgiMoQtFX+BSsTaR1CzKS0dxgkLZrG1gr1ypI+xwGOKec8pH+sWrjbSvxfQz/eqythe9tHe
 1lX3/esI4zLgYNdSvegf/FimEKnp+QYG0obdLe3KvfrPKSi9f9ZxE9tZ+YwmFdPxwxrFLb9QTd
 edSG84T4c0n3Jc2B/Fba0GbPCURTNGifTk3DJTwA7lUIAONaDLvqQBPYO0Bg7ZmXbX+xv1DUd9
 dIOJalLCuyoEOJVm1bARjwzF7nXl0m9+hd5BIM8PVXVLYuTidzt7dOqYi/zaByy88Z3KVjmLyZ
 ZFg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 23:19:08 -0800
IronPort-SDR: dXmm5NadkObo+oaIUAowIc28Gwfndi2J8CP5fya02bBH9TFS6PIiceXSI/ZrhOBrABh8h/c+33
 34RAWIJHyrD/qnU/UzqFQ/XWbBvPeaBdZv97Qzcbg2GDbAsgXcQxOQkQkhlQD1efA0Zdr0Y8Mx
 BksMJ5nib9kD/ntYV1uRJiqwT3Z7I4xy7Ss+a8gCwrM8NGS9H2lHrQAis9qFs2063er4Wtm/Aj
 9lFgeVdSGGXlsln+5al9AJfy00zD/0uO19NJJyqUNR+NUEc2veWCtXZtvxrUYFhq4cAb3HBsZu
 cs0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2022 00:00:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NGcBC2kvwz1Rwrq
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 00:00:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669104018; x=1671696019; bh=6vCpRY1jJzGjM5SfNJJuYvYU9rpJEwQG93X
        6AIbHITo=; b=BaCzQUxzpcbcbIYQi3p/YxltKSCuIz9zLUSxhJKoFJFIIdvPtuq
        RDQ5HpIF85sSCjIeBajaqCSelyhHtgQ5atsxcGQyHwtMdhkZlLCAXbThryzbbkng
        plIIaP/4yr6Mtm2712t2uun7uikl3Ntv3grIbJGkb7M2Akd7gR525G3Qa5jSTnM+
        tA53OgUVzqoFeBqMjKJwpUeShRKZmmgP3JsWHeW4LEZ7OUW5nLt9PJ9rHYsmWuEd
        quzyvIOFF2YEdSmpb+cqHrvYyKziM06hXWekuAJ2TX4RlB/VRpFGINbRoGSJ2elU
        EqocjdyurihdJDo0VS/axwh80rE4D7xzgCg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KXmrAtuPsEEp for <linux-block@vger.kernel.org>;
        Tue, 22 Nov 2022 00:00:18 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NGcB95P1Qz1RvLy;
        Tue, 22 Nov 2022 00:00:17 -0800 (PST)
Message-ID: <7a58e5d8-a0b8-63d9-c9a9-8395fb999437@opensource.wdc.com>
Date:   Tue, 22 Nov 2022 17:00:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ublk_drv: don't forward io commands in reserve order
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Andreas Hindborg <andreas.hindborg@wdc.com>
References: <20221121155645.396272-1-ming.lei@redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221121155645.396272-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/22/22 00:56, Ming Lei wrote:
> Either ublk_can_use_task_work() is true or not, io commands are
> forwarded to ublk server in reverse order, since llist_add() is
> always to add one element to the head of the list.
> 
> Even though block layer doesn't guarantee request dispatch order,
> requests should be sent to hardware in the sequence order generated
> from io scheduler, which usually considers the request's LBA, and
> order is often important for HDD.
> 
> So forward io commands in the sequence made from io scheduler by
> aligning task work with current io_uring command's batch handling,
> and it has been observed that both can get similar performance data
> if IORING_SETUP_COOP_TASKRUN is set from ublk server.
> 
> Reported-by: Andreas Hindborg <andreas.hindborg@wdc.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks ok to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/ublk_drv.c | 82 +++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f96cb01e9604..e9de9d846b73 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -57,10 +57,8 @@
>  #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
>  
>  struct ublk_rq_data {
> -	union {
> -		struct callback_head work;
> -		struct llist_node node;
> -	};
> +	struct llist_node node;
> +	struct callback_head work;
>  };
>  
>  struct ublk_uring_cmd_pdu {
> @@ -766,15 +764,31 @@ static inline void __ublk_rq_task_work(struct request *req)
>  	ubq_complete_io_cmd(io, UBLK_IO_RES_OK);
>  }
>  
> +static inline void ublk_forward_io_cmds(struct ublk_queue *ubq)
> +{
> +	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
> +	struct ublk_rq_data *data, *tmp;
> +
> +	io_cmds = llist_reverse_order(io_cmds);
> +	llist_for_each_entry_safe(data, tmp, io_cmds, node)
> +		__ublk_rq_task_work(blk_mq_rq_from_pdu(data));
> +}
> +
> +static inline void ublk_abort_io_cmds(struct ublk_queue *ubq)
> +{
> +	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
> +	struct ublk_rq_data *data, *tmp;
> +
> +	llist_for_each_entry_safe(data, tmp, io_cmds, node)
> +		__ublk_abort_rq(ubq, blk_mq_rq_from_pdu(data));
> +}
> +
>  static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
>  {
>  	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
>  	struct ublk_queue *ubq = pdu->ubq;
> -	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
> -	struct ublk_rq_data *data;
>  
> -	llist_for_each_entry(data, io_cmds, node)
> -		__ublk_rq_task_work(blk_mq_rq_from_pdu(data));
> +	ublk_forward_io_cmds(ubq);
>  }
>  
>  static void ublk_rq_task_work_fn(struct callback_head *work)
> @@ -782,14 +796,20 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
>  	struct ublk_rq_data *data = container_of(work,
>  			struct ublk_rq_data, work);
>  	struct request *req = blk_mq_rq_from_pdu(data);
> +	struct ublk_queue *ubq = req->mq_hctx->driver_data;
>  
> -	__ublk_rq_task_work(req);
> +	ublk_forward_io_cmds(ubq);
>  }
>  
> -static void ublk_submit_cmd(struct ublk_queue *ubq, const struct request *rq)
> +static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
>  {
> -	struct ublk_io *io = &ubq->ios[rq->tag];
> +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
> +	struct ublk_io *io;
>  
> +	if (!llist_add(&data->node, &ubq->io_cmds))
> +		return;
> +
> +	io = &ubq->ios[rq->tag];
>  	/*
>  	 * If the check pass, we know that this is a re-issued request aborted
>  	 * previously in monitor_work because the ubq_daemon(cmd's task) is
> @@ -803,11 +823,11 @@ static void ublk_submit_cmd(struct ublk_queue *ubq, const struct request *rq)
>  	 * guarantees that here is a re-issued request aborted previously.
>  	 */
>  	if (unlikely(io->flags & UBLK_IO_FLAG_ABORTED)) {
> -		struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
> -		struct ublk_rq_data *data;
> -
> -		llist_for_each_entry(data, io_cmds, node)
> -			__ublk_abort_rq(ubq, blk_mq_rq_from_pdu(data));
> +		ublk_abort_io_cmds(ubq);
> +	} else if (ublk_can_use_task_work(ubq)) {
> +		if (task_work_add(ubq->ubq_daemon, &data->work,
> +					TWA_SIGNAL_NO_IPI))
> +			ublk_abort_io_cmds(ubq);
>  	} else {
>  		struct io_uring_cmd *cmd = io->cmd;
>  		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> @@ -817,23 +837,6 @@ static void ublk_submit_cmd(struct ublk_queue *ubq, const struct request *rq)
>  	}
>  }
>  
> -static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq,
> -		bool last)
> -{
> -	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
> -
> -	if (ublk_can_use_task_work(ubq)) {
> -		enum task_work_notify_mode notify_mode = last ?
> -			TWA_SIGNAL_NO_IPI : TWA_NONE;
> -
> -		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
> -			__ublk_abort_rq(ubq, rq);
> -	} else {
> -		if (llist_add(&data->node, &ubq->io_cmds))
> -			ublk_submit_cmd(ubq, rq);
> -	}
> -}
> -
>  static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		const struct blk_mq_queue_data *bd)
>  {
> @@ -865,19 +868,11 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		return BLK_STS_OK;
>  	}
>  
> -	ublk_queue_cmd(ubq, rq, bd->last);
> +	ublk_queue_cmd(ubq, rq);
>  
>  	return BLK_STS_OK;
>  }
>  
> -static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
> -{
> -	struct ublk_queue *ubq = hctx->driver_data;
> -
> -	if (ublk_can_use_task_work(ubq))
> -		__set_notify_signal(ubq->ubq_daemon);
> -}
> -
>  static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
>  		unsigned int hctx_idx)
>  {
> @@ -899,7 +894,6 @@ static int ublk_init_rq(struct blk_mq_tag_set *set, struct request *req,
>  
>  static const struct blk_mq_ops ublk_mq_ops = {
>  	.queue_rq       = ublk_queue_rq,
> -	.commit_rqs     = ublk_commit_rqs,
>  	.init_hctx	= ublk_init_hctx,
>  	.init_request   = ublk_init_rq,
>  };
> @@ -1197,7 +1191,7 @@ static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
>  	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
>  	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
>  
> -	ublk_queue_cmd(ubq, req, true);
> +	ublk_queue_cmd(ubq, req);
>  }
>  
>  static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)

-- 
Damien Le Moal
Western Digital Research

