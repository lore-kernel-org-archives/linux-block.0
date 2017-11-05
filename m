Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:48370 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdKEHj7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Nov 2017 02:39:59 -0500
Received: by mail-wm0-f43.google.com with SMTP id p75so8224861wmg.3
        for <linux-block@vger.kernel.org>; Sun, 05 Nov 2017 00:39:59 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: high overhead of functions blkg_*stats_* in bfq 
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20171018131918.GB1302522@devbig577.frc2.facebook.com>
Date: Sun, 5 Nov 2017 08:39:55 +0100
Cc: linux-block <linux-block@vger.kernel.org>,
        Luca Miccio <lucmiccio@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Message-Id: <76CAD24C-BE7A-4AE0-A207-0FDD0E6506DD@linaro.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org> <20171018131918.GB1302522@devbig577.frc2.facebook.com>
To: Tejun Heo <tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 18 ott 2017, alle ore 15:19, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20
> On Tue, Oct 17, 2017 at 12:11:01PM +0200, Paolo Valente wrote:
> ...
>> protected by a per-device scheduler lock.  To give you an idea, on an
>> Intel i7-4850HQ, and with 8 threads doing random I/O in parallel on
>> null_blk (configured with 0 latency), if the update of groups stats =
is
>> removed, then the throughput grows from 260 to 404 KIOPS.  This and
>> all the other results we might share in this thread can be reproduced
>> very easily with a (useful) script made by Luca Miccio [1].
>=20
> I don't think the old request_queue is ever built for multiple CPUs
> hitting on a mem-backed device.
>=20

Hi,
from our measurements, the code and the comments received so far in
this thread, I guess that reducing the execution time of blkg_*stats_*
functions is not an easy task, and is unlikely to be accomplished in
the short term.  In this respect, we have unfortunately found out that
executing these functions causes a very high reduction of the
sustainable throughput on some CPUs.  For example, -70% on an ARM
CortexTM-A53 Octa-core.

Thus, to deal with such a considerable slowdown, until the overhead of
these functions gets reduced, it may make more sense to switch the
update of these statistics off, in all cases where these statistics
are not used, while higher performance (or lower power consumption) is
welcome/needed.

We wondered, however, how hazardous it might be to switch the update
of these statistics off.  To answer this question, we investigated the
extent at which these statistics are used by applications and
services.  Mainly, we tried to survey relevant people or
forums/mailing lists for involved communities: Linux distributions,
systemd, containers and other minor communities.  Nobody reported any
application or service using these statistics (either the variant
updated by bfq, or that updated by cfq).

So, one of the patches we are working on gives the user the
possibility to disable the update of these statistics online.

Thanks,
Paolo

>> We tried to understand the reason for this high overhead, and, in
>> particular, to find out whether whether there was some issue that we
>> could address on our own.  But the causes seem somehow substantial:
>> one of the most time-consuming operations needed by some =
blkg_*stats_*
>> functions is, e.g., find_next_bit, for which we don't see any trivial
>> replacement.
>=20
> Can you point to the specific ones?  I can't find find_next_bit usages
> in generic blkg code.
>=20
>> So, as a first attempt to reduce this severe slowdown, we have made a
>> patch that moves the invocation of blkg_*stats_* functions outside =
the
>> critical sections protected by the bfq lock.  Still, these functions
>> apparently need to be protected with the request_queue lock, because
>=20
> blkgs are already protected with RCU, so RCU protection should be
> enough.
>=20
> Thanks.
>=20
> --=20
> tejun
