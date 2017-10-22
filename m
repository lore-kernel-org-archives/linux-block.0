Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:54657 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdJVIZi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Oct 2017 04:25:38 -0400
Received: by mail-wr0-f170.google.com with SMTP id o44so14539027wrf.11
        for <linux-block@vger.kernel.org>; Sun, 22 Oct 2017 01:25:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: high overhead of functions blkg_*stats_* in bfq 
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20171021161337.GP1302522@devbig577.frc2.facebook.com>
Date: Sun, 22 Oct 2017 10:25:33 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
        Luca Miccio <lucmiccio@gmail.com>, hpa@zytor.com,
        akinobu.mita@gmail.com, dhowells@redhat.com,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Message-Id: <D8A7AF83-8977-4842-9A3C-3285E87E479B@linaro.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org> <20171018131918.GB1302522@devbig577.frc2.facebook.com> <2B52CB68-213C-470F-945C-0ADFF9AA7A66@linaro.org> <28D623E2-B45B-4A38-91D3-9A64066892DD@linaro.org> <D6586934-DF02-4102-8839-8912DFA86BB0@linaro.org> <A666837E-ADAB-433A-AFC7-71E59690C0E1@linaro.org> <20171021161337.GP1302522@devbig577.frc2.facebook.com>
To: Tejun Heo <tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 21 ott 2017, alle ore 18:13, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20
> On Thu, Oct 19, 2017 at 08:50:17AM +0200, Paolo Valente wrote:
>> The blkg obtained through a blkg_lookup, in a rcu_read section, is
>> protected.  But, outside that section, a pointer to that blkg is not
>> guaranteed to be valid any longer.  Stat-update functions seem safe =
in
>=20
> blkg's destruction is rcu delayed.  If you have access to a blkg under
> rcu, it won't get freed until the rcu read lock is released.
>=20
>> cfq and bfq, just because they are executed within locks that happen
>> to be taken also before destroying the blkg.  They are the
>> request_queue lock for cfq and the scheduler lock for bfq.  Thus, at
>> least the request_queue lock apparently needs to be taken around
>> stat-update functions in bfq, if they are moved outside the section
>> protected by the scheduler lock.
>=20
> So, a blkg stays alive if the queue lock is held, or the cgroup and
> request_queue stays alive, and won't be freed (different from being
> alive) as long as RCU read lock is held.
>=20

Ok, then I have either to protect these stats-update functions with
the queue lock, or to extend somehow rcu protection to the bfq groups
referred by these functions.  According to our tests with different
processors, the gain of the latter solution is probably around 2 or 3%
of IOPS boost, with respect to using just the queue lock.  It would be
a little gain, against the current rather high overhead of the
functions to protect.  And it would cost additional code complexity.
So I'm oriented towards using just the queue lock.

Thank you very much for helping me with these doubts,
Paolo

> Thanks.
>=20
> --=20
> tejun
