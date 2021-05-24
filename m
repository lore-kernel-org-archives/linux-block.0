Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DC1C2B9F8
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 17:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40E6601FC
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 17:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhEXRnS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhEXRnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 13:43:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1ACC061574
        for <linux-block@vger.kernel.org>; Mon, 24 May 2021 10:41:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so2044592wmk.1
        for <linux-block@vger.kernel.org>; Mon, 24 May 2021 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=RGosTvzMTUxFi6OUDQA0EfqM0tmzjvXrQDl/ya9MCms=;
        b=qGBffONjFh0Q1rg6TifC98TXqqO7dxMDr/eoTJRYvZQ5sygZ/4kec8Vnf2e5aEejDt
         xxR3BYc+pA4Uku2TbWnfJcIoXaKv411y6NEDgGW6JCpGtx8bBtqaFOg59KR/bbRUKPmO
         VvUO5JZIdzWBkXFX2x5SydRsFAVt8uDhd+Ae0koJd0iJ243izSC52/BHLv5ABO3Af3SX
         4h2h+M9FlZ88gE6SZHhU/+vvvvJbmTV0LWKw6SEE71oaf5qcO82fY86S/g6blfzUzdMP
         H2ihRN8rsJcrBt3aWvGbk9l2MTPR7ytOH6QyZKAvS/bufPA2fzxHsNSnLgWye0RU+3VU
         WV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=RGosTvzMTUxFi6OUDQA0EfqM0tmzjvXrQDl/ya9MCms=;
        b=OFBan7zNwDGAxnkMRSU4s92VMU9Trz61lks1m/Y8KHOqKabc1CQCbfKT0qPMaYB5GA
         nEmhc6VDJDkQ77u0InU/Ye00edTAU3XyPzrFR81tBj8h4SnCrENbcjenLLNNw4TeGP0m
         o1c764ebXP+i4rWbmdul3k4vG5kvEbcr+7jUfhKDdIvnAtL22yG7SmHHCyQM+txr5qns
         luLT86Mjmj+jqfaz+xJq8qwAZMBDDTzgC3RA7bXlFXiSykA2dBiX16Lt/UMCffLo2CfX
         ceN47VD4R5+iaKpinU8+ofGppLcrzg/p6D8drAVxBNxxxu/NGEBdqk7v3uBaiTMQMekn
         jkSQ==
X-Gm-Message-State: AOAM530fizOVuB7sPOEtXFSafJFclwGyY1bGf0wz+rvIo8VxNncapIa/
        mK8dVd61yYKN7jo8YG3K4Zap+CWcWLQSvfEcWNzBcfeD4G+xmc0cnaIErTL/GyBW8rnez1HFe4y
        /xSMCZN0tpqhYC4k=
X-Google-Smtp-Source: ABdhPJyMUOlVz4Llz5arfD05ABvhNsZXrlbCcCsZiIu/eeAS7rmCzMgpO3xjz4lte+BsB6w0CTXt8Q==
X-Received: by 2002:a7b:ce8d:: with SMTP id q13mr190351wmj.109.1621878106477;
        Mon, 24 May 2021 10:41:46 -0700 (PDT)
Received: from [192.168.228.233] ([37.162.61.33])
        by smtp.gmail.com with ESMTPSA id v12sm12736647wru.73.2021.05.24.10.41.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 May 2021 10:41:45 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <E4CEEAB2-7092-4CC5-AA37-59CA5343A5AA@linaro.org>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_106037A2-3136-440B-A87A-ACD6281B3C77"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX] block, bfq: fix delayed stable merge check
