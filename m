Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D659C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 08:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4830761354
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 08:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhJTIxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJTIxk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 04:53:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A988EC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 01:51:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z20so23651995edc.13
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OIR2qEnMKT5vgCiNp8gWGwuUFBPyq+WA0j8o8hlDcDk=;
        b=YquOmuGEKPgfYFXwC/QSYJ3tw+5KVqjTle4xUmCGzvkPQgzL76g93DJwV1uKxnCeub
         sHbTQJO/x8kaaWraqffrddhiHsyryKdujh9YlhIrJV0qKIW2J31T5HIqxXiWQcHrUgW2
         mHPCCpQ5m1XxnOBFjujFGaRfDPauMUePA2GpB8U/H+5WWUnX3S7am65QfEd68WB3/vGW
         ybKWZk/uKxNxUSTnCTArxJIiCFeXC+TuPL0RFOPzaFvZPIsIGUoNmzl/QQ5Oh9GtqjqU
         TG8YS6/86QEF/BiJ5hrHJPFf5JiEMUB79fvxUlbOZIFLIMezGBYhTxxFYOZ799Ef3xTs
         lbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OIR2qEnMKT5vgCiNp8gWGwuUFBPyq+WA0j8o8hlDcDk=;
        b=wgTUB5fY7uT/bLinGcFK+qUsZTbPPD8ZQCkYTfGScZynQTyQDwRMumOY5w9WlTBa7q
         usB8KCF1CCIZ+H2Cu6M5dmvYHxnKR0NOKFmOkIOrf/0seRdVhpzSfy3lnWPzAkcd2W/M
         NM+ul3sWL56kFcpDv8ib81iIgm1pivfxRsnoVX0cfo8kUvGTPpcNYAEKB4SUpJDStZja
         ml0Z6Adj45lqSlksch3AhZr8bvpbCahnWVILnMDiQpfT6UNnlsE4huP2qVZk0f9JCsZY
         FRQueS2zDwbdjDVG1dAqqlBOiMXOfbKcfACkIdIsrnaxxrLNHWVWPfM1l2QmbSp2MIO9
         5oxg==
X-Gm-Message-State: AOAM531oAUFQ5XGKKlA2ujFbVBJ/rSkUDUJsepWDqLyGgx26RqQoqMpz
        zmeE4Fvw6O9WCbCJ+dCTCCfhrGoA29mkAg==
X-Google-Smtp-Source: ABdhPJzpLabFiSYVXcJj8+On0jnVheLVtIgVad+aucwgm+CtjplORgslxuHXYLU0LqFsa4EkIEcejg==
X-Received: by 2002:a17:906:1815:: with SMTP id v21mr45641101eje.218.1634719884173;
        Wed, 20 Oct 2021 01:51:24 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id jy25sm684643ejc.100.2021.10.20.01.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Oct 2021 01:51:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 1/2] block, bfq: counted root group into
 'num_groups_with_pending_reqs'
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211014014556.3597008-2-yukuai3@huawei.com>
Date:   Wed, 20 Oct 2021 10:51:21 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DD9CFF0-6110-497D-A352-9F37CADADC6B@linaro.org>
References: <20211014014556.3597008-1-yukuai3@huawei.com>
 <20211014014556.3597008-2-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 14 ott 2021, alle ore 03:45, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> 'num_groups_with_pending_reqs' represents how many groups that are
