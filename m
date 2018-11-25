Return-Path: <SRS0=TDIO=OE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B2C43441
	for <linux-block@archiver.kernel.org>; Sun, 25 Nov 2018 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B405C20664
	for <linux-block@archiver.kernel.org>; Sun, 25 Nov 2018 09:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B405C20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeKYUBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:01:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43884 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbeKYUBk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Nov 2018 15:01:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so12438367plb.10;
        Sun, 25 Nov 2018 01:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1bX8EU/IG5pQE9BlvrqV+qQYWoEscAzT3+y43f+iJqc=;
        b=If+mdQmNfBru0nlJpTjg0XlQMgkd0HUIm2f6K04nFL72YPvlf9sqnikojYbjHNImxl
         LRsY/sW3408C1AvLH1KLDgSIH4GEylVeIsqcC4ysH4dAJi1CFtSHlZbEsL7YZFDFVbS4
         YFfxS9ldVWZyiWJOxdgzPrSkGWmwBnpegb4sUe58EOKOG3GNyoZ9isGsKRczmKIjt2mm
         6j145HClqMn/GUnqD7ZblPbxRVpJyrvt6jYjyDiGcKqKK+3W9xUlf5LSFPwV50OSWMtv
         nqZlQGC4jpP1K4tH1IJf/ic8gGLTG2yY+KD2T6RhJelPRhOmAkH7AIwXDw6j1hEXV+gM
         c/hQ==
X-Gm-Message-State: AA+aEWYk61yFoJHQpGGuqnX2L1FWAPQBpX294OuJrPrvKAfQhSs1JdGl
        /bi2gp3Q7cEiwZiqP354lKg=
X-Google-Smtp-Source: AFSGD/Vwa853oUchc7CA61sQ2nlk/H7cr6yDj7TfiXwVwzSKko5+84wZLf1o3nK/hkQNTdpoP6C6Jw==
X-Received: by 2002:a17:902:7581:: with SMTP id j1mr22948306pll.308.1543137062087;
        Sun, 25 Nov 2018 01:11:02 -0800 (PST)
Received: from [172.20.8.115] ([207.8.179.17])
        by smtp.gmail.com with ESMTPSA id v190sm11612315pfv.26.2018.11.25.01.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 01:11:01 -0800 (PST)
Subject: Re: [PATCH v3 13/13] nvme-tcp: add NVMe over TCP host driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-14-sagi@grimberg.me> <20181122080224.GA26504@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <af432c70-1b3a-6c62-bb13-67bf7df1a43f@grimberg.me>
Date:   Sun, 25 Nov 2018 01:10:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122080224.GA26504@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +static enum nvme_tcp_recv_state nvme_tcp_recv_state(struct nvme_tcp_queue *queue)
>> +{
>> +	return  (queue->pdu_remaining) ? NVME_TCP_RECV_PDU :
>> +		(queue->ddgst_remaining) ? NVME_TCP_RECV_DDGST :
>> +		NVME_TCP_RECV_DATA;
>> +}
> 
> This just seems to be used in a single switch statement.  Why the detour
> theough the state enum?

I think its clearer that the calling switch statement is switching on
an explicit state...

I can add the queue an explicit recv_state that would transition
these states like the target does, would that be better?

>> +		/*
>> +		 * FIXME: This assumes that data comes in-order,
>> +		 *  need to handle the out-of-order case.
>> +		 */
> 
> That sounds like something we should really address before merging.

That is an old comment from the first days where the
spec didn't explicitly state that data is transferred in
order for a single request. Will drop the comment.

>> +	read_lock(&sk->sk_callback_lock);
>> +	queue = sk->sk_user_data;
>> +	if (unlikely(!queue || !queue->rd_enabled))
>> +		goto done;
>> +
>> +	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>> +done:
>> +	read_unlock(&sk->sk_callback_lock);
> 
> Don't we need a rcu_dereference_sk_user_data here?

If I'm protected with the sk_callback_lock I don't need
it do I? I wander if I can remove the sk_callback_lock
and move to rcu only? That would require careful look
as when I change the callbacks I need to synchronize rcu
before clearing sk_user_data..

It seems that only tunneling ulps are using it so I'm not
sure that the actual user should use it...

> Also why not:
> 
> 	queue = rcu_dereference_sk_user_data(sk);
> 	if (likely(queue && queue->rd_enabled))
> 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> 	read_unlock(&sk->sk_callback_lock);

