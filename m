Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16816 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEV3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2017 17:29:23 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 03/11] blk-mq: introduce blk_mq_quiesce_queue_nowait()
Date: Mon, 5 Jun 2017 21:29:20 +0000
Message-ID: <1496698158.2623.24.camel@sandisk.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
         <20170605155925.7896-4-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-06-05 at 23:59 +0800, Ming Lei wrote:
> This patch introduces blk_mq_quiesce_queue_nowait() so
> that we can workaround mpt3sas for quiescing its queue.
>=20
> Once mpt3sas is fixed, we can remove this helper.
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/blk-mq.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 1e480015d172..13d1196f492f 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -266,6 +266,14 @@ int blk_mq_map_queues(struct blk_mq_tag_set *set);
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_qu=
eues);
> =20
>  /*
> + * FIXME: this helper is just for working around mpt3sas.
> + */
> +static inline void blk_mq_quiesce_queue_nowait(struct request_queue *q)
> +{
> +	blk_mq_stop_hw_queues(q);
> +}
> +
> +/*
>   * Driver command data is immediately after the request. So subtract req=
uest
>   * size to get back to the original request, add request size to get the=
 PDU.
>   */

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
