Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E0EC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 07:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75EE206E0
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 07:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKAnTXZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF1Hve (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:51:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55320 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1Hve (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 03:51:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so8074256wmj.5
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QOwtydTdsXEJRENiBVRnXE9rQ8/ddHg7Tobw5QyeQwQ=;
        b=sKAnTXZJS+/clusnlC0LYM2cW7aY1KM5ruNM+ecGJ5JuW+BNBFwlehDlS7wcYGURkx
         HUrshkwQcG/d8a2iIwFt1SlsFMYXVdyyPbihVccQxvu5G8IwI3aGoOSH6IHkR8FbGJUE
         hfD++lAmDI9z+7w0fwGX03s3DY2ld/AQwgEcZjwtAmppz2SWuRiTDgCmsER4q7VVOO9u
         uqDn5mMZBbfRVf6myTImOb6qgWpEJmLrC+CQdIcNAgpBWf3VA6ZPbApZ55XX1FXxm6r8
         NZxucmjkgfFfb2i+ad36XVPbU6UckbexSRKsLjeFsjqA76IoD7fM8JhYJrGTHIoK55Hb
         6Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QOwtydTdsXEJRENiBVRnXE9rQ8/ddHg7Tobw5QyeQwQ=;
        b=UyKf6RdiL6dBYwtuc40iRyMTHP8xXE8UbFeKD67gyO1FgAA5cD9sa0Lq7Ewg7COvMQ
         Z8iadd/MKQtGgqkoWDCb/tCovNN0y8mnWS1qxVBA5BXlKzcp74KEBty3Id0xzTvTMYUX
         lyt31zcztUMose3aJxO3zu5+vLBLiKcZQwZMIZ1kWSltYj5YcZFkrJI+CSlbYs20MFtI
         L6hNhHaem80CRiOqHvs1jLPi7x5GikONMkRJU6+8KPEy9b0HtlH6lpahh283bSQOZLKe
         D1LuYo7wBO9tQBWG2NGDsTOxZHXtrSSwnCUasVFMcGORi+UpinBRQkCNUnE/NH0zhbkc
         szNw==
X-Gm-Message-State: APjAAAXooR0NtB/dFN01W5FprfNi8EsymWQOj6bqFFoRxh5BAOfpFNGP
        domtZ1QJ7BqA0/1BtB0Q2vTz7YeloUE=
X-Google-Smtp-Source: APXvYqz66cXCm8Qdrj0ImJ9cqsWwj5POjz+bgk6vIIxyIHMWZtVnWpTeFKu6pLSky+8ELUMruSBV9g==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr5964394wmm.108.1561708291155;
        Fri, 28 Jun 2019 00:51:31 -0700 (PDT)
Received: from [192.168.43.112] ([37.161.95.204])
        by smtp.gmail.com with ESMTPSA id c4sm1327285wrt.86.2019.06.28.00.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 00:51:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] block, bfq: NULL out the bic when it's no longer valid
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190628045716.GA17274@roeck-us.net>
Date:   Fri, 28 Jun 2019 09:51:28 +0200
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Guenter Roeck <groeck@chromium.org>, drinkcat@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7CF8D24-8F98-4126-942B-6267D5ED92CE@linaro.org>
References: <20190628044409.128823-1-dianders@chromium.org>
 <20190628045716.GA17274@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 28 giu 2019, alle ore 06:57, Guenter Roeck =
<linux@roeck-us.net> ha scritto:
>=20
> On Thu, Jun 27, 2019 at 09:44:09PM -0700, Douglas Anderson wrote:
>> In reboot tests on several devices we were seeing a "use after free"
>> when slub_debug or KASAN was enabled.  The kernel complained about:
>>=20
>>  Unable to handle kernel paging request at virtual address 6b6b6c2b
>>=20
>> ...which is a classic sign of use after free under slub_debug. The
>> stack crawl in kgdb looked like:
>>=20
>> 0  test_bit (addr=3D<optimized out>, nr=3D<optimized out>)
>> 1  bfq_bfqq_busy (bfqq=3D<optimized out>)
>> 2  bfq_select_queue (bfqd=3D<optimized out>)
>> 3  __bfq_dispatch_request (hctx=3D<optimized out>)
>> 4  bfq_dispatch_request (hctx=3D<optimized out>)
>> 5  0xc056ef00 in blk_mq_do_dispatch_sched (hctx=3D0xed249440)
>> 6  0xc056f728 in blk_mq_sched_dispatch_requests (hctx=3D0xed249440)
>> 7  0xc0568d24 in __blk_mq_run_hw_queue (hctx=3D0xed249440)
>> 8  0xc0568d94 in blk_mq_run_work_fn (work=3D<optimized out>)
>> 9  0xc024c5c4 in process_one_work (worker=3D0xec6d4640, =
work=3D0xed249480)
>> 10 0xc024cff4 in worker_thread (__worker=3D0xec6d4640)
>>=20
>> Digging in kgdb, it could be found that, though bfqq looked fine,
>> bfqq->bic had been freed.
>>=20
>> Through further digging, I postulated that perhaps it is illegal to
>> access a "bic" (AKA an "icq") after bfq_exit_icq() had been called
>> because the "bic" can be freed at some point in time after this call
>> is made.  I confirmed that there certainly were cases where the exact
>> crashing code path would access the "bic" after bfq_exit_icq() had
>> been called.  Sspecifically I set the "bfqq->bic" to (void *)0x7 and
>                ^^^
>=20
>> saw that the bic was 0x7 at the time of the crash.
>>=20
>> To understand a bit more about why this crash was fairly uncommon (I
>> saw it only once in a few hundred reboots), you can see that much of
>> the time bfq_exit_icq_fbqq() fully frees the bfqq and thus it can't
>> access the ->bic anymore.  The only case it doesn't is if
>> bfq_put_queue() sees a reference still held.
>>=20
>> However, even in the case when bfqq isn't freed, the crash is still
>> rare.  Why?  I tracked what happened to the "bic" after the exit
>> routine.  It doesn't get freed right away.  Rather,
>> put_io_context_active() eventually called put_io_context() which
>> queued up freeing on a workqueue.  The freeing then actually happened
>> later than that through call_rcu().  Despite all these delays, some
>> extra debugging showed that all the hoops could be jumped through in
>> time and the memory could be freed causing the original crash. Phew!
>>=20
>> To make a long story short, assuming it truly is illegal to access an
>> icq after the "exit_icq" callback is finished, this patch is needed.
>>=20

Nice work! I think this bug has been there since when BFQ was born ...

Reviewed-by: Paolo Valente <paolo.valente@unimore.it>

Thanks,
Paolo

>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>=20
> Nicely done ... thanks!
>=20
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
>=20
>> ---
>> Most of the testing of this was done on the Chrome OS 4.19 kernel =
with
>> BFQ backported (thanks to Paolo's help).  I did manage to reproduce a
>> crash on mainline Linux (v5.2-rc6) though.
>>=20
>> To see some of the techniques used to debug this, see
>> <https://crrev.com/c/1679134> and <https://crrev.com/c/1681258/1>.
>>=20
>> I'll also note that on linuxnext (next-20190627) I saw some other
>> use-after-frees that seemed related to BFQ but haven't had time to
>> debug.  They seemed unrelated.
>>=20
>> block/bfq-iosched.c | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index f8d430f88d25..6c0cff03f8f6 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -4584,6 +4584,7 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq =
*bic, bool is_sync)
>> 		unsigned long flags;
>>=20
>> 		spin_lock_irqsave(&bfqd->lock, flags);
>> +		bfqq->bic =3D NULL;
>> 		bfq_exit_bfqq(bfqd, bfqq);
>> 		bic_set_bfqq(bic, NULL, is_sync);
>> 		spin_unlock_irqrestore(&bfqd->lock, flags);
>> --=20
>> 2.22.0.410.gd8fdbe21b5-goog

