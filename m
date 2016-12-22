Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f170.google.com ([209.85.210.170]:35743 "EHLO
        mail-wj0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756832AbcLVPUK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2016 10:20:10 -0500
Received: by mail-wj0-f170.google.com with SMTP id v7so231544578wjy.2
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2016 07:20:09 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 6/8] blk-mq-sched: add framework for MQ capable IO schedulers
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20161221022229.GA21762@kernel.dk>
Date: Thu, 22 Dec 2016 16:20:06 +0100
Cc: linux-block@vger.kernel.org,
        Linux-Kernal <linux-kernel@vger.kernel.org>, osandov@fb.com
Message-Id: <330DF208-2B8E-4D29-A2AD-B335BF495AAE@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <1481933536-12844-7-git-send-email-axboe@fb.com> <4A1753A0-121C-4A01-8821-6CDD99C98896@linaro.org> <20161221022229.GA21762@kernel.dk>
To: Jens Axboe <axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 21 dic 2016, alle ore 03:22, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> On Tue, Dec 20 2016, Paolo Valente wrote:
>>> +	else
>>> +		rq =3D __blk_mq_alloc_request(data, op);
>>> +
>>> +	if (rq) {
>>> +		rq->elv.icq =3D NULL;
>>> +		if (e && e->type->icq_cache)
>>> +			blk_mq_sched_assign_ioc(q, rq, bio);
>>=20
>> bfq needs rq->elv.icq to be consistent in bfq_get_request, but the
>> needed initialization seems to occur only after mq.get_request is
>> invoked.
>=20
> Can you do it from get/put_rq_priv?

Definitely, I just overlooked them, sorry :(

Thanks,
Paolo

> The icq is assigned there. If not,
> we can redo this part, not a big deal.
>=20
> --=20
> Jens Axboe
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

