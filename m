Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D6C32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 10:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6552089E
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 10:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnpKvvn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfGaKLW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:11:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37617 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfGaKLV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 06:11:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so43938254wrr.4
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OkLpFW3muTNu0EBzFfltcBJdzbpj7Ripja8zgyGMop8=;
        b=WnpKvvn7BxnNcYPdHk5rlNRVoK48qLNjkRF5xzBiIdj23FGF8TjRn685wlUr3Wa1Nx
         XtTMN7Vm+NNYe9s/xWjUGnJHFeBaO/7jGfiB0X2s5s10iJGAzdGJ1CkSp/6zCugJ343M
         8ucm8shTtQ0tlvHSXBgE7T5mxFJolvQHEvGCdyvIYRtoop7N3r1uF4WNSVe6eStgwSTQ
         KZgaOBmxJyx+I98Y6gB2B3SPymcUK7NvY7+0PjB0UVHdxjhvGgu0xZSBhZ7MCFI42SX1
         R+NrqMTxwaT1ySyALVEqVfXrXJBnyrKHujIH0SwTtHRVrVMG6R8ElH+VgjieaP8Kmwj5
         mNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OkLpFW3muTNu0EBzFfltcBJdzbpj7Ripja8zgyGMop8=;
        b=p/on7rxIVU/eW/jrSzCRq4hWQXuhiDuwSj/uM+k5dEohDTtP4S45ZMPxNBJX0d/jUr
         50vCfxdcvz9OtjrcGsFk8qb4U+ejRTaAUpuLa0FVNCR+ieiXR85btlELmQLafKswxK9E
         e8N9jHkRkeesJyfF3LRtJMEalK7iBj0a7DKtku1Gu53x9Ddk+xck57vlRxkDmG3Yl1Rn
         HAZRDeEW3uO45LzUFZGff7Xm9gy405Xd9WMxxmos9lxjKO7hTrpHbG2ZzQFSSbrsbZvn
         jNHhwD5/Kr/PAslsPD666Osr/YeVWSfpqJdfSB7FA5lTdkHNejXh/lMvfm+xaa3tOxbB
         pBfQ==
X-Gm-Message-State: APjAAAXdTyGu8ioQNoqbLPqOpioBNpSo6hAzrxeFCh9sWOkh0qsQTi4Y
        SRiAi33i/1IX/Lz5nnn89lzHXQ==
X-Google-Smtp-Source: APXvYqysgBG6cPtJElknFrwTIdYfNo3Xd1fba0pMgwDmQ+ln+puS5XlLek/zYQ+11IJ4b1XSy5P9VA==
X-Received: by 2002:a5d:4b91:: with SMTP id b17mr13477615wrt.57.1564567879247;
        Wed, 31 Jul 2019 03:11:19 -0700 (PDT)
Received: from [192.168.0.100] (88-147-65-240.dyn.eolo.it. [88.147.65.240])
        by smtp.gmail.com with ESMTPSA id p18sm66750384wrm.16.2019.07.31.03.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 03:11:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] bfq: Check if bfqq is NULL in bfq_insert_request
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <23890163-facd-3838-ddee-770b7c2f32ea@roeck-us.net>
Date:   Wed, 31 Jul 2019 12:11:11 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5162CB3B-39B1-4348-AEBD-2197330A3BA3@linaro.org>
References: <1563816648-12057-1-git-send-email-linux@roeck-us.net>
 <20190728151931.GA29181@roeck-us.net>
 <0BCD5EDA-6D08-4023-9EEA-087F0AB99D47@linaro.org>
 <23890163-facd-3838-ddee-770b7c2f32ea@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 30 lug 2019, alle ore 15:35, Guenter Roeck =
