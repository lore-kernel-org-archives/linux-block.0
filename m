Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B17C433EF
	for <linux-block@archiver.kernel.org>; Sat, 28 May 2022 08:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353738AbiE1ISQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 May 2022 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbiE1ISP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 04:18:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B7DDECE
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 01:18:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g20so7851708edj.10
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 01:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zKQyiSCqOmFTXYg1oyMhrbRM1Y8cO4uyy6QdrPFWc8E=;
        b=Frk0CGa66mdgvvN98mA9x6NKT/Z+nOGLGMG5bYj54sZE8Lhp9JhuJvuNY8yJL6EsZI
         J3KIhCqyxlqhcg12/bSe/job0NO779KynECC8rcca8uR6CiSMYGeq+csLaG62ntXqacJ
         dES90AYO7hHJd/EBXB70EazwxzZAxQ/XqUC68IfGd/viKP5tX3k5dd7+J3dFugplJ0ZL
         HCtaNmUK65p5QGjx9s99ZizndE/FKgUz8a6LdwkrXWbXo8MBz6hq33pm7UTq4M7V0Qgp
         HStjHM0DBPi2iLS3eYgBuKVtopPlt2JeDZsqhPmHs5vRh2cFRTyoyDGf+vcfRFuYNDFQ
         jvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zKQyiSCqOmFTXYg1oyMhrbRM1Y8cO4uyy6QdrPFWc8E=;
        b=mS/kTu74K4jFouS70/0YpBvyOQ5RAxkrKe2ZM+s4/exDkTZnO9kT5IQRk1K39oqrys
         fphiCdoryoIvZnT4Mboiaosw6NFdcW/vjw5VfcvdArHg+62rrFcvnXJOf4HY+XTju/tO
         u43vvoMArfEPCpFu5ZIBaNbTP1uPJqAFjaytmtjbEAlomk1399xFQHqJOp2Ol1eevqgF
         ZwI0gP697psVcu9GMRDcVNFs0HDn706Xyx9Zi7gTAlpKItAfir3dB0cV8wZM7glOpGCH
         qV03ub8RXl7+fGElPhyd7CPBuT4ROAdsVYFn43ID0q1LG68FmsMZkxG2276ITQt582HD
         W4wg==
X-Gm-Message-State: AOAM531CgZledrBnR3jnDBs1iO1glziJQeOgRkDnUACEO4EBNYhlG42S
        t6e7HgvWohlZ72ejSriyFjrJHw==
X-Google-Smtp-Source: ABdhPJzkCFu6x05fcv5zy5p9pRsXjO3tHc/29aE81RFzfZb8y9BAPOboblWZf2SnMwvN6zlvY9fC0w==
X-Received: by 2002:a05:6402:1d50:b0:42b:6da9:ed34 with SMTP id dz16-20020a0564021d5000b0042b6da9ed34mr29184832edb.333.1653725892829;
        Sat, 28 May 2022 01:18:12 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-144-98-177.cust.vodafonedsl.it. [93.144.98.177])
        by smtp.gmail.com with ESMTPSA id g20-20020a170906955400b006feec47dae9sm2126208ejy.157.2022.05.28.01.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 May 2022 01:18:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v6 1/3] block, bfq: record how many queues are busy
 in bfq_group
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220523131818.2798712-2-yukuai3@huawei.com>
Date:   Sat, 28 May 2022 10:18:11 +0200
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D29A46A-4B8A-4F05-BCE3-D9D0F0D2DD5A@linaro.org>
References: <20220523131818.2798712-1-yukuai3@huawei.com>
 <20220523131818.2798712-2-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 23 mag 2022, alle ore 15:18, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Prepare to refactor the counting of 'num_groups_with_pending_reqs'.
>=20
> Add a counter 'busy_queues' in bfq_group, and update it in
> bfq_add/del_bfqq_busy().
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-cgroup.c  |  1 +
> block/bfq-iosched.h |  2 ++
> block/bfq-wf2q.c    | 20 ++++++++++++++++++++
> 3 files changed, 23 insertions(+)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 09574af83566..4d516879d9fa 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data =
*pd)
> 				   */
> 	bfqg->bfqd =3D bfqd;
> 	bfqg->active_entities =3D 0;
> +	bfqg->busy_queues =3D 0;
> 	bfqg->online =3D true;
> 	bfqg->rq_pos_tree =3D RB_ROOT;
> }
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 978ef5d6fe6a..3847f4ab77ac 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -906,6 +906,7 @@ struct bfq_group_data {
>  *                   are groups with more than one active @bfq_entity
>  *                   (see the comments to the function
>  *                   bfq_bfqq_may_idle()).
> + * @busy_queues: number of busy bfqqs.
>  * @rq_pos_tree: rbtree sorted by next_request position, used when
>  *               determining if two or more queues have interleaving
>  *               requests (see bfq_find_close_cooperator()).
> @@ -942,6 +943,7 @@ struct bfq_group {
> 	struct bfq_entity *my_entity;
>=20
> 	int active_entities;
> +	int busy_queues;
>=20
> 	struct rb_root rq_pos_tree;
>=20
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index f8eb340381cf..d9ff33e0be38 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -218,6 +218,16 @@ static bool bfq_no_longer_next_in_service(struct =
bfq_entity *entity)
> 	return false;
> }
>=20
> +static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
> +{
> +	bfqq_group(bfqq)->busy_queues++;
> +}
> +
> +static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
> +{
> +	bfqq_group(bfqq)->busy_queues--;
> +}
> +
> #else /* CONFIG_BFQ_GROUP_IOSCHED */
>=20
> static bool bfq_update_parent_budget(struct bfq_entity =
*next_in_service)
> @@ -230,6 +240,14 @@ static bool bfq_no_longer_next_in_service(struct =
bfq_entity *entity)
> 	return true;
> }
>=20
> +static void bfq_inc_busy_queues(struct bfq_queue *bfqq)
> +{
> +}
> +
> +static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
> +{
> +}
> +
> #endif /* CONFIG_BFQ_GROUP_IOSCHED */
>=20
> /*
> @@ -1660,6 +1678,7 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
> 	bfq_clear_bfqq_busy(bfqq);
>=20
> 	bfqd->busy_queues[bfqq->ioprio_class - 1]--;
> +	bfq_inc_busy_queues(bfqq);
>=20

Why do you increment the number of busy queues for the group on a
del_bfqq_busy, instead of an add_bfqq_busy?

Besides, the name of the function bfq_inc_busy_queues does not mention
the target of the update, namely the group.  This creates a little
confusion at a first sight, as one sees this function invoked right
after the update of a field with the same name: bfqd->busy_queues.

> 	if (bfqq->wr_coeff > 1)
> 		bfqd->wr_busy_queues--;
> @@ -1683,6 +1702,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, =
struct bfq_queue *bfqq)
>=20
> 	bfq_mark_bfqq_busy(bfqq);
> 	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
> +	bfq_dec_busy_queues(bfqq);

Same pair of comments as above.

Thanks,
Paolo

>=20
> 	if (!bfqq->dispatched)
> 		if (bfqq->wr_coeff =3D=3D 1)
> --=20
> 2.31.1
>=20

