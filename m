Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f172.google.com ([209.85.210.172]:34962 "EHLO
        mail-wj0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968301AbdAHQ5T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2017 11:57:19 -0500
Received: by mail-wj0-f172.google.com with SMTP id i20so56238430wjn.2
        for <linux-block@vger.kernel.org>; Sun, 08 Jan 2017 08:57:14 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [LSF/MM ATTEND AND AGENDA TOPIC] request to attend the summit
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1483893030.6744.1.camel@sandisk.com>
Date: Sun, 8 Jan 2017 17:56:57 +0100
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "broonie@linaro.org" <broonie@linaro.org>
Message-Id: <4B59AFC4-2638-416B-88E6-255A2D3DCB54@linaro.org>
References: <771BC555-46A4-4AE1-BDD5-BFB4E3F065F0@linaro.org> <1483431417.2911.1.camel@sandisk.com> <C805E81A-2266-4E8D-A8BD-8023165A27FC@linaro.org> <1483893030.6744.1.camel@sandisk.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 08 gen 2017, alle ore 17:30, Bart Van Assche =
<Bart.VanAssche@sandisk.com> ha scritto:
>=20
> On Tue, 2017-01-03 at 10:39 +0100, Paolo Valente wrote:
>>> Il giorno 03 gen 2017, alle ore 09:17, Bart Van Assche <Bart.VanAss
>>> che@sandisk.com> ha scritto:
>>>=20
>>> * Since BFQ has been designed for hard disks and since the approach
>>> in BFQ for handling deceptive idleness reduces bandwidth, what
>>> scheduling algorithm to use for storage media that do not have any
>>> moving parts (SSDs and MMC).
>>=20
>> I would really like to have the opportunity to debunk this false
>> myth. BFQ is optimized for rotational as well as non-rotational
>> device. BFQ does not keep up only if IOPS go beyond ~50k.  And I'm
>> already working on this limitation, but, as agreed with Jens, the
>> priority for the moment is pushing BFQ as it is.
>=20
> Hello Paolo,
>=20
> A quote from the section "Service Properties" from a paper from 2010
> about BFQ: "In this section we report the service properties of BFQ, =
in
> both sector (bandwidth distribution) and time domains. [ ... ] As a
> consequence, one would set Twait as high as possible to include as =
many
> applications as possible. However, the value of Twait has an important
> impact on the disk throughput. It may provide significant boosting in
> presence of deceptive idleness, but only if its value is in the order
> of the seek and rotational latencies [1], namely a few milliseconds. =
In
> contrast, higher values may cause progressive performance degradation,
> as the disk may be left idle for too long."
>=20
> Did I understand correctly that BFQ uses disk idling to improve
> sequential I/O throughput for hard disks?

Definitely.

> If so, my question is why you
> think that disk idling will not reduce throughput for SSDs since disk
> idling keeps the queue depth low while SSDs perform best for workloads
> with a high queue depth?
>=20

Because BFQ disables idling for non-rotational devices, especially if
NCQ-capable.  More precisely, on non-rotations devices, BFQ does not
idle to boost throughput, because idling would yield the opposite
result.  Unfortunately, this is one of the small improvements that I
had not the occasion to describe in any paper.  However, you can find
a detailed description of this improvement, in,.e.g., the commit
message for the patch that makes this change within the last BFQ patch
series I have submitted (October 26).  I have pasted this message
below for your convenience.

Thanks,
Paolo

block, bfq: boost the throughput on NCQ-capable flash-based devices

This patch boosts the throughput on NCQ-capable flash-based devices,
while still preserving latency guarantees for interactive and soft
real-time applications. The throughput is boosted by just not idling
the device when the in-service queue remains empty, even if the queue
is sync and has a non-null idle window. This helps to keep the drive's
internal queue full, which is necessary to achieve maximum
performance. This solution to boost the throughput is a port of
commits a68bbdd and f7d7b7a for CFQ.

As already highlighted in a previous patch, allowing the device to
prefetch and internally reorder requests trivially causes loss of
control on the request service order, and hence on service guarantees.
Fortunately, as discussed in detail in the comments on the function
bfq_bfqq_may_idle(), if every process has to receive the same
fraction of the throughput, then the service order enforced by the
internal scheduler of a flash-based device is relatively close to that
enforced by BFQ. In particular, it is close enough to let service
guarantees be substantially preserved.

Things change in an asymmetric scenario, i.e., if not every process
has to receive the same fraction of the throughput. In this case, to
guarantee the desired throughput distribution, the device must be
prevented from prefetching requests. This is exactly what this patch
does in asymmetric scenarios.


> Thanks,
>=20
> Bart.

