Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58806 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbdEaPhd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2017 11:37:33 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v3 5/9] blk-mq: fix blk_mq_quiesce_queue
Date: Wed, 31 May 2017 15:37:30 +0000
Message-ID: <1496245049.2608.7.camel@sandisk.com>
References: <20170531123706.20885-1-ming.lei@redhat.com>
         <20170531123706.20885-6-ming.lei@redhat.com>
In-Reply-To: <20170531123706.20885-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-05-31 at 20:37 +0800, Ming Lei wrote:
>=20
> +	/* wait until queue is unquiesced */
> +	wait_event_cmd(q->quiesce_wq, !blk_queue_quiesced(q),
> +			may_sleep ?
> +			srcu_read_unlock(&hctx->queue_rq_srcu, *srcu_idx) :
> +			rcu_read_unlock(),
> +			may_sleep ?
> +			*srcu_idx =3D srcu_read_lock(&hctx->queue_rq_srcu) :
> +			rcu_read_lock());
> +
>  	if (q->elevator)
>  		goto insert;

What I see is that in this patch a new waitqueue has been introduced
(quiesce_wq) and also that an explanation of why you think this new waitque=
ue
is needed is missing completely. Why is it that you think that the
synchronize_scru() and synchronize_rcu() calls in blk_mq_quiesce_queue() ar=
e
not sufficient? If this new waitqueue is not needed, please remove that
waitqueue again.

Bart.=
