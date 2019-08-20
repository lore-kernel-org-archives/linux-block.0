Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D0C3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 06:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330AB20C01
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 06:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfX0ULv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfHTG6c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:58:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39471 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTG6c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 02:58:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so11138041wra.6
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 23:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nw/zPLpPdEq5PJCC4OQ4ECqpFKTVKT/husVoiJCAv0g=;
        b=ZfX0ULv9OWyQGJotrH6dCLJmx9OYP44gWzWKJXfnoBC4+b4TeCAQ5yaNAtsNh4Pe61
         Bw+pu3Xxrq1nUf2gOjYoc5mgunw5yDQioGB8ikDvx5EsLWM/RRxbJpRC9fUGmpVIqzSg
         Yh+DUE8izYH09wtP6OnvvfwXG3qdaxronFLy2QVxqg3A+Q/CeUKt/zJG2tWiq4p/+aWp
         oO3a8dFYAtdZercxAmuocG03ik1jkknw8aGBiqyL13V0aRizhMNZ6JgX89ck9yhSGO9r
         AFpBj+z8b8wjWaa7OYpEVEbIce5ispH6eC0wkbdPnvXFcLiQ0k5bUBicLais1BSkHm5I
         47JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nw/zPLpPdEq5PJCC4OQ4ECqpFKTVKT/husVoiJCAv0g=;
        b=YHRZgiFsD68V/sYvs04xYPEUw1jSLMceeX2L49A9X3hQjcfA7fca4KWIjLoL4bne2d
         RXLIZlPxCa0tJGXiSCSW30h8zBfarKiHy+9QxBgTiPVujAsKycKrxrx9VYgEvz2c+OVT
         45uemC3uhRhxFzEDC7Rh/cGY+Zn0T2kvd+YAJMAeUIoiLQJaEKvwSUuwoCG5EZmS98cj
         AFUUpLa2qwkujFvksbQ1QMFcVKi0wy4bFtOSTB7w5ERH5Y8U4jNCc5tTP512O/sRRGV8
         mcN+8eQH/fUvdno2aI93kLtaGG5kvUrbxny+11goDCkTt9KE0pXdjifT/lonx7Gec5hw
         j27w==
X-Gm-Message-State: APjAAAUzrv475wO8uPKd2HY+ZuYxHM6BlBmsoXh+UNXdasT/8M2m12Ze
        nn6F3okOb1wTwQMiUK2CYMVsWw==
X-Google-Smtp-Source: APXvYqwBn4eri2hJuA1n914XmQUoXZTlqJ+S/n1PG3ipt4LUZ51m/cWjBhI0yYocew1028M5tC+b7Q==
X-Received: by 2002:a05:6000:145:: with SMTP id r5mr33401973wrx.75.1566284309990;
        Mon, 19 Aug 2019 23:58:29 -0700 (PDT)
Received: from [192.168.0.101] (88-147-37-138.dyn.eolo.it. [88.147.37.138])
        by smtp.gmail.com with ESMTPSA id x10sm7958039wrn.39.2019.08.19.23.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 23:58:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH block/for-5.2-fixes] bfq: use io.weight interface file
 instead of io.bfq.weight
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <78B23D07-0EF6-4FBA-8B21-5C028699C450@linaro.org>
Date:   Tue, 20 Aug 2019 08:58:27 +0200
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fam Zheng <fam@euphon.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0CE6021C-E04C-4F29-944F-E9CAA9209A96@linaro.org>
References: <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
 <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
 <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
 <20190610154820.GA3341036@devbig004.ftw2.facebook.com>
 <20190611194959.GJ3341036@devbig004.ftw2.facebook.com>
 <20190611211718.GM3341036@devbig004.ftw2.facebook.com>
 <A1C3E3D8-62E3-4BD3-86B4-59E7E1319EA8@linaro.org>
 <20190612133926.GN3341036@devbig004.ftw2.facebook.com>
 <530F0FC2-EBE5-4417-8732-010837C18357@linaro.org>
 <20190614202222.GC657710@devbig004.ftw2.facebook.com>
 <78B23D07-0EF6-4FBA-8B21-5C028699C450@linaro.org>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 14 giu 2019, alle ore 23:05, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 14 giu 2019, alle ore 22:22, Tejun Heo <tj@kernel.org> ha =
scritto:
>>=20
>> Hello,
>>=20
>> On Thu, Jun 13, 2019 at 08:10:38AM +0200, Paolo Valente wrote:
>>> BFQ does not implement weight_device, but we are not talking about
>>> weight_device here.  More precisely, *nothing* implements =
weight_device
>>> any longer in cgroups-v1, so the documentation is wrong altogether.
>>=20
>> I can't see how renaming an interface file which has different
>> behaviors on the same input to the same name is something acceptable.
>> Imagine how confusing that'd be to userspace.  If you want to rename
>> the control knob to io.weight, please implement full semantics for
>> both cgroup1 and cgroup2.
>>=20
>=20
> I want to, and I've tried to make it easier for you to point me to
> what is missing exactly.  Once again, the only missing piece I see are
> per-device weights.
>=20
>> I just posted a separate io.weight implementation for cgroup2 but =
it's
>> easy to provide a way to override the interface files when bfq gets
>> selected, so let me know when you have a working implementation of =
the
>> interface.
>>=20
>=20
> Ok, thanks.  I'll ping you when also per-device weights are available
> in BFQ's interface.
>=20

Hi Tejun,
have you seen the patch introducing per-device weights [1]?

[1] https://lkml.org/lkml/2019/8/5/83

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>> Thanks.
>>=20
>> --=20
>> tejun
>=20

