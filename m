Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF85C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41472070D
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwpOHuZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfDJIeK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:34:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50689 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbfDJIeK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 04:34:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so1643876wmi.0
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ocQ8ZmjwxYDlNiqsufM16tseomaIpCCwBDwnnqQxhJw=;
        b=RwpOHuZFirorVM4uP+BSae7Er2ScAt/E5GRjfsCnw8bemuUh/1YLBcnKKuAoMmH+86
         OzI97YOw9dEQD5Mg1Pbzog72/XY6uKau7L5RBM6Iuu68GY3ofcgV4Q/PghPdIvNGlJB4
         NH8N8QxeREg7afBykRhLBIOaHQ0+Sf3k/j73tgR0ju64iYtbgc77bb2F23iO2U5WWpdW
         PN3JvB3Jm09xXsxrArkRhB8unRwUL+Lf10dQEdR1vpop0gcIyCOmrTeQ4Z9fpikvql80
         e7uAJpjiPt9uMP86/cgAbALdGir0H5sNxQ9W+KTG2W4qTsvBed3hFdoZK43alY+nv33T
         VuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ocQ8ZmjwxYDlNiqsufM16tseomaIpCCwBDwnnqQxhJw=;
        b=HitWQFIF3JixDMWjtsKedqjZkXJG/Gx2uAfE7RkGfkDYtAM+WzchRzbI8R0nMceKZv
         vxJN3mFY19XpeCJqP71nGjlMJ6rsnldrNE7nZ59zWWmpnQ04fGZXZP8dlxi+7BShywgF
         Gd3xVDWyKiZSXGFQ3kF68fqymuyvPRz00NFXFcMp35CwI85J0X4p/5cGgXft0Y8yAnD/
         nMPXJ4O0EaRNI4vlJ9o1z+OuWjRjIMOTz66QGZCz+Zh0i0dh3Rt+rl9VsaAf7koMQ+R0
         PTtIODqo1E41WjR7HRwVNxk3VLjaDws21VubYkGc7oIV2IrGlBPUaXzfy4n5MP63KNZK
         w1eQ==
X-Gm-Message-State: APjAAAUroWJaNCBvH4rdWGt531mg653ROHtK0UQezAYRmSOb0B4tXEeK
        r6PNn9PTsXFFGCrH6pPC7hhYLg==
X-Google-Smtp-Source: APXvYqwpGhjdje337l0cWub3TlLIzkmNyMwWktyOph9EnsKhV3tAuPcxHnmg797JIOvQ612HB0/qRA==
X-Received: by 2002:a1c:55c3:: with SMTP id j186mr1920593wmb.127.1554885247726;
        Wed, 10 Apr 2019 01:34:07 -0700 (PDT)
Received: from wifi-122_dhcprange-158.wifi.unimo.it ([155.185.122.158])
        by smtp.gmail.com with ESMTPSA id m17sm26002793wrx.3.2019.04.10.01.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:34:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] block, bfq: fix use after free in bfq_bfqq_expire
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190410082646.14221-1-paolo.valente@linaro.org>
Date:   Wed, 10 Apr 2019 10:34:03 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Dmitrii Tcvetkov <demfloro@demfloro.ru>,
        Douglas Anderson <dianders@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED596CEA-6C73-403C-9DC8-44933EE1D567@linaro.org>
References: <20190410082646.14221-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch causes some checkpatch complain, sorry. Sending a V2 right =
away.

Paolo