Date:   Mon, 24 May 2021 19:41:43 +0200
In-Reply-To: <c6a3d259-a118-0c7a-0faf-1ab48f9cd2ff@applied-asynchrony.com>
Cc:     Luca Mariotti <mariottiluca1@hotmail.it>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
References: <DB8PR01MB59647C41BF6C964467EAFE0D882C9@DB8PR01MB5964.eurprd01.prod.exchangelabs.com>
 <f23f8090-4a55-3c16-1bdd-f86634cd6f3b@applied-asynchrony.com>
 <E9D95C99-D07B-4A63-8C0E-67356887DE23@linaro.org>
 <c6a3d259-a118-0c7a-0faf-1ab48f9cd2ff@applied-asynchrony.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_106037A2-3136-440B-A87A-ACD6281B3C77
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> Il giorno 24 mag 2021, alle ore 19:13, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
> On 2021-05-24 18:57, Paolo Valente wrote:
>>> Il giorno 20 mag 2021, alle ore 09:15, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>>>=20
>>> On 2021-05-18 12:43, Luca Mariotti wrote:
>>>> When attempting to schedule a merge of a given bfq_queue with the =
currently
>>>> in-service bfq_queue or with a cooperating bfq_queue among the =
scheduled
>>>> bfq_queues, delayed stable merge is checked for rotational or =
non-queueing
>>>> devs. For this stable merge to be performed, some conditions must =
be met.
>>>> If the current bfq_queue underwent some split from some merged =
bfq_queue,
>>>> one of these conditions is that two hundred milliseconds must =
elapse from
>>>> split, otherwise this condition is always met.
>>>> Unfortunately, by mistake, time_is_after_jiffies() was written =
instead of
>>>> time_is_before_jiffies() for this check, verifying that less than =
two
>>>> hundred milliseconds have elapsed instead of verifying that at =
least two
>>>> hundred milliseconds have elapsed.
>>>> Fix this issue by replacing time_is_after_jiffies() with
>>>> time_is_before_jiffies().
>>>> Signed-off-by: Luca Mariotti <mariottiluca1@hotmail.it>
>>>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>>>> Signed-off-by: Pietro Pedroni <pedroni.pietro.96@gmail.com>
>>>> ---
>>>>  block/bfq-iosched.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>> index acd1f881273e..2adb1e69c9d2 100644
>>>> --- a/block/bfq-iosched.c
>>>> +++ b/block/bfq-iosched.c
>>>> @@ -2697,7 +2697,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
>>>>  	if (unlikely(!bfqd->nonrot_with_queueing)) {
>>>>  		if (bic->stable_merge_bfqq &&
>>>>  		    !bfq_bfqq_just_created(bfqq) &&
>>>> -		    time_is_after_jiffies(bfqq->split_time +
>>>> +		    time_is_before_jiffies(bfqq->split_time +
>>>>  					  msecs_to_jiffies(200))) {
>>>>  			struct bfq_queue *stable_merge_bfqq =3D
>>>>  				bic->stable_merge_bfqq;
>>>=20
>>> Not sure why but with this patch I quickly got a division-by-zero in =
BFQ and
>>> complete system halt. Unfortunately I couldn't capture the exact =
stack trace,
>>> but it read something like bfq_calc_weight() or something ike that.
>>> I looked through the code and found bfq_delta(), so maybe weight got
>>> reduced to 0?
>>>=20
>> Hi Holger,
>> is this (easily) reproducible for you?  If so, I'd like to propose =
you
>> a candidate fix.
>=20
> Yes, it's easily reproducible (should be reproducible on 5.13-rc as =
well).
> Simple read/write I/O on a cold FS (rotational disk obviously) will =
crash
> pretty much immediately; without it everything works fine, likely =
because the
> bug (in the recent queue merging patches?) is never triggered due to =
the
> accidentally-wrong time calculation.

Exactly!

Unfortunately, no crash happens on my systems.  Or, actually, crashes
stopped after the attached fix.

> Will gladly test your patch! :)
>=20

Here it is!

I'll make a proper commit after your early tests.

Crossing my fingers,
Paolo


--Apple-Mail=_106037A2-3136-440B-A87A-ACD6281B3C77
Content-Disposition: attachment;
	filename=0001-block-bfq-avoid-delayed-merge-of-async-queues.patch.gz
Content-Type: application/x-gzip;
	x-unix-mode=0644;
	name="0001-block-bfq-avoid-delayed-merge-of-async-queues.patch.gz"
Content-Transfer-Encoding: base64

H4sICPDjq2AAAzAwMDEtYmxvY2stYmZxLWF2b2lkLWRlbGF5ZWQtbWVyZ2Utb2YtYXN5bmMtcXVl
dWVzLnBhdGNoAJVTwW7bMAw9R1/BXoqkiRzbie3UGIoOG4pdChRoscswGLJMJ2ptKbHkbsH28aPs
NtuhPUwwJJF6fHyU6JvOtFBHUmKaxCKNVolcpeUqi9OovtyESRits2pd1plIU4Rbo+Ee9xBlEIb5
8EEchhG7IZoc7oRpDHwVDWqH8GHvzeB5NK8bpUVnAtNtr9hn4TCHh12/oHC4FUda4oho82SVhyuY
h8TK7vvyEaXL4dvdx4dPX75D2Rj5tICyPuQgno2qoMJGHLGCFrstgqlB2KOWcOixR8vYvdpqrLip
a14e/0Mf55yN2ZaUjCtj5Q6rQMJv2MB8HISIoFYNgtwJvcVqARkobbFzymg7nc8WBCCB6O0pnzFW
qboGzrfKgVi+RV++5WVKV/gTytUmq9IsTaJNFAQyScJNGYdynQqIwjBdr73qt3kZyX2H+/oaeJym
l4sM5sMarYB8BCosun5fSGP22Alnuql1XS/dcFYJJ+CCdlT1P+7h3gf/YcFgAhcgjXXNEYSuaNvu
GyXp6atgOFzSrGqY9rpRT9gcp2eekF9pozvjih/K7UZGpbezGfxifDLgSyX5lXWibLAYHr7wCeH8
nM0nk+WFnynzrXhCsH2HIBprwO3EoPEAyoJvEuojlKK3+IJ/h7Wl5twbpR04A9a0ODYXTGvTvUSO
QUMPeqVjPhJKjD6ZsNZI5csGXxKI17BTp5KU/q+4oYVHzNIvQ8l0uf688GfeOsyo3vc0000AhdM4
OwU+9tYVskOv40TwCnOqxULZokSqCotH6lOFdoARP72aKzwE5j5g4mNai9IWzpyw9MPOxkfiwOIg
DoOIsT9rI4jVXgQAAA==
--Apple-Mail=_106037A2-3136-440B-A87A-ACD6281B3C77
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> cheers
> Holger


--Apple-Mail=_106037A2-3136-440B-A87A-ACD6281B3C77--
