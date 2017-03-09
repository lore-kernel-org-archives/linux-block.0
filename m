Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12413 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754648AbdCIQZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Mar 2017 11:25:40 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH rfc 04/10] block: Add a non-selective polling interface
Date: Thu, 9 Mar 2017 16:25:26 +0000
Message-ID: <1489076712.2597.1.camel@sandisk.com>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
         <1489065402-14757-5-git-send-email-sagi@grimberg.me>
In-Reply-To: <1489065402-14757-5-git-send-email-sagi@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-03-09 at 15:16 +0200, Sagi Grimberg wrote:
> +int blk_mq_poll_batch(struct request_queue *q, unsigned int batch)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	if (!q->mq_ops || !q->mq_ops->poll_batch)
> +		return 0;
> +
> +	hctx =3D blk_mq_map_queue(q, smp_processor_id());
> +	return q->mq_ops->poll_batch(hctx, batch);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_poll_batch);

A new exported function without any documentation? Wow. Please add a header
above this function that documents at least which other completion processi=
ng
code can execute concurrently with this function and from which contexts th=
e
other completion processing code can be called (e.g. blk_mq_poll() and
.complete()).

Why to return if (!q->mq_ops || !q->mq_ops->poll_batch)? Shouldn't that be =
a
WARN_ON_ONCE() instead? I think it is an error to calling blk_mq_poll_batch=
()
against a queue that does not define .poll_batch().

Additionally, I think making the hardware context an argument of this funct=
ion
instead of using blk_mq_map_queue(q, smp_processor_id()) would make this
function much more versatile.

Bart.=
