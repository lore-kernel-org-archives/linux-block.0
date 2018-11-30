Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE77C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 18:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366802146F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 18:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8dX7FoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366802146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeLAGDY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:03:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39204 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeLAGDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 01:03:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id n133so6711409wmd.4
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iEs0bu2v/4Sbmzc6i6UNYRAir2y1g1QCSGpytJmcmF4=;
        b=g8dX7FoZG+8Sd9IqjIs5yD0k5Nvh75AU4C2jRh+xbHynzneloHDxHX7x4y6NEIU9lo
         rK3R56IyT7atQubRCSGtGLextL736gjUxcfoa5s2pLusGyHaozLv8rbzjs0kxtXD1LAM
         3S0cGJHkXW9aNOCNa1MfpIculGopHk6o10gVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iEs0bu2v/4Sbmzc6i6UNYRAir2y1g1QCSGpytJmcmF4=;
        b=cxvVSCbeZZmNAp7Y1n8UDoYBX9BtnyVyJdqLE0EDx/iOQVKvWUIaBUGKjqI6ZCaSS3
         js2SHmycVf6LAyRXmPpFsAG+vpS+jRgfichgzFTy80U15W/YlJ878YJ6DHelXpakC0Tg
         ZhDmnIyDwoyjEdV0VNedWNCFnVgf7CMu2Nw1V2No+Z3IMrpYevYH+/HkY0UIiqUqQU27
         zKfm4mikMUIaK5V64sAKzYSngstNOyogHp/kvbKzk2urODuJJ8EAEcS9lEUI1C7n/+1d
         XUaGISXWZOMaj0TJ56y0ALKnKv9H5CsiJ48+nyEQK+it94mr+pSL/++9RQvpE0TzOtrZ
         dG1Q==
X-Gm-Message-State: AA+aEWaVZ+oE6+6C9Q3rTekHwTHEOD40qLb13dOoSuwbfBdG7K5O2v6m
        g5Qv1UbxGwj9xp+TYxX5WSmwGw==
X-Google-Smtp-Source: AFSGD/VGoBLBVBLtQfiPhxsQQOvd6iV2PLvCdQFS0fTQ0XE+hWK2uQs1UsHuwfcvLFRH3vYXJWImXg==
X-Received: by 2002:a1c:f0e:: with SMTP id 14mr6435941wmp.37.1543603989316;
        Fri, 30 Nov 2018 10:53:09 -0800 (PST)
Received: from [192.168.0.101] (146-241-2-120.dyn.eolo.it. [146.241.2.120])
        by smtp.gmail.com with ESMTPSA id e19sm12792365wrc.25.2018.11.30.10.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 10:53:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20181130184256.GI2509588@devbig004.ftw2.facebook.com>
Date:   Fri, 30 Nov 2018 19:53:07 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
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
Message-Id: <5534B7D4-A5D9-4F44-9620-970A7F9EC140@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
 <20181120162816.GV2509588@devbig004.ftw2.facebook.com>
 <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
 <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org>
 <20181130184256.GI2509588@devbig004.ftw2.facebook.com>
To:     'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 30 nov 2018, alle ore 19:42, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20
> On Fri, Nov 30, 2018 at 07:23:24PM +0100, Paolo Valente wrote:
>>> Then we understood that exactly the same happens with throttling, in
>>> case the latter is activated on different devices w.r.t. bfq.
>>>=20
>>> In addition, the same may happen, in the near future, with the
>>> bandwidth controller Josef is working on.  If the controller can be
>>> configured per device, as with throttling, then statistics may =
differ,
>>> for the same interface files, between bfq, throttling and that
>>> controller.
>=20
> So, regardless of how all these are implemented, what's presented to
> user should be consistent and clear.  There's no other way around it.
> Only what's relevant should be visible to userspace.
>=20
>> have you had time to look into this?  Any improvement to this
>> interface is ok for us. We are only interested in finally solving =
this
>> interface issue, as, for what concerns us directly, it has been
>> preventing legacy code to use bfq for years.
>=20
> Unfortunately, I don't have any implementation proposal, but we can't
> show things this way to userspace.
>=20

Well, this is not very helpful to move forward :)

Let me try to repeat the problem, to try to help you help us unblock
the situation.

If we have multiple entities attached to the same interface output
file, you don't find it clear that each entity shows the number it
wants to show.  But you have no idea either of how that differentiated
information should be shown.  Is this the situation, or is the problem
somewhere 'above' this level?

If the problem is as I described it, here are some proposal attempts:
1) Do you want file sharing to be allowed only if all entities will
output the same number?  (this seems excessive, but maybe it makes
sense)
2) Do you want only one number to be shown, equal to the sum of the
numbers of each entity?  (in some cases, this may make sense)
3) Do you prefer an average?
4) Do you have any other idea, even if just germinal?

Looking forward to your feedback,
Paolo=20


> Thanks.
>=20
> --=20
> tejun
>=20
> --=20
> You received this message because you are subscribed to the Google =
Groups "bfq-iosched" group.
> To unsubscribe from this group and stop receiving emails from it, send =
an email to bfq-iosched+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

