Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:45265 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbdJSGuU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2017 02:50:20 -0400
Received: by mail-wr0-f173.google.com with SMTP id k7so7187927wre.2
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2017 23:50:20 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: high overhead of functions blkg_*stats_* in bfq 
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <D6586934-DF02-4102-8839-8912DFA86BB0@linaro.org>
Date: Thu, 19 Oct 2017 08:50:17 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
        Luca Miccio <lucmiccio@gmail.com>, hpa@zytor.com,
        akinobu.mita@gmail.com, dhowells@redhat.com,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Message-Id: <A666837E-ADAB-433A-AFC7-71E59690C0E1@linaro.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org> <20171018131918.GB1302522@devbig577.frc2.facebook.com> <2B52CB68-213C-470F-945C-0ADFF9AA7A66@linaro.org> <28D623E2-B45B-4A38-91D3-9A64066892DD@linaro.org> <D6586934-DF02-4102-8839-8912DFA86BB0@linaro.org>
To: Tejun Heo <tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 19 ott 2017, alle ore 08:46, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
> ...
>>>=20
>>> blkgs are, but the blkg_stat objects passed to the blkg_*stat_*
>>> functions by bfq are not.  In particular, these objects are =
contained
>>> in bfq_group objects.

I talked partial nonsense here.  bfqg objects are in bfq, but a bfqg
may die only after the corresponding blkg has died.  So, if RCU
protection guarantees that the blkg is alive when stat-update
functions are invoked, then the RCU guarantees that bfqg is alive too.
Still, I'm scratching my head over your claim that there is such a
protection.

The blkg obtained through a blkg_lookup, in a rcu_read section, is
protected.  But, outside that section, a pointer to that blkg is not
guaranteed to be valid any longer.  Stat-update functions seem safe in
cfq and bfq, just because they are executed within locks that happen
to be taken also before destroying the blkg.  They are the
request_queue lock for cfq and the scheduler lock for bfq.  Thus, at
least the request_queue lock apparently needs to be taken around
stat-update functions in bfq, if they are moved outside the section
protected by the scheduler lock.

Thanks,
Paolo

>>>   Anyway, as I wrote, the cost of using the
>>> request_queue lock seems to be a loss of about 5% of the throughput.
>>> So, I guess that replacing this lock with RCU protection would
>>> probably reduce this loss to only 2% or 3%.  I wonder whether such a
>>> gain would be worth the additional conceptual complexity of RCU; at
>>> least untill the major problem, i.e,, the apparently high cost of =
stat
>>> update, is solved somehow.
>>>=20
>>> Thanks,
>>> Paolo
>>>=20
>>>> Thanks.
>>>>=20
>>>> --=20
>>>> tejun
>>>=20
>>> <bfq-tracing-cgroup.svg>
>>=20
>=20