That I'll change...

>> +static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
>> +{
>> +	union nvme_result res = {};
>> +
>> +	nvme_end_request(blk_mq_rq_from_pdu(req),
>> +		NVME_SC_DATA_XFER_ERROR, res);
> 
> This looks like odd formatting, needs one more tab.  But
> NVME_SC_DATA_XFER_ERROR is also generally a status that should be
> returned from the nvme controller, not made up on the host.

Well.. the driver did fail to transfer data... What would be a
better completion status then?

>> +	if (req->state == NVME_TCP_SEND_CMD_PDU) {
>> +		ret = nvme_tcp_try_send_cmd_pdu(req);
>> +		if (ret <= 0)
>> +			goto done;
>> +		if (!nvme_tcp_has_inline_data(req))
>> +			return ret;
>> +	}
>> +
>> +	if (req->state == NVME_TCP_SEND_H2C_PDU) {
>> +		ret = nvme_tcp_try_send_data_pdu(req);
>> +		if (ret <= 0)
>> +			goto done;
>> +	}
>> +
>> +	if (req->state == NVME_TCP_SEND_DATA) {
>> +		ret = nvme_tcp_try_send_data(req);
>> +		if (ret <= 0)
>> +			goto done;
>> +	}
>> +
>> +	if (req->state == NVME_TCP_SEND_DDGST)
>> +		ret = nvme_tcp_try_send_ddgst(req);
> 
> Use a switch statement here?

The code flow is expected to fallthru as the command sequence continues
such that I don't need to "re-call" the routine...

For example, for in-capsule write, we will start in SEND_CMD_PDU,
continue to SEND_DATA and then to SEND_DDGST (if data digest exists)..

>> +static void nvme_tcp_free_tagset(struct nvme_ctrl *nctrl,
>> +		struct blk_mq_tag_set *set)
>> +{
>> +	blk_mq_free_tag_set(set);
>> +}
> 
> Please drop this wrapper.
> 
>> +static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
>> +		bool admin)
>> +{
> 
> This function does two entirely different things based on the admin
> paramter.

These two were left as such from my attempts to converge some
code over in the core.. I can remove them if you insist...

>> +int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
> 
> Shouldn't this (or anything in this file for that matter) be static?

Again, leftovers from my attempts to converge code...

>> +static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
>> +{
>> +	nvme_tcp_teardown_ctrl(ctrl, true);
>> +}
> 
> Pointless wrapper.

nvme_tcp_delete_ctrl() is a callback.

>> +static void nvme_tcp_set_sg_null(struct nvme_command *c)
>> +{
>> +	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
>> +
>> +	sg->addr = 0;
>> +	sg->length = 0;
>> +	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
>> +			NVME_SGL_FMT_TRANSPORT_A;
>> +}
>> +
>> +static void nvme_tcp_set_sg_host_data(struct nvme_tcp_request *req,
>> +		struct nvme_command *c)
>> +{
>> +	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
>> +
>> +	sg->addr = 0;
>> +	sg->length = cpu_to_le32(req->data_len);
>> +	sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
>> +			NVME_SGL_FMT_TRANSPORT_A;
>> +}
> 
> Do we really need nvme_tcp_set_sg_null?  Any command it is called
> on should have a request with a 0 length, so it could use
> nvme_tcp_set_sg_host_data.

We don't..

>> +static enum blk_eh_timer_return
>> +nvme_tcp_timeout(struct request *rq, bool reserved)
>> +{
>> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>> +	struct nvme_tcp_ctrl *ctrl = req->queue->ctrl;
>> +	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
>> +
>> +	dev_dbg(ctrl->ctrl.device,
>> +		"queue %d: timeout request %#x type %d\n",
>> +		nvme_tcp_queue_id(req->queue), rq->tag,
>> +		pdu->hdr.type);
>> +
>> +	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
>> +		union nvme_result res = {};
>> +
>> +		nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
>> +		nvme_end_request(rq, NVME_SC_ABORT_REQ, res);
>> +		return BLK_EH_DONE;
> 
> This looks odd.  It's not really the timeout handlers job to
> call nvme_end_request here.

Well.. if we are not yet LIVE, we will not trigger error
recovery, which means nothing will complete this command so
something needs to do it...

I think that we need it for rdma too..

...

The rest of the comments will be addressed in the next submission..
