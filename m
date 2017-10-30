Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932404AbdJ3JtJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2017 05:49:09 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20171021161337.GP1302522@devbig577.frc2.facebook.com>
References: <20171021161337.GP1302522@devbig577.frc2.facebook.com> <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org> <20171018131918.GB1302522@devbig577.frc2.facebook.com> <2B52CB68-213C-470F-945C-0ADFF9AA7A66@linaro.org> <28D623E2-B45B-4A38-91D3-9A64066892DD@linaro.org> <D6586934-DF02-4102-8839-8912DFA86BB0@linaro.org> <A666837E-ADAB-433A-AFC7-71E59690C0E1@linaro.org>
To: Tejun Heo <tj@kernel.org>
Cc: dhowells@redhat.com, Paolo Valente <paolo.valente@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Luca Miccio <lucmiccio@gmail.com>, hpa@zytor.com,
        akinobu.mita@gmail.com, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 30 Oct 2017 09:49:06 +0000
Message-ID: <19792.1509356946@warthog.procyon.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tejun Heo <tj@kernel.org> wrote:

> > The blkg obtained through a blkg_lookup, in a rcu_read section, is
> > protected.  But, outside that section, a pointer to that blkg is not
> > guaranteed to be valid any longer.  Stat-update functions seem safe in
> 
> blkg's destruction is rcu delayed.  If you have access to a blkg under
> rcu, it won't get freed until the rcu read lock is released.

You also have to remember that if you take the RCU read lock just for this,
there is potentially a cost to be paid later as you may cause extra grace
period handling.

David