> not root group and have pending requests. This patch also counted
> root group into 'num_groups_with_pending_reqs'.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> block/bfq-iosched.c | 36 ++++++++++++++++++++++++++------
> block/bfq-wf2q.c    | 50 +++++++++++++++++++++++++++++++++------------
> 2 files changed, 67 insertions(+), 19 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index fec18118dc30..d251735383f7 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -852,6 +852,16 @@ void __bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> 	bfq_put_queue(bfqq);
> }
>=20
> +static inline void
> +bfq_clear_group_with_pending_reqs(struct bfq_data *bfqd,
> +				  struct bfq_entity *entity)
> +{
> +	if (entity->in_groups_with_pending_reqs) {
> +		entity->in_groups_with_pending_reqs =3D false;
> +		bfqd->num_groups_with_pending_reqs--;
> +	}
> +}
> +
> /*
>  * Invoke __bfq_weights_tree_remove on bfqq and decrement the number
>  * of active groups for each queue's inactive parent entity.
> @@ -860,9 +870,25 @@ void bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> 			     struct bfq_queue *bfqq)
> {
> 	struct bfq_entity *entity =3D bfqq->entity.parent;
> +	struct bfq_sched_data *sd;
> +
> +	/*
> +	 * If the bfq queue is in root group, the decrement of
> +	 * num_groups_with_pending_reqs is performed immediately upon =
the
> +	 * deactivation of entity.
> +	 */
> +	if (!entity) {
> +		entity =3D &bfqd->root_group->entity;
> +		sd =3D entity->my_sched_data;
> +
> +		if (!sd->in_service_entity)
> +			bfq_clear_group_with_pending_reqs(bfqd, entity);
> +
> +		return;
> +	}
>=20
> 	for_each_entity(entity) {
> -		struct bfq_sched_data *sd =3D entity->my_sched_data;
> +		sd =3D entity->my_sched_data;
>=20
> 		if (sd->next_in_service || sd->in_service_entity) {
> 			/*
> @@ -880,7 +906,8 @@ void bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> 		}
>=20
> 		/*
> -		 * The decrement of num_groups_with_pending_reqs is
> +		 * If the bfq queue is not in root group,
> +		 * the decrement of num_groups_with_pending_reqs is


I'm sorry if I didn't notice this before, but why do you postpone the
decrement only for queues not in root group?  If I'm not missing
anything, the active (i.e., with pending reqs) state of the root group
is to be computed as that of ay other group.

Thanks,
Paolo

> 		 * not performed immediately upon the deactivation of
> 		 * entity, but it is delayed to when it also happens
> 		 * that the first leaf descendant bfqq of entity gets
> @@ -889,10 +916,7 @@ void bfq_weights_tree_remove(struct bfq_data =
*bfqd,
> 		 * needed. See the comments on
> 		 * num_groups_with_pending_reqs for details.
> 		 */
> -		if (entity->in_groups_with_pending_reqs) {
> -			entity->in_groups_with_pending_reqs =3D false;
> -			bfqd->num_groups_with_pending_reqs--;
> -		}
> +		bfq_clear_group_with_pending_reqs(bfqd, entity);
> 	}
>=20
> 	/*
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index b74cc0da118e..3e9e672aa302 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -945,6 +945,42 @@ static void bfq_update_fin_time_enqueue(struct =
bfq_entity *entity,
>=20
> 	bfq_active_insert(st, entity);
> }
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +static inline void
> +bfq_set_group_with_pending_reqs(struct bfq_data *bfqd,
> +				struct bfq_entity *entity)
> +{
> +	if (!entity->in_groups_with_pending_reqs) {
> +		entity->in_groups_with_pending_reqs =3D true;
> +		bfqd->num_groups_with_pending_reqs++;
> +	}
> +}
> +
> +static void bfq_update_groups_with_pending_reqs(struct bfq_entity =
*entity)
> +{
> +	struct bfq_queue *bfqq =3D bfq_entity_to_bfqq(entity);
> +
> +	if (bfqq) {
> +		/*
> +		 * If the entity represents bfq_queue, and the queue =
belongs to
> +		 * root cgroup.
> +		 */
> +		if (!entity->parent)
> +			bfq_set_group_with_pending_reqs(bfqq->bfqd,
> +				&bfqq->bfqd->root_group->entity);
> +	} else {
> +		/* If the entity represents bfq_group. */
> +		struct bfq_group *bfqg =3D
> +			container_of(entity, struct bfq_group, entity);
> +		struct bfq_data *bfqd =3D bfqg->bfqd;
> +
> +		bfq_set_group_with_pending_reqs(bfqd, entity);
> +	}
> +}
> +#else
> +#define bfq_update_groups_with_pending_reqs(entity) \
> +	do {} while (0)
> +#endif
>=20
> /**
>  * __bfq_activate_entity - handle activation of entity.
> @@ -999,19 +1035,7 @@ static void __bfq_activate_entity(struct =
bfq_entity *entity,
> 		entity->on_st_or_in_serv =3D true;
> 	}
>=20
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
> -		struct bfq_group *bfqg =3D
> -			container_of(entity, struct bfq_group, entity);
> -		struct bfq_data *bfqd =3D bfqg->bfqd;
> -
> -		if (!entity->in_groups_with_pending_reqs) {
> -			entity->in_groups_with_pending_reqs =3D true;
> -			bfqd->num_groups_with_pending_reqs++;
> -		}
> -	}
> -#endif
> -
> +	bfq_update_groups_with_pending_reqs(entity);
> 	bfq_update_fin_time_enqueue(entity, st, backshifted);
> }
>=20
> --=20
> 2.31.1
>=20

