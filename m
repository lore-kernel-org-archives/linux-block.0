Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D44C4338F
	for <linux-block@archiver.kernel.org>; Sat, 24 Jul 2021 07:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953BE60E8C
	for <linux-block@archiver.kernel.org>; Sat, 24 Jul 2021 07:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhGXGcM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Jul 2021 02:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhGXGcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Jul 2021 02:32:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77AEC061757
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 00:12:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z7so4599134wrn.11
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 00:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k3SIdqJjNcyvIqzg9OTyrS4+nLskMR74WbnTGXaM2FI=;
        b=QJwk/7TiSiakAcpE9Vec9Cx0F3PgBamBMd79JFBz9jEb2ATPlLYk4ASZKHBwFafnuC
         kvcxc0VS4ar1tM7Wb4Bq+WQgwNz6zR9svs1CQ213K5oA+mYoaO1eoNl+PwVZ49eas8Gm
         4bEV9mBBxJxAY6ZOM3fMwSHvvQbSsEbFDcKijOBRa5swvgtiGwt22a8rJt1Q0MSp3QLl
         UWXmnj7o3d4wA4LRgR81FMQJ2ut5qXoueUmFP+vowUBlXEGShUgdskzkO9QoqbP1XGMr
         Won1phpvM/4fjVZdfpICB/VI4386dHy02o6piPRl0cdNWIanBCapmCPtHQl0tgCSdLy9
         SIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k3SIdqJjNcyvIqzg9OTyrS4+nLskMR74WbnTGXaM2FI=;
        b=OV/N1MvT//Ij2k0aCOXLwqyq2eSB6Gpo88K22XR+7jnE6RQ++taJJDfMZX6EMUf2pn
         qfnNDqYRgCIGo96EIwYulAvXmwkeX9LPEk3e6AeuuO7V2ujfXSftkkEA+1fVcoHVS5FX
         KaWhAeHE5/sUGAW9F7XrwG8AUl9y9tchwNforiGMe3MiItOgHjWfrO0jo98adtEyeDTP
         kZl4e35uCXxAlms7HOA5L/1JMMXRW+5rCviM5q2k3Xo+o1xyZ9ygt47Bh06mGFqSUC4E
         YYEuzrH53VzN21wVhle5CIz8NBk+HZyjrQL0ULt/SVLqANZFDaQHjxevwozrIl4Rl+5N
         kH8A==
X-Gm-Message-State: AOAM5317zM459KDAFowu+fj1IIKF/eVD6+m5EAz6uoaCY5PXmCfsuG8K
        udr6abUKuiyNmiWGa04MGEi/kQ==
X-Google-Smtp-Source: ABdhPJwXK5nPxvdGlT/rVSBS+XRXgw/Wbg46XiAXHkMQQdMy79INIKuWmEAaxaLICAQ/76yv57rYxg==
X-Received: by 2002:a05:6000:1801:: with SMTP id m1mr3378865wrh.198.1627110762689;
        Sat, 24 Jul 2021 00:12:42 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id c15sm29316186wmr.28.2021.07.24.00.12.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jul 2021 00:12:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/3] block, bfq: do not idle if only one cgroup is
 activated
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210714094529.758808-2-yukuai3@huawei.com>
Date:   Sat, 24 Jul 2021 09:12:40 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DF40BD4-8F57-4C2E-88A9-CBC3DA2A891E@linaro.org>
References: <20210714094529.758808-1-yukuai3@huawei.com>
 <20210714094529.758808-2-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 14 lug 2021, alle ore 11:45, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> If only one group is activated, specifically
> 'bfqd->num_groups_with_pending_reqs =3D=3D 1', there is no need to =
guarantee
> the same share of the throughput of queues in the same group.
>=20
> Thus change the condition from '> 0' to '> 1' in
> bfq_asymmetric_scenario().

I see your point, and I agree with your goal.  Yet, your change seems
not to suffer from the following problem.

