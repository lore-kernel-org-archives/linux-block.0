Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E518EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 11:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbiGTLTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 07:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiGTLTj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 07:19:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FF61E3E4
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 04:19:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bu1so25646590wrb.9
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 04:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ogB/8wL3iyBiG8JjHANTKJKzHhNbXhh+q/EHpuyWSjE=;
        b=CguOHd8Rey/RYG9s/1vZiHm+gTiYRUp5qgKbyN+rBmIkrbD84M8g1aGali9+jKCfI7
         9wbaYHrgBSIHlrBzhz5Vi2vFkU+Qv0fNofLvlksi6Q0qva0cmeOfPI1sjAYSzoQvZL/X
         9JqgraE+lhgoQw8sbUW4SDQG07hGG576kOtRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ogB/8wL3iyBiG8JjHANTKJKzHhNbXhh+q/EHpuyWSjE=;
        b=vEPhxCayLTWatQE5uK3VupfNuYv3T8SFSYZyr6TPXuCPnyr27tPSaTv4B/R2q8eyJb
         m5lN2bhRooVZea/E+RukGuECojkgLwMk5onxBFdNfqXRlyO3btYld0n75Lvg7a7a56y6
         MrMyaT8mWGJH2bqM64Hf2swqyHnIKvqP/czxcQDfAOLYwXswH11ipPXZ/m5i4fjDp3UH
         lt4R8Ry8zokRDG64bvL9dA0lX5BkdeeO/JZlL4orXoCn10S5NFriyoqtk/BPxrt3k0vn
         y1iMQlhOAuOspOzsK/IQV4HFhaLfg4ZJGH19AaRx67zHK4zzSUsSDmRoW/EM8Nze5NNX
         RFPQ==
X-Gm-Message-State: AJIora/HSkaDzVl2+7+rQTn04iiCfrqDiJ/+RaN5FB/EDObo9qraH1aY
        KmWtTjXXd9ogs243SF/HCWBI
X-Google-Smtp-Source: AGRyM1s85/BIu+Wxr7o+oG6TwEByZmWFg4alqueU0ytFlfiCC+1o2LZ+dpkf4XnHQpCDI+6i+qhJ3g==
X-Received: by 2002:adf:e88f:0:b0:21e:4ecd:7c0c with SMTP id d15-20020adfe88f000000b0021e4ecd7c0cmr728074wrm.102.1658315975073;
        Wed, 20 Jul 2022 04:19:35 -0700 (PDT)
Received: from wifi-122-dhcprange-122-47.wifi.unimo.it (wifi-122-dhcprange-122-47.wifi.unimo.it. [155.185.122.47])
        by smtp.gmail.com with ESMTPSA id z12-20020adfdf8c000000b0021e4cf58155sm868497wrl.17.2022.07.20.04.19.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2022 04:19:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] block: remove unnecessary type castings
From:   Paolo VALENTE <paolo.valente@unimore.it>
In-Reply-To: <20220706053529.15952-1-yuzhe@nfschina.com>
Date:   Wed, 20 Jul 2022 13:19:34 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, liqiong@nfschina.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4182887-F9F8-4527-B575-02D6BF56D4C4@unimore.it>
References: <20220706053529.15952-1-yuzhe@nfschina.com>
To:     Yu Zhe <yuzhe@nfschina.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 6 lug 2022, alle ore 07:35, Yu Zhe <yuzhe@nfschina.com> ha =
scritto:
>=20
> remove unnecessary void* type castings.
>=20

Thanks for improving BFQ code. Which commit made these casts =
unnecessary?

Paolo


> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
> block/bfq-wf2q.c   | 6 +++---
> block/blk-iocost.c | 2 +-
> 2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index f8eb340381cf..2a666b100bcb 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -474,7 +474,7 @@ static void bfq_active_insert(struct =
bfq_service_tree *st,
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> 	sd =3D entity->sched_data;
> 	bfqg =3D container_of(sd, struct bfq_group, sched_data);
> -	bfqd =3D (struct bfq_data *)bfqg->bfqd;
> +	bfqd =3D bfqg->bfqd;
> #endif
> 	if (bfqq)
> 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
> @@ -573,7 +573,7 @@ static void bfq_active_extract(struct =
bfq_service_tree *st,
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> 	sd =3D entity->sched_data;
> 	bfqg =3D container_of(sd, struct bfq_group, sched_data);
> -	bfqd =3D (struct bfq_data *)bfqg->bfqd;
> +	bfqd =3D bfqg->bfqd;
> #endif
> 	if (bfqq)
> 		list_del(&bfqq->bfqq_list);
> @@ -719,7 +719,7 @@ __bfq_entity_update_weight_prio(struct =
bfq_service_tree *old_st,
> 		else {
> 			sd =3D entity->my_sched_data;
> 			bfqg =3D container_of(sd, struct bfq_group, =
sched_data);
> -			bfqd =3D (struct bfq_data *)bfqg->bfqd;
> +			bfqd =3D bfqg->bfqd;
> 		}
> #endif
>=20
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 33a11ba971ea..117181a69b7a 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -1430,7 +1430,7 @@ static int iocg_wake_fn(struct wait_queue_entry =
*wq_entry, unsigned mode,
> 			int flags, void *key)
> {
> 	struct iocg_wait *wait =3D container_of(wq_entry, struct =
iocg_wait, wait);
> -	struct iocg_wake_ctx *ctx =3D (struct iocg_wake_ctx *)key;
> +	struct iocg_wake_ctx *ctx =3D key;
> 	u64 cost =3D abs_cost_to_cost(wait->abs_cost, ctx->hw_inuse);
>=20
> 	ctx->vbudget -=3D cost;
> --=20
> 2.11.0
>=20

