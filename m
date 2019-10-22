Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD7CA9EA0
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9C32084B
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 09:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ys6CZzN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbfJVJmO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:42:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25887 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730312AbfJVJmN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 05:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571737332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hqLx2jlVtfP7Gnl2iGq6+syX/mfouTyyo6+gmxO6H8A=;
        b=Ys6CZzN5pyRvX//t3Zg+ZKEHx7ycYwyB47Br4tLzWRviv7WSWfYcJNeg22u47iamBcrhIr
        BDeo+76cortu1Ge/7LsmUAc6JEp9+PrhJc++Sb5nmd+5V8Lngp4Uec5bT0TXAhIDIriKqo
        Bsw4ksX+Z0rxw5xZNLJeUahD+vxm1QA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-DBL4ewsYNSeEn6RJNxSLMg-1; Tue, 22 Oct 2019 05:42:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4D0D1800D79;
        Tue, 22 Oct 2019 09:42:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-36.pek2.redhat.com [10.72.8.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4703E60126;
        Tue, 22 Oct 2019 09:42:00 +0000 (UTC)
Date:   Tue, 22 Oct 2019 17:41:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 2/4] block: Fix a race between blk_poll() and
 blk_mq_update_nr_hw_queues()
Message-ID: <20191022094154.GB9037@ming.t460p>
References: <20191021224259.209542-1-bvanassche@acm.org>
 <20191021224259.209542-3-bvanassche@acm.org>
MIME-Version: 1.0
In-Reply-To: <20191021224259.209542-3-bvanassche@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: DBL4ewsYNSeEn6RJNxSLMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 21, 2019 at 03:42:57PM -0700, Bart Van Assche wrote:
> If blk_poll() is called if no requests are in progress, it may happen tha=
t
> blk_mq_update_nr_hw_queues() modifies the data structures used by blk_pol=
l(),
> e.g. q->queue_hw_ctx[]. Fix this race by serializing blk_poll() against
> blk_mq_update_nr_hw_queues().
>=20
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7528678ef41f..ea64d951f411 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3439,19 +3439,7 @@ static bool blk_mq_poll_hybrid(struct request_queu=
e *q,
>  =09return blk_mq_poll_hybrid_sleep(q, hctx, rq);
>  }
> =20
> -/**
> - * blk_poll - poll for IO completions
> - * @q:  the queue
> - * @cookie: cookie passed back at IO submission time
> - * @spin: whether to spin for completions
> - *
> - * Description:
> - *    Poll for completions on the passed in queue. Returns number of
> - *    completed entries found. If @spin is true, then blk_poll will cont=
inue
> - *    looping until at least one completion is found, unless the task is
> - *    otherwise marked running (or we need to reschedule).
> - */
> -int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> +static int __blk_poll(struct request_queue *q, blk_qc_t cookie, bool spi=
n)
>  {
>  =09struct blk_mq_hw_ctx *hctx;
>  =09long state;
> @@ -3503,6 +3491,30 @@ int blk_poll(struct request_queue *q, blk_qc_t coo=
kie, bool spin)
>  =09__set_current_state(TASK_RUNNING);
>  =09return 0;
>  }
> +
> +/**
> + * blk_poll - poll for IO completions
> + * @q:  the queue
> + * @cookie: cookie passed back at IO submission time
> + * @spin: whether to spin for completions
> + *
> + * Description:
> + *    Poll for completions on the passed in queue. Returns number of
> + *    completed entries found. If @spin is true, then blk_poll will cont=
inue
> + *    looping until at least one completion is found, unless the task is
> + *    otherwise marked running (or we need to reschedule).
> + */
> +int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> +{
> +=09int ret;
> +
> +=09if (!percpu_ref_tryget(&q->q_usage_counter))
> +=09=09return 0;
> +=09ret =3D __blk_poll(q, cookie, spin);
> +=09blk_queue_exit(q);
> +
> +=09return ret;
> +}

IMO, this change isn't required. Caller of blk_poll is supposed to
hold refcount of the request queue, then the related hctx data structure
won't go away. When the hctx is in transient state, there can't be IO
to be polled, and it is safe to call into IO path.

BTW, .poll is absolutely the fast path, we should be careful to add code
in this path.

Thanks,
Ming