In addition to the groups that are created explicitly, there is the
implicit root group.  So, when bfqd->num_groups_with_pending_reqs =3D=3D
1, there may be both active processes in the root group and active
processes in the only group created explicitly.  In this case, idling
is needed to preserve service guarantees.

Probably your idea should be improved by making sure that there is
pending I/O only from either the root group or the explicit group.

Thanks,
Paolo

> By the way, if 'num_groups_with_pending_reqs'
> is greater than 1, there is no need to check 'varied_queue_weights' =
and
> 'multiple_classes_busy', thus move the judgement forward.
>=20
> Test procedure:
> run "fio -numjobs=3D1 -ioengine=3Dpsync -bs=3D4k -direct=3D1 =
-rw=3Drandread..." multiple
> times in the same cgroup(not root).
>=20
> Test result: total bandwidth(Mib/s)
> | total jobs | before this patch | after this patch      |
> | ---------- | ----------------- | --------------------- |
> | 1          | 33.8              | 33.8                  |
> | 2          | 33.8              | 65.4 (32.7 each job)  |
> | 4          | 33.8              | 106.8 (26.7 each job) |
> | 8          | 33.8              | 126.4 (15.8 each job) |
>=20
> By the way, if I test with "fio -numjobs=3D1/2/4/8 ...", test result =
is
> the same with or without this patch.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> block/bfq-iosched.c | 25 ++++++++++++++++---------
> 1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 727955918563..2768a4c1cc45 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -709,7 +709,9 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, =
struct bfq_queue *bfqq)
>  * much easier to maintain the needed state:
>  * 1) all active queues have the same weight,
>  * 2) all active queues belong to the same I/O-priority class,
> - * 3) there are no active groups.
> + * 3) there is one active group at most.
> + * If the last condition is false, there is no need to guarantee the
> + * same share of the throughput of queues in the same group.
>  * In particular, the last condition is always true if hierarchical
>  * support or the cgroups interface are not enabled, thus no state
>  * needs to be maintained in this case.
> @@ -717,7 +719,16 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, =
struct bfq_queue *bfqq)
> static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
> 				   struct bfq_queue *bfqq)
> {
> -	bool smallest_weight =3D bfqq &&
> +	bool smallest_weight;
> +	bool varied_queue_weights;
> +	bool multiple_classes_busy;
> +
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +	if (bfqd->num_groups_with_pending_reqs > 1)
> +		return true;
> +#endif
> +
> +	smallest_weight =3D bfqq &&
> 		bfqq->weight_counter &&
> 		bfqq->weight_counter =3D=3D
> 		container_of(
> @@ -729,21 +740,17 @@ static bool bfq_asymmetric_scenario(struct =
bfq_data *bfqd,
> 	 * For queue weights to differ, queue_weights_tree must contain
> 	 * at least two nodes.
> 	 */
> -	bool varied_queue_weights =3D !smallest_weight &&
> +	varied_queue_weights =3D !smallest_weight &&
> 		!RB_EMPTY_ROOT(&bfqd->queue_weights_tree.rb_root) &&
> 		(bfqd->queue_weights_tree.rb_root.rb_node->rb_left ||
> 		 bfqd->queue_weights_tree.rb_root.rb_node->rb_right);
>=20
> -	bool multiple_classes_busy =3D
> +	multiple_classes_busy =3D
> 		(bfqd->busy_queues[0] && bfqd->busy_queues[1]) ||
> 		(bfqd->busy_queues[0] && bfqd->busy_queues[2]) ||
> 		(bfqd->busy_queues[1] && bfqd->busy_queues[2]);
>=20
> -	return varied_queue_weights || multiple_classes_busy
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	       || bfqd->num_groups_with_pending_reqs > 0
> -#endif
> -		;
> +	return varied_queue_weights || multiple_classes_busy;
> }
>=20
> /*
> --=20
> 2.31.1
>=20

