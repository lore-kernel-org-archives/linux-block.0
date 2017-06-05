Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1984 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEVgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2017 17:36:45 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 09/11] blk-mq: don't stop queue for quiescing
Date: Mon, 5 Jun 2017 21:36:42 +0000
Message-ID: <1496698601.2623.31.camel@sandisk.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
         <20170605155925.7896-10-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-10-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-06-05 at 23:59 +0800, Ming Lei wrote:
> @@ -169,11 +169,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
>  	unsigned int i;
>  	bool rcu =3D false;
> =20
> -	__blk_mq_stop_hw_queues(q, true);
> -
> -	spin_lock_irq(q->queue_lock);
> -	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> -	spin_unlock_irq(q->queue_lock);
> +	blk_mq_quiesce_queue_nowait(q);
> =20

Although I would have preferred to keep blk_mq_quiesce_nowait() open-coded =
in
this function,

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
