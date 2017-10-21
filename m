Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:48018 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932147AbdJUQNl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Oct 2017 12:13:41 -0400
Received: by mail-qk0-f175.google.com with SMTP id m189so17570765qke.4
        for <linux-block@vger.kernel.org>; Sat, 21 Oct 2017 09:13:41 -0700 (PDT)
Date: Sat, 21 Oct 2017 09:13:37 -0700
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        Luca Miccio <lucmiccio@gmail.com>, hpa@zytor.com,
        akinobu.mita@gmail.com, dhowells@redhat.com,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
Message-ID: <20171021161337.GP1302522@devbig577.frc2.facebook.com>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org>
 <20171018131918.GB1302522@devbig577.frc2.facebook.com>
 <2B52CB68-213C-470F-945C-0ADFF9AA7A66@linaro.org>
 <28D623E2-B45B-4A38-91D3-9A64066892DD@linaro.org>
 <D6586934-DF02-4102-8839-8912DFA86BB0@linaro.org>
 <A666837E-ADAB-433A-AFC7-71E59690C0E1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A666837E-ADAB-433A-AFC7-71E59690C0E1@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Paolo.

On Thu, Oct 19, 2017 at 08:50:17AM +0200, Paolo Valente wrote:
> The blkg obtained through a blkg_lookup, in a rcu_read section, is
> protected.  But, outside that section, a pointer to that blkg is not
> guaranteed to be valid any longer.  Stat-update functions seem safe in

blkg's destruction is rcu delayed.  If you have access to a blkg under
rcu, it won't get freed until the rcu read lock is released.

> cfq and bfq, just because they are executed within locks that happen
> to be taken also before destroying the blkg.  They are the
> request_queue lock for cfq and the scheduler lock for bfq.  Thus, at
> least the request_queue lock apparently needs to be taken around
> stat-update functions in bfq, if they are moved outside the section
> protected by the scheduler lock.

So, a blkg stays alive if the queue lock is held, or the cgroup and
request_queue stays alive, and won't be freed (different from being
alive) as long as RCU read lock is held.

Thanks.

-- 
tejun
