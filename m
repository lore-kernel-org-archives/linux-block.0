Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7895CC43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 09:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455F120663
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 09:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455F120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbeKVTpb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:45:31 -0500
Received: from verein.lst.de ([213.95.11.211]:56991 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731655AbeKVTpb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 14:45:31 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AA91B68C22; Thu, 22 Nov 2018 10:06:55 +0100 (CET)
Date:   Thu, 22 Nov 2018 10:06:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 11/13] nvmet-tcp: add NVMe over TCP target driver
Message-ID: <20181122090655.GA27707@lst.de>
References: <20181122015615.15763-1-sagi@grimberg.me> <20181122015615.15763-12-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122015615.15763-12-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +enum nvmet_tcp_send_state {
> +	NVMET_TCP_SEND_DATA_PDU = 0,
> +	NVMET_TCP_SEND_DATA,
> +	NVMET_TCP_SEND_R2T,
> +	NVMET_TCP_SEND_DDGST,
> +	NVMET_TCP_SEND_RESPONSE
> +};
> +
> +enum nvmet_tcp_recv_state {
> +	NVMET_TCP_RECV_PDU,
> +	NVMET_TCP_RECV_DATA,
> +	NVMET_TCP_RECV_DDGST,
> +	NVMET_TCP_RECV_ERR,
> +};

I think you can drop the explicit initialization for
NVMET_TCP_SEND_DATA_PDU.

> +struct nvmet_tcp_recv_ctx {
> +};

There are no users of this empty struct, so it can probably be
dropped..

> +	void (*dr)(struct sock *);
> +	void (*sc)(struct sock *);
> +	void (*ws)(struct sock *);

These looks very cryptic.  Can you please at least spell out the
full names as used in the networking code (data_ready, etc).

> +struct nvmet_tcp_port {
> +	struct socket		*sock;
> +	struct work_struct	accept_work;
> +	struct nvmet_port	*nport;
> +	struct sockaddr_storage addr;
> +	int			last_cpu;
> +	void (*dr)(struct sock *);
> +};

Same here.

> +	pdu->hdr.plen =
> +		cpu_to_le32(pdu->hdr.hlen + hdgst + cmd->req.transfer_len + ddgst);

Overly long line.

> +static struct nvmet_tcp_cmd *nvmet_tcp_reverse_list(struct nvmet_tcp_queue *queue, struct llist_node *node)

Way too long line.

Also this function does not reverse a list, it removes from a llist,
adds to a regular list in reverse order and increments a counter.  Maybe
there is a better name?  It would also seem more readable if the
llist_del_all from the caller moved in here.

> +{
> +	struct nvmet_tcp_cmd *cmd;
> +
> +	while (node) {
> +		struct nvmet_tcp_cmd *cmd = container_of(node, struct nvmet_tcp_cmd, lentry);
> +

Also shouldn't this use llist_entry instead of container_of to document
the intent?

> +		list_add(&cmd->entry, &queue->resp_send_list);
> +		node = node->next;
> +		queue->send_list_len++;
> +	}
> +
> +	cmd = list_first_entry(&queue->resp_send_list, struct nvmet_tcp_cmd, entry);
> +	return cmd;

Besides the way too long line this can be a direct return.  Then
again moving the assignment of this in would probably make sense
as well.

> +}
> +
> +static struct nvmet_tcp_cmd *nvmet_tcp_fetch_send_command(struct nvmet_tcp_queue *queue)

Another way too long line.  Please just fix this up everwhere.

> +	if (!cmd || queue->state == NVMET_TCP_Q_DISCONNECTING) {
> +		cmd = nvmet_tcp_fetch_send_command(queue);
> +		if (unlikely(!cmd))
> +			return 0;
> +	}
> +
> +	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
> +		ret = nvmet_try_send_data_pdu(cmd);
> +		if (ret <= 0)
> +			goto done_send;
> +	}
> +
> +	if (cmd->state == NVMET_TCP_SEND_DATA) {
> +		ret = nvmet_try_send_data(cmd);
> +		if (ret <= 0)
> +			goto done_send;
> +	}
> +
> +	if (cmd->state == NVMET_TCP_SEND_DDGST) {
> +		ret = nvmet_try_send_ddgst(cmd);
> +		if (ret <= 0)
> +			goto done_send;
> +	}
> +
> +	if (cmd->state == NVMET_TCP_SEND_R2T) {
> +		ret = nvmet_try_send_r2t(cmd, last_in_batch);
> +		if (ret <= 0)
> +			goto done_send;
> +	}
> +
> +	if (cmd->state == NVMET_TCP_SEND_RESPONSE)
> +		ret = nvmet_try_send_response(cmd, last_in_batch);

Use a switch statement?

> +	if (queue->left) {
> +		return -EAGAIN;
> +	} else if (queue->offset == sizeof(struct nvme_tcp_hdr)) {

No need for an else after a return.

> +
> +	if (unlikely(queue->rcv_state == NVMET_TCP_RECV_ERR))
> +		return 0;
> +
> +	if (queue->rcv_state == NVMET_TCP_RECV_PDU) {
> +		result = nvmet_tcp_try_recv_pdu(queue);
> +		if (result != 0)
> +			goto done_recv;
> +	}
> +
> +	if (queue->rcv_state == NVMET_TCP_RECV_DATA) {
> +		result = nvmet_tcp_try_recv_data(queue);
> +		if (result != 0)
> +			goto done_recv;
> +	}
> +
> +	if (queue->rcv_state == NVMET_TCP_RECV_DDGST) {
> +		result = nvmet_tcp_try_recv_ddgst(queue);
> +		if (result != 0)
> +			goto done_recv;
> +	}

switch statement?

> +	spin_lock(&queue->state_lock);
> +	if (queue->state == NVMET_TCP_Q_DISCONNECTING)
> +		goto out;
> +
> +	queue->state = NVMET_TCP_Q_DISCONNECTING;
> +	schedule_work(&queue->release_work);
> +out:
> +	spin_unlock(&queue->state_lock);

No real need for the goto here.

> +static void nvmet_tcp_data_ready(struct sock *sk)
> +{
> +	struct nvmet_tcp_queue *queue;
> +
> +	read_lock_bh(&sk->sk_callback_lock);
> +	queue = sk->sk_user_data;
> +	if (!queue)
> +		goto out;
> +
> +	queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> +out:
> +	read_unlock_bh(&sk->sk_callback_lock);
> +}

This should only need rcu_read_proctection, right?

Also no need for the goto.