<linux@roeck-us.net> ha scritto:
>=20
> On 7/30/19 1:55 AM, Paolo Valente wrote:
>> Hi Guenter,
>> sorry for the delay (Dolomiti's fault).
>> I didn't consider that rq->elv-icq might have been NULL also
>> because of OOM.  Thanks for spotting this issue.
>> As for the other places where the return value of bfq_init_rq is =
used,
>> unfortunately I think they matter too.  Those other places are =
related
>> to request merging, which is the alternative destiny of requests
>> (instead of being just inserted).  But, regardless of whether a
>> request is to be merged or inserted, that request may be destined to =
a
>> bfq_queue (possibly merged with a request already in a bfq_queue), =
and
>> a NULL return value by bfq_init_rq leads to a crash.  I guess you can
>> reproduce your failure also for the merge case, by generating
>> sequential, direct I/O with queue depth > 1, and of course by =
enabling
>> failslab.
> My assumption was that requests would only be merged if they are =
associated
> with the same io context. In that case, that IO context isn't =
reallocated
> with ioc_create_icq() but reused, and icq would thus never be NULL.
> I guess that assumption was wrong.

I don't remember such a filtering.  I had a look again, but didn't
find anything relevant.  However, more competent people see these
emails.  Maybe someone can give us better advice.  Otherwise, to stay
on the safe side, I'd propose to handle any possible NULL return.

And I'll manage it, as per your request.

Thanks,
Paolo

>=20
>> If my considerations above are correct, do you want to propose a
>> complete fix yourself?
>=20
> Sure, I'll send an updated patch.
>=20
> Thanks,
> Guenter
>=20
>> Thanks,
>> Paolo
>>> Il giorno 28 lug 2019, alle ore 17:19, Guenter Roeck =
<linux@roeck-us.net> ha scritto:
>>>=20
>>> ping ... just in case this patch got lost in Paolo's queue.
>>>=20
>>> Guenter
>>>=20
>>> On Mon, Jul 22, 2019 at 10:30:48AM -0700, Guenter Roeck wrote:
>>>> In bfq_insert_request(), bfqq is initialized with:
>>>> 	bfqq =3D bfq_init_rq(rq);
>>>> In bfq_init_rq(), we find:
>>>> 	if (unlikely(!rq->elv.icq))
>>>> 		return NULL;
>>>> Indeed, rq->elv.icq can be NULL if the memory allocation in
>>>> create_task_io_context() failed.
>>>>=20
>>>> A comment in bfq_insert_request() suggests that bfqq is supposed to =
be
>>>> non-NULL if 'at_head || blk_rq_is_passthrough(rq)' is false. Yet, =
as
>>>> debugging and practical experience shows, this is not the case in =
the
>>>> above situation.
>>>>=20
>>>> This results in the following crash.
>>>>=20
>>>> Unable to handle kernel NULL pointer dereference
>>>> 	at virtual address 00000000000001b0
>>>> ...
>>>> Call trace:
>>>> bfq_setup_cooperator+0x44/0x134
>>>> bfq_insert_requests+0x10c/0x630
>>>> blk_mq_sched_insert_requests+0x60/0xb4
>>>> blk_mq_flush_plug_list+0x290/0x2d4
>>>> blk_flush_plug_list+0xe0/0x230
>>>> blk_finish_plug+0x30/0x40
>>>> generic_writepages+0x60/0x94
>>>> blkdev_writepages+0x24/0x30
>>>> do_writepages+0x74/0xac
>>>> __filemap_fdatawrite_range+0x94/0xc8
>>>> file_write_and_wait_range+0x44/0xa0
>>>> blkdev_fsync+0x38/0x68
>>>> vfs_fsync_range+0x68/0x80
>>>> do_fsync+0x44/0x80
>>>>=20
>>>> The problem is relatively easy to reproduce by running an image =
with
>>>> failslab enabled, such as with:
>>>>=20
>>>> cd /sys/kernel/debug/failslab
>>>> echo 10 > probability
>>>> echo 300 > times
>>>>=20
>>>> Avoid the problem by checking if bfqq is NULL before using it. With =
the
>>>> NULL check in place, requests with missing io context are queued
>>>> immediately, and the crash is no longer seen.
>>>>=20
>>>> Fixes: 18e5a57d79878 ("block, bfq: postpone rq preparation to =
insert or merge")
>>>> Reported-by: Hsin-Yi Wang  <hsinyi@google.com>
>>>> Cc: Hsin-Yi Wang <hsinyi@google.com>
>>>> Cc: Nicolas Boichat <drinkcat@chromium.org>
>>>> Cc: Doug Anderson <dianders@chromium.org>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>> block/bfq-iosched.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>> index 72860325245a..56f3f4227010 100644
>>>> --- a/block/bfq-iosched.c
>>>> +++ b/block/bfq-iosched.c
>>>> @@ -5417,7 +5417,7 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
>>>>=20
>>>> 	spin_lock_irq(&bfqd->lock);
>>>> 	bfqq =3D bfq_init_rq(rq);
>>>> -	if (at_head || blk_rq_is_passthrough(rq)) {
>>>> +	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
>>>> 		if (at_head)
>>>> 			list_add(&rq->queuelist, &bfqd->dispatch);
>>>> 		else
>>>> --=20
>>>> 2.7.4
>>>>=20
>=20

