Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5547FC43444
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FCC217D9
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wxh2DL5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeLRHsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:48:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54287 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeLRHsP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 02:48:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so1591823wmh.4
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 23:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Kt+dilJmGwkuVs0eigmJgpREcGmoqrJGrClqrNmT6aU=;
        b=Wxh2DL5AbiKQrF11LEES9eWPBEBSTZ1zcyEfC5OFIxe5zxDlVf3L8AWPxUQvEr/Tyy
         ndVTsUgworPs1CZCKwd4AawI2dtANrHqaNb1l2lEBVwZdywbsuJTn7H7l2iKWdz3lpE9
         gA/fI3Pu8xqZok0jhQCsb4zuzJ/Y2SfLDO6mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Kt+dilJmGwkuVs0eigmJgpREcGmoqrJGrClqrNmT6aU=;
        b=XNLGzmT+G9viRSTUtNBXwzGeX1V5D7cW0UPdRV7upnLIvqh247T61SY12hlYnnL1TI
         sgALlxcQU0KOTO0zLOdv+83Y2NnPqUZfyXXyJqAvzLrDgRmEP41ibx5ipAAwIFa5J4Rk
         PrpXH2fX2ZEFLn/+zRYd6hKC+X2d/5q3E5PBIu9vbyJoYb6gqYNIR494xbuKAtRrMEsE
         JR1wziic09Eev0rIP8m4jA2D8dEIWRha7ZI3knKYkr3jK0yVBRddtsUyUQziD3UsKyHG
         8xKy3U04pxEDbSj8w2vN5vY/TpgzU5/wpwpIYdTOiyGOCBOGjgS5dCX+PN3pY/nPoPgn
         BnXw==
X-Gm-Message-State: AA+aEWb/tqTbl+2UrnQq68WEdKx2Mp+FNy7SYoij+W+hYkFZ1GbPmkPw
        Un9O63xpE83JZ51yTBIKPMzIxQ==
X-Google-Smtp-Source: AFSGD/V2FVi65YSIswG69YQVGsk5y63huHKnYe3nbQGDf2ECA4UfGT8HOG161hKvwDUnBReeC7j95A==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr1786370wmi.24.1545119292549;
        Mon, 17 Dec 2018 23:48:12 -0800 (PST)
Received: from [192.168.0.100] (146-241-122-94.dyn.eolo.it. [146.241.122.94])
        by smtp.gmail.com with ESMTPSA id e16sm2699465wrn.72.2018.12.17.23.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 23:48:11 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CADiTV-29TmkB5-k=TtQfoJqjP2Qv7GSsGLXAPBaTB6DoQ+6yyw@mail.gmail.com>
Date:   Tue, 18 Dec 2018 08:48:10 +0100
Cc:     'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, oleksandr@natalenko.name,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <874A0232-2103-4364-BD88-F33B85D6A764@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
 <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
 <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
 <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org>
 <20181130184256.GI2509588@devbig004.ftw2.facebook.com>
 <5534B7D4-A5D9-4F44-9620-970A7F9EC140@linaro.org>
 <CADiTV-29TmkB5-k=TtQfoJqjP2Qv7GSsGLXAPBaTB6DoQ+6yyw@mail.gmail.com>
To:     Angelo Ruocco <angelo.ruocco.90@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[RESENDING BECAUSE BOUNCED]