> Il giorno 10 apr 2019, alle ore 10:26, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> The function bfq_bfqq_expire() invokes the function
> __bfq_bfqq_expire(), and the latter may free the in-service bfq-queue.
> If this happens, then no other instruction of bfq_bfqq_expire() must
> be executed, or a use-after-free will occur.
>=20
> Basing on the assumption that __bfq_bfqq_expire() invokes
> bfq_put_queue() on the in-service bfq-queue exactly once, the queue is
> assumed to be freed if its refcounter is equal to one right before
> invoking __bfq_bfqq_expire().
>=20
> But, since commit 9dee8b3b057e1 ("block, bfq: fix queue removal from
> weights tree") this assumption is false. __bfq_bfqq_expire() may also
> invoke bfq_weights_tree_remove() and, since commit 9dee8b3b057e1, also
> the latter function may invoke bfq_put_queue(). So __bfq_bfqq_expire()
> may invoke bfq_put_queue() twice, and this is the actual case where
> the in-service queue may happen to be freed.
>=20
> To address this issue, this commit moves the check on the refcounter
> of the queue right around the last bfq_put_queue() that may be invoked
> on the queue.
>=20
> Reported-by: Dmitrii Tcvetkov <demfloro@demfloro.ru>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Dmitrii Tcvetkov <demfloro@demfloro.ru>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
> block/bfq-iosched.c | 15 +++++++--------
> block/bfq-iosched.h |  2 +-
> block/bfq-wf2q.c    | 17 +++++++++++++++--
> 3 files changed, 23 insertions(+), 11 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index fac188dd78fa..30b88ec7ad26 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2822,7 +2822,7 @@ static void bfq_dispatch_remove(struct =
request_queue *q, struct request *rq)
> 	bfq_remove_request(q, rq);
> }
>=20
> -static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue =
*bfqq)
> +static bool __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue =
*bfqq)
> {
> 	/*
> 	 * If this bfqq is shared between multiple processes, check
> @@ -2855,9 +2855,11 @@ static void __bfq_bfqq_expire(struct bfq_data =
*bfqd, struct bfq_queue *bfqq)
> 	/*
> 	 * All in-service entities must have been properly deactivated
> 	 * or requeued before executing the next function, which
> -	 * resets all in-service entites as no more in service.
> +	 * resets all in-service entites as no more in service. This
> +	 * may cause bfqq to be freed. If this happens, the next
> +	 * function returns true.
> 	 */
> -	__bfq_bfqd_reset_in_service(bfqd);
> +	return __bfq_bfqd_reset_in_service(bfqd);
> }
>=20
> /**
> @@ -3262,7 +3264,6 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
> 	bool slow;
> 	unsigned long delta =3D 0;
> 	struct bfq_entity *entity =3D &bfqq->entity;
> -	int ref;
>=20
> 	/*
> 	 * Check whether the process is slow (see bfq_bfqq_is_slow).
> @@ -3347,10 +3348,8 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
> 	 * reason.
> 	 */
> 	__bfq_bfqq_recalc_budget(bfqd, bfqq, reason);
> -	ref =3D bfqq->ref;
> -	__bfq_bfqq_expire(bfqd, bfqq);
> -
> -	if (ref =3D=3D 1) /* bfqq is gone, no more actions on it */
> +	if (__bfq_bfqq_expire(bfqd, bfqq))
> +		/* bfqq is gone, no more actions on it */
> 		return;
>=20
> 	bfqq->injected_service =3D 0;
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 062e1c4787f4..86394e503ca9 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -995,7 +995,7 @@ bool __bfq_deactivate_entity(struct bfq_entity =
*entity,
> 			     bool ins_into_idle_tree);
> bool next_queue_may_preempt(struct bfq_data *bfqd);
> struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd);
> -void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
> +bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
> void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue =
*bfqq,
> 			 bool ins_into_idle_tree, bool expiration);
> void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index a11bef75483d..ae4d000ac0af 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -1605,7 +1605,8 @@ struct bfq_queue *bfq_get_next_queue(struct =
bfq_data *bfqd)
> 	return bfqq;
> }
>=20
> -void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
> +/* returns true if the in-service queue gets freed */
> +bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
> {
> 	struct bfq_queue *in_serv_bfqq =3D bfqd->in_service_queue;
> 	struct bfq_entity *in_serv_entity =3D &in_serv_bfqq->entity;
> @@ -1629,8 +1630,20 @@ void __bfq_bfqd_reset_in_service(struct =
bfq_data *bfqd)
> 	 * service tree either, then release the service reference to
> 	 * the queue it represents (taken with bfq_get_entity).
> 	 */
> -	if (!in_serv_entity->on_st)
> +	if (!in_serv_entity->on_st) {
> +		/*
> +		 * If no process is referencing in_serv_bfqq any
> +		 * longer, then the service reference may be the only
> +		 * reference to the queue. If this is the case, then
> +		 * bfqq gets freed here.
> +		 */
> +		int ref =3D in_serv_bfqq->ref;
> 		bfq_put_queue(in_serv_bfqq);
> +		if (ref =3D=3D 1)
> +			return true;
> +	}
> +
> +	return false;
> }
>=20
> void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue =
*bfqq,
> --=20
> 2.20.1
>=20

