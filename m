Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:50283 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbdJRPJB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2017 11:09:01 -0400
Received: by mail-wr0-f175.google.com with SMTP id q42so5385239wrb.7
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2017 08:09:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: high overhead of functions blkg_*stats_* in bfq 
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <2B52CB68-213C-470F-945C-0ADFF9AA7A66@linaro.org>
Date: Wed, 18 Oct 2017 17:08:57 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
        Luca Miccio <lucmiccio@gmail.com>, hpa@zytor.com,
        akinobu.mita@gmail.com, dhowells@redhat.com,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Message-Id: <28D623E2-B45B-4A38-91D3-9A64066892DD@linaro.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org> <20171018131918.GB1302522@devbig577.frc2.facebook.com> <2B52CB68-213C-470F-945C-0ADFF9AA7A66@linaro.org>
To: Tejun Heo <tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Adding again Ulf, Linus and all the others, because Tejun replied to my =
initial email, which did not include them yet as recipients.

> Il giorno 18 ott 2017, alle ore 17:02, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>>=20
>> Il giorno 18 ott 2017, alle ore 15:19, Tejun Heo <tj@kernel.org> ha =
scritto:
>>=20
>> Hello, Paolo.
>>=20
>> On Tue, Oct 17, 2017 at 12:11:01PM +0200, Paolo Valente wrote:
>> ...
>>> protected by a per-device scheduler lock.  To give you an idea, on =
an
>>> Intel i7-4850HQ, and with 8 threads doing random I/O in parallel on
>>> null_blk (configured with 0 latency), if the update of groups stats =
is
>>> removed, then the throughput grows from 260 to 404 KIOPS.  This and
>>> all the other results we might share in this thread can be =
reproduced
>>> very easily with a (useful) script made by Luca Miccio [1].
>>=20
>> I don't think the old request_queue is ever built for multiple CPUs
>> hitting on a mem-backed device.
>>=20
>>> We tried to understand the reason for this high overhead, and, in
>>> particular, to find out whether whether there was some issue that we
>>> could address on our own.  But the causes seem somehow substantial:
>>> one of the most time-consuming operations needed by some =
blkg_*stats_*
>>> functions is, e.g., find_next_bit, for which we don't see any =
trivial
>>> replacement.
>>=20
>> Can you point to the specific ones?  I can't find find_next_bit =
usages
>> in generic blkg code.
>>=20
>=20
> Yes, sorry for being too generic in the first place (fear to write too
> much).
>=20
> I have attached a flame graph (made by Luca), showing all involved
> functions.  Look, e.g., for the blkg_*stat_* functions invoked
> indirectly by bfq_dispatch_request, inside any of the worker
> processes.  As I already wrote, find_next_bit seems to be only part of
> the cost of these functions (although an important part).
>=20
> You can obtain/reproduce the information in the flame graph (on a 8
> logical-core cpu), by invoking
>=20
> perf record -g -a =E2=80=94callgraph dwarf -F 999
>=20
> and, in parallel,
>=20
> sudo ./IO_sched-speedtest.sh 20 8 bfq randread
>=20
> where IO_sched-speedtest.sh is the script I mentioned in my previous
> email [1]
>=20
> [1] https://github.com/Algodev-github/IOSpeed
>=20
>>> So, as a first attempt to reduce this severe slowdown, we have made =
a
>>> patch that moves the invocation of blkg_*stats_* functions outside =
the
>>> critical sections protected by the bfq lock.  Still, these functions
>>> apparently need to be protected with the request_queue lock, because
>>=20
>> blkgs are already protected with RCU, so RCU protection should be
>> enough.
>>=20
>=20
> blkgs are, but the blkg_stat objects passed to the blkg_*stat_*
> functions by bfq are not.  In particular, these objects are contained
> in bfq_group objects.  Anyway, as I wrote, the cost of using the
> request_queue lock seems to be a loss of about 5% of the throughput.
> So, I guess that replacing this lock with RCU protection would
> probably reduce this loss to only 2% or 3%.  I wonder whether such a
> gain would be worth the additional conceptual complexity of RCU; at
> least untill the major problem, i.e,, the apparently high cost of stat
> update, is solved somehow.
>=20
> Thanks,
> Paolo
>=20
>> Thanks.
>>=20
>> --=20
>> tejun
>=20
> <bfq-tracing-cgroup.svg>