> Il giorno 10 dic 2018, alle ore 14:45, Angelo Ruocco =
<angelo.ruocco.90@gmail.com> ha scritto:
>=20
> 2018-11-30 19:53 GMT+01:00, Paolo Valente <paolo.valente@linaro.org>:
>>=20
>>=20
>>> Il giorno 30 nov 2018, alle ore 19:42, Tejun Heo <tj@kernel.org> ha
>>> scritto:
>>>=20
>>> Hello, Paolo.
>>>=20
>>> On Fri, Nov 30, 2018 at 07:23:24PM +0100, Paolo Valente wrote:
>>>>> Then we understood that exactly the same happens with throttling, =
in
>>>>> case the latter is activated on different devices w.r.t. bfq.
>>>>>=20
>>>>> In addition, the same may happen, in the near future, with the
>>>>> bandwidth controller Josef is working on.  If the controller can =
be
>>>>> configured per device, as with throttling, then statistics may =
differ,
>>>>> for the same interface files, between bfq, throttling and that
>>>>> controller.
>>>=20
>>> So, regardless of how all these are implemented, what's presented to
>>> user should be consistent and clear.  There's no other way around =
it.
>>> Only what's relevant should be visible to userspace.
>>>=20
>>>> have you had time to look into this?  Any improvement to this
>>>> interface is ok for us. We are only interested in finally solving =
this
>>>> interface issue, as, for what concerns us directly, it has been
>>>> preventing legacy code to use bfq for years.
>>>=20
>>> Unfortunately, I don't have any implementation proposal, but we =
can't
>>> show things this way to userspace.
>>>=20
>>=20
>> Well, this is not very helpful to move forward :)
>>=20
>> Let me try to repeat the problem, to try to help you help us unblock
>> the situation.
>>=20
>> If we have multiple entities attached to the same interface output
>> file, you don't find it clear that each entity shows the number it
>> wants to show.  But you have no idea either of how that =
differentiated
>> information should be shown.  Is this the situation, or is the =
problem
>> somewhere 'above' this level?
>>=20
>> If the problem is as I described it, here are some proposal attempts:
>> 1) Do you want file sharing to be allowed only if all entities will
>> output the same number?  (this seems excessive, but maybe it makes
>> sense)
>> 2) Do you want only one number to be shown, equal to the sum of the
>> numbers of each entity?  (in some cases, this may make sense)
>> 3) Do you prefer an average?
>> 4) Do you have any other idea, even if just germinal?
>=20
> To further add to what Paolo said and better expose the problem, I'd =
like to
> say that all those proposals have issues.
> If we only allow "same output" cftypes to be shared then we lose all =
the
> flexibility of this solution, and we need a way for an entity to know =
other
> entities internal variables beforehand, which sounds at least very =
hard, and
> maybe is not even an acceptable thing to do.
> To put the average, sum or some other mathematical function in the =
file only
> makes sense for certain cftypes, so also doesn't sound like a good =
idea. In
> fact I can think of scenarios where only seeing the different values =
of the
> entities makes sense for a user.
>=20
> I understand that the problem is inconsistency: having a file that =
behaves
> differently depending on the situation, and the only way to prevent =
this I can
> think of is to *always* show the entity owner of a certain file (or =
part of the
> output), even when the output would be the same among entities or when =
the
> file is not currently shared but could be. Can this be an acceptable =
solution?
>=20
> Angelo
>=20

Hi Jens, all,
let me push for this interface to be fixed too.  If we don't fix it in
some way, then from 4.21 we well end up with a ridiculous paradox: the
proportional share policy (weights) will of course be available, but
unusable in practice.  In fact, as Lennart--and not only Lennart--can
confirm, no piece of code uses bfq.weight to set weights, or will do
it.

A trivial solution would be to throw away all our work to fix this
issue by extending the interface, and just let bfq use the former cfq
names.  But then the same mess will happen as, e.g., Josef will
propose his proportional-share controller.

Before making this solution, we proposed it and waited for it to be
approved several months ago, so I hope that Tejun concern can be
addressed somehow.

If Tejun cannot see any solution to his concern, then can we just
switch to this extension, considering that
- for non-shared names the interface is *identical* to the current
  one;
- by using this new interface, and getting feedback we could
  understand how to better handle Tejun's concern?

A lot of systems do use weights, and people don't even know that these
systems don't work correctly in blk-mq.  And they won't work correctly
in any available configuration from 4.21, if we don't fix this problem.

Thanks.
Paolo

>>=20
>> Looking forward to your feedback,
>> Paolo
>>=20
>>=20
>>> Thanks.
>>>=20
>>> --
>>> tejun
>>>=20
>>> --
>>> You received this message because you are subscribed to the Google =
Groups
>>> "bfq-iosched" group.
>>> To unsubscribe from this group and stop receiving emails from it, =
send an
>>> email to bfq-iosched+unsubscribe@googlegroups.com.
>>> For more options, visit https://groups.google.com/d/optout.

