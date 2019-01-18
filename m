Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2932CC07EBF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AFD20823
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dw8SHWcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfARRYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:24:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46658 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfARRYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 12:24:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so15926081wrt.13
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 09:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LdL19VvuwiQZZQ+oXgplGPEqEZFpfJRXauSkt/RaFu0=;
        b=dw8SHWcckTunJdkNoFnXE9/1uLqJo1Ul0ji/kVYmUGizIdZsq5AtLEVZKRZQmTU6q4
         Oyle3luglOWNJhxQVbllJcj7mzXylQlO+0uFFT1bAt5XJ2X7BtYk+bOws30Z0VECps1h
         /fxxUUxgJ1vl9h/rOz7i090tg2UzohxHLBq1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LdL19VvuwiQZZQ+oXgplGPEqEZFpfJRXauSkt/RaFu0=;
        b=oynSKeb/wGpTM+5jk0pjrUWa+RJNxnnVylE0SsVCAytQS2DvEVMPIZBQBQsWH9ehMX
         qnlPS+axng6OgdUOuuk5GtKdZqARjrD3IPYySPLZy1dZ6O2tnpEjcuWiw/h68DAqwFOe
         rezhQS9Z9qGQPTU4rqSKSkI4BG5SIy4Qj+CificgOBY3Peux9vzWCisPsjNaBq22NcbB
         Yj/oYmKNLg5M+AuPWvwe/KjWF2P2lWmsR8NXQmtXGPqA0/xJRmzDCFnfsyPFDrbvjsbK
         GGbbsfk+900KvCm4nVRbfzqIMrEm1zNfuWNOr8y/W2fhWasgfQ9gHZ5j+R91knLafoeH
         pXaw==
X-Gm-Message-State: AJcUukdmN3w0FYqdrIQc8yifaAT7r5YPsc2g5S4v9w8CPrsuUF5m5u+5
        jx63QWfX32/Zmr94t2n2h9bnbg==
X-Google-Smtp-Source: ALg8bN4Dl+CL/2xjoCyOnR1Xdx4SElgTQLwfilZORA/roIRlMyjSJyXcbf3BEXk5LyPL908EzT9JDw==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr17041395wrp.242.1547832274351;
        Fri, 18 Jan 2019 09:24:34 -0800 (PST)
Received: from [192.168.43.112] ([37.162.17.17])
        by smtp.gmail.com with ESMTPSA id c129sm29970547wma.48.2019.01.18.09.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:24:33 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BUGFIX RFC 0/2] reverting two commits causing freezes
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <c3b182a2-7f82-2860-436b-c1d59d6661ff@kernel.dk>
Date:   Fri, 18 Jan 2019 18:24:31 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        hurikhan77+bko@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D212BCED-49BD-47F0-AF7F-0CCDBC82D131@linaro.org>
References: <20190118115219.63576-1-paolo.valente@linaro.org>
 <c3b182a2-7f82-2860-436b-c1d59d6661ff@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 18 gen 2019, alle ore 14:35, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 1/18/19 4:52 AM, Paolo Valente wrote:
>> Hi Jens,
>> a user reported a warning, followed by freezes, in case he increases
>> nr_requests to more than 64 [1]. After reproducing the issues, I
>> reverted the commit f0635b8a416e ("bfq: calculate shallow depths at
>> init time"), plus the related commit bd7d4ef6a4c9 ("bfq-iosched:
>> remove unused variable"). The problem went away.
>=20
> For reverts, please put the justification into the actual revert
> commit. With this series, if applied as-is, we'd have two patches
> in the tree that just says "revert X" without any hint as to why
> that was done.
>=20

I forget to say explicitly that these patches were meant only to give
you and anybody else something concrete to test and check.

With me you're as safe as houses, in terms of amount of comments in
final patches :)

>> Maybe the assumption in commit f0635b8a416e ("bfq: calculate shallow
>> depths at init time") does not hold true?
>=20
> It apparently doesn't! But let's try and figure this out instead of
> blindly reverting it.

Totally agree.

> OK, I think I see it. For the sched_tags
> case, when we grow the requests, we allocate a new set. Hence any
> old cache would be stale at that point.
>=20

ok

> How about something like this? It still keeps the code of having
> to update this out of the hot IO path, and only calls it when we
> actually change the depths.
>=20

Looks rather clean and efficient.

> Totally untested...
>=20

It seems to work here too.

Thanks,
Paolo

>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index cd307767a134..b09589915667 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5342,7 +5342,7 @@ static unsigned int bfq_update_depths(struct =
bfq_data *bfqd,
> 	return min_shallow;
> }
>=20
> -static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int =
index)
> +static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
> {
> 	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
> 	struct blk_mq_tags *tags =3D hctx->sched_tags;
> @@ -5350,6 +5350,11 @@ static int bfq_init_hctx(struct blk_mq_hw_ctx =
*hctx, unsigned int index)
>=20
> 	min_shallow =3D bfq_update_depths(bfqd, &tags->bitmap_tags);
> 	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, =
min_shallow);
> +}
> +
> +static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int =
index)
> +{
> +	bfq_depth_updated(hctx);
> 	return 0;
> }
>=20
> @@ -5772,6 +5777,7 @@ static struct elevator_type iosched_bfq_mq =3D {
> 		.requests_merged	=3D bfq_requests_merged,
> 		.request_merged		=3D bfq_request_merged,
> 		.has_work		=3D bfq_has_work,
> +		.depth_updated		=3D bfq_depth_updated,
> 		.init_hctx		=3D bfq_init_hctx,
> 		.init_sched		=3D bfq_init_queue,
> 		.exit_sched		=3D bfq_exit_queue,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ba37b9e15e9..a047b297ade5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3101,6 +3101,8 @@ int blk_mq_update_nr_requests(struct =
request_queue *q, unsigned int nr)
> 		}
> 		if (ret)
> 			break;
> +		if (q->elevator && q->elevator->type->ops.depth_updated)
> +			q->elevator->type->ops.depth_updated(hctx);
> 	}
>=20
> 	if (!ret)
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index 2e9e2763bf47..6e8bc53740f0 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -31,6 +31,7 @@ struct elevator_mq_ops {
> 	void (*exit_sched)(struct elevator_queue *);
> 	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
> 	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
> +	void (*depth_updated)(struct blk_mq_hw_ctx *);
>=20
> 	bool (*allow_merge)(struct request_queue *, struct request *, =
struct bio *);
> 	bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *);
>=20
> --=20
> Jens Axboe
>=20

