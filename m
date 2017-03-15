Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5805 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdCOAIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2017 20:08:00 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "yizhan@redhat.com" <yizhan@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: don't complete un-started request in
 timeout handler
Date: Wed, 15 Mar 2017 00:07:37 +0000
Message-ID: <1489536441.2676.21.camel@sandisk.com>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
         <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-03-09 at 21:02 +0800, Ming Lei wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 159187a28d66..0aff380099d5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -697,17 +697,8 @@ static void blk_mq_check_expired(struct blk_mq_hw_ct=
x *hctx,
>  {
>  	struct blk_mq_timeout_data *data =3D priv;
> =20
> -	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
> -		/*
> -		 * If a request wasn't started before the queue was
> -		 * marked dying, kill it here or it'll go unnoticed.
> -		 */
> -		if (unlikely(blk_queue_dying(rq->q))) {
> -			rq->errors =3D -EIO;
> -			blk_mq_end_request(rq, rq->errors);
> -		}
> +	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
>  		return;
> -	}
> =20
>  	if (time_after_eq(jiffies, rq->deadline)) {
>  		if (!blk_mark_rq_complete(rq))

Both the old and the new check look racy to me. The REQ_ATOM_STARTED bit ca=
n
be changed concurrently by blk_mq_start_request(), __blk_mq_finish_request(=
)
or __blk_mq_requeue_request(). Another issue with this function is that the
request passed to this function can be reinitialized concurrently. Sorry bu=
t
I'm not sure what the best way is to address these issues.

Bart.=
