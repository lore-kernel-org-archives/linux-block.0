Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20E9C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 07:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D542084B
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 07:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSZr6qEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfDAHee (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:34:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38102 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731957AbfDAHed (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 03:34:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so10547003wro.5
        for <linux-block@vger.kernel.org>; Mon, 01 Apr 2019 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HgnHH4QMhZeNy0jkJL3AsgW14xC+spIstOkNXOY1fIY=;
        b=nSZr6qEf2qDavdnD1eR79hTtwBpzcjbxzxgAZJdrgm+QkYH/8wFxtFraHxbVCxqXUj
         1QrPKARECSzpdEHyx2iLgHZ0j8gNOQLYFsp1OWP8k5DvoXKVieQwFsRGxzr2QiLcBS6T
         qPpgAEZZEB0FihwwwgfTblInDdTQdnSfZtPqykIUDhKL09MaP/Db4gCkRpb3Ot0IUM/6
         KEUWIXXBhKcIlMMSkxD6cy79ekPDVOXXgGAiNfV2llPHE/pA+eVT4Sft8ThFBtO+SICi
         mEssdQ+JdFhLmSll4fqqVL+hsRaKwRnZtMUiACh5IEGeIC1dhC7XLcveTlDYY/Bc0yKB
         MogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HgnHH4QMhZeNy0jkJL3AsgW14xC+spIstOkNXOY1fIY=;
        b=JKxyVu+V7GSQEnvPFkmwkfuxQ25t+nKXx/XjtFI7oWklb33W0Z7e8UPGNTuiQwhSng
         uZApdoyz9I9QVWtGsPZ89ysVKiCszusLtKuuOalpR6IdumOZ79dqYUHCjFIMDAWfv1xC
         w++JKuxTKdsEJzVsL6kn2yp3gjCRmckqe+XOk9QPAHDkkV/nH1lQr52Ik+UtH9SewA23
         GMnBnMZd0CFOi4evQn2QrrF9tVqNkWYgSEyfxeu4LCgJls7/PAXC88Gw48F1OX9YzAPc
         dg6r4b0FjEVQ1ZkmaizsQK7pRC+xQ1INjMSwouadmDisgvlH8SIFqSNK6E4ez68lfjBg
         ky4A==
X-Gm-Message-State: APjAAAWQj2y3hFCOcCvRalXnCZbCyYYjTq8RyhPX3n1KW3yfu3C3c5kX
        JguFJ/YVz8vyLSCfA/5pJOUKAA==
X-Google-Smtp-Source: APXvYqwLAOy/7T7G8vHHZPRdC8QSdMLFhUxzD6u+BeFxGFOwk8ICMooCZW+SkMBG9wO3djGTy1GN+Q==
X-Received: by 2002:adf:f088:: with SMTP id n8mr42740299wro.112.1554104071779;
        Mon, 01 Apr 2019 00:34:31 -0700 (PDT)
Received: from [192.168.0.101] ([88.147.53.253])
        by smtp.gmail.com with ESMTPSA id o10sm12424799wru.54.2019.04.01.00.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 00:34:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] block/bfq: fix ifdef for CONFIG_BFQ_GROUP_IOSCHED=y
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3c87a84f-9fb2-2407-a5a3-723b314d8e58@applied-asynchrony.com>
Date:   Mon, 1 Apr 2019 09:34:30 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <319AA9FF-48BD-40D9-A272-17C6BAFE917F@linaro.org>
References: <155386807826.3190.16175453392005064129.stgit@buzz>
 <c40b8d4a-c504-fdf4-0b96-64aaeb167435@applied-asynchrony.com>
 <5234a971-2b6a-47b1-0071-8f3bd07d9fc3@kernel.dk>
 <cf0dc6b2-6ecf-c895-6c21-8746700bdae4@applied-asynchrony.com>
 <6be15f08-dbb4-6b43-3d95-44044f1acdbc@kernel.dk>
 <3c87a84f-9fb2-2407-a5a3-723b314d8e58@applied-asynchrony.com>
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 29 mar 2019, alle ore 17:44, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
> On 3/29/19 5:15 PM, Jens Axboe wrote:
>>>>> Good catch! I run without group scheduling and therefore didn't =
notice these
>>>>> stray defines earlier. For 5.1 it should merge cleanly; adding =
this on top of
>>>>> the pending 5.2 BFQ patches required a small context fixup in hunk =
#1 due to
>>>>> "block, bfq: do not idle for lowest-weight queues".
>>>>=20
>>>> I'm hesitant to apply this, since the group scheduling stuff has =
obviously never
>>>> been tested.
>>>=20
>>> This is simply a regression in 5.1 caused by 73d58118498b - nothing =
else,
>>> and as such this fix needs to go into 5.1 as well. I'm sure Paolo =
will agree.
>>> What you so ominously  call "the group scheduling stuff" has been =
there and
>>> shipping in mainline since day 1 of the BFQ merge, and it works fine =
in 5.0.
>> If that's the case (I didn't check how far back it went), then yes, =
it should
>> of course go into 5.1.
>=20
> Yay.
>=20
>> The ominous nature of my reply I'll chalk up to your interpretation
>=20
> Fair enough ;)
>=20
> A more interesting question is why upstream uses undefined defines
> for patches. That's a first-rate self-grenade if I've ever seen one,
> and obviously something that is easily missed. Paolo?
>=20

Paolo feels a little bit ashamed for this mistake :)

This horrible typo may also be the cause of the crashes recently
reported on this list.  I've just asked to try this fix:
=
https://lore.kernel.org/linux-block/626EAE58-63C1-4ABA-9040-9D9A61F74A0D@l=
inaro.org/T/

And yes, I agree that this fix should be applied to 5.1.  Thank you
Konstantin for spotting and removing this bomb.

Thanks,
Paolo

> -h

