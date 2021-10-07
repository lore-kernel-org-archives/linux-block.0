Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CD8C433FE
	for <linux-block@archiver.kernel.org>; Thu,  7 Oct 2021 16:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24EC610A1
	for <linux-block@archiver.kernel.org>; Thu,  7 Oct 2021 16:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbhJGQfI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhJGQfI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Oct 2021 12:35:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727F4C061570
        for <linux-block@vger.kernel.org>; Thu,  7 Oct 2021 09:33:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p13so25812597edw.0
        for <linux-block@vger.kernel.org>; Thu, 07 Oct 2021 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PTrXZnFTpc5ESHoG8Mhfrbra+Ig4A8KVtrdqDpNzY+Y=;
        b=iRWXQyZrXfp1lVYG3jb+M5kXJmJx8RtsE6pkcGYLPtVLuw6CQ6Z8D83i3YANAk3XFp
         1GJnQwshop2vIsKbRm8608ZAGw0gEkHDM+5O3WoDxbmAHFrBiSLNQNz75pmYjLOcHHcj
         tUO/waZbVaPXfjJwAtWE/qknxz4oh4jc2QDMcgVqly1k1MztnyWgKK4HV52iioUSLMK/
         qDD5JXUTSeClzirn+Bau28g64SsqFxUm07mq6xK4n580GsxKcRSddhrHuzFZPBUgP9Uj
         QLLkqzLUBAtw2/MNLZ9bt+yxBUVtlV4XvnkzowCQtgccSs3mEqi5V/mvQU7wM18MzD/G
         uSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PTrXZnFTpc5ESHoG8Mhfrbra+Ig4A8KVtrdqDpNzY+Y=;
        b=SCbQVVgPzI6M/2Zjx4w7daMtya5ZZzXlGHsh5+hfcBee2vZQspvo1Y/OKLRdfZYVUf
         U2U3dnvVjok6ChSlHxVis78GBxPAiL9MfuG58m3IMYWWH88Yw1zKc/TavPjsVjyRgJCY
         A1Q1NLJYA/xAXU1Go8noxUVJvyjaazmz49i7CH2z2pSHEFNCzt/oIl4khaAxazwejZ9v
         0nTXS7Phv7PVSCfwAXPWpZnJlVBE2ph8kFOpFllggDzt4cI4mdqR1nXG7Q8GVAfuUb9P
         hX87zTYdhkuIQT8aDRm6LgFkMut+K8Wee2HMweou45JOSTb4BybSZwTgZ/MY8PexUqTr
         coCQ==
X-Gm-Message-State: AOAM532R9pPoH7UCkYOkvOpnr7BKU2fC03n4eUcjvSf2fcI4AlRbdjYI
        CLVSNFrk227dbJZ81Dex25iWnQ==
X-Google-Smtp-Source: ABdhPJx7jyvgS36+U/B2biqN3pVtrkeul4yixfSkm4jh0tvmI7gKd60o56NPrKLrpM3IpHLVU/10MQ==
X-Received: by 2002:a17:907:2658:: with SMTP id ar24mr6810509ejc.405.1633624392952;
        Thu, 07 Oct 2021 09:33:12 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id b2sm14571edv.73.2021.10.07.09.33.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 09:33:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/8 v3] bfq: Limit number of allocated scheduler tags per
 cgroup
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211006164110.10817-1-jack@suse.cz>
Date:   Thu, 7 Oct 2021 18:33:10 +0200
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D76F0193-9573-44B9-A401-97D2A0DB846B@linaro.org>
References: <20211006164110.10817-1-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 6 ott 2021, alle ore 19:31, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Hello!
>=20
> Here is the third revision of my patches to fix how bfq weights apply =
on cgroup
> throughput and on throughput of processes with different IO =
priorities. Since
> v2 I've added some more patches so that now IO priorities also result =
in
> service differentiation (previously they had no effect on service
> differentiation on some workloads similarly to cgroup weights). The =
last patch
> in the series still needs some work as in the current state it causes =
a
> notable regression (~20-30%) with dbench benchmark for large numbers =
of
> clients. I've verified that the last patch is indeed necessary for the =
service
> differentiation with the workload described in its changelog. As we =
discussed
> with Paolo, I have also found out that if I remove the "waker has =
enough
> budget" condition from bfq_select_queue(), dbench performance is =
restored
> and the service differentiation is still good. But we probably need =
some
> justification or cleaner solution than just removing the condition so =
that
> is still up to discussion. But first seven patches already noticeably =
improve
> the situation for lots of workloads so IMO they stand on their own and
> can be merged regardless of how we go about the last patch.
>=20

Hi Jan,
I have just one more (easy-to-resolve) doubt: you seem to have tested
these patches mostly on the throughput side.  Did you run a
startup-latency test as well?  I can run some for you, if you prefer
so. Just give me a few days.

When that is cleared, your first seven patches are ok for me.
Actually I think they are a very good and relevant contribution.
Patch number eight probably deserve some ore analysis, as you pointed
out.  As I already told you in our call, we can look at that budget
condition together.  And figure out the best tests to use, to check
whether I/O control does not get lost too much.

Thanks,
Paolo

> Changes since v2:
> * Rebased on top of current Linus' tree
> * Updated computation of scheduler tag proportions to work correctly =
even
>  for processes within the same cgroup but with different IO priorities
> * Added comment roughly explaining why we limit tag depth
> * Added patch limiting waker / wakee detection in time so avoid at =
least the
>  most obvious false positives
> * Added patch to log waker / wakee detections in blktrace for better =
debugging
> * Added patch properly account injected IO
>=20
> Changes since v1:
> * Fixed computation of appropriate proportion of scheduler tags for a =
cgroup
>  to work with deeper cgroup hierarchies.
>=20
> Original cover letter:
>=20
> I was looking into why cgroup weights do not have any measurable =
impact on
> writeback throughput from different cgroups. This actually a =
regression from
> CFQ where things work more or less OK and weights have roughly the =
impact they
> should. The problem can be reproduced e.g. by running the following =
easy fio
> job in two cgroups with different weight:
>=20
> [writer]
> directory=3D/mnt/repro/
> numjobs=3D1
> rw=3Dwrite
> size=3D8g
> time_based
> runtime=3D30
> ramp_time=3D10
> blocksize=3D1m
> direct=3D0
> ioengine=3Dsync
>=20
> I can observe there's no significat difference in the amount of data =
written
> from different cgroups despite their weights are in say 1:3 ratio.
>=20
> After some debugging I've understood the dynamics of the system. There =
are two
> issues:
>=20
> 1) The amount of scheduler tags needs to be significantly larger than =
the
> amount of device tags. Otherwise there are not enough requests waiting =
in BFQ
> to be dispatched to the device and thus there's nothing to schedule =
on.
>=20
> 2) Even with enough scheduler tags, writers from two cgroups =
eventually start
> contending on scheduler tag allocation. These are served on first come =
first
> served basis so writers from both cgroups feed requests into bfq with
> approximately the same speed. Since bfq prefers IO from heavier =
cgroup, that is
> submitted and completed faster and eventually we end up in a situation =
when
> there's no IO from the heavier cgroup in bfq and all scheduler tags =
are
> consumed by requests from the lighter cgroup. At that point bfq just =
dispatches
> lots of the IO from the lighter cgroup since there's no contender for =
disk
> throughput. As a result observed throughput for both cgroups are the =
same.
>=20
> This series fixes this problem by accounting how many scheduler tags =
are
> allocated for each cgroup and if a cgroup has more tags allocated than =
its
> fair share (based on weights) in its service tree, we heavily limit =
scheduler
> tag bitmap depth for it so that it is not be able to starve other =
cgroups from
> scheduler tags.
>=20
> What do people think about this?
>=20
> 								Honza
>=20
> Previous versions:
> Link: http://lore.kernel.org/r/20210712171146.12231-1-jack@suse.cz # =
v1
> Link: http://lore.kernel.org/r/20210715132047.20874-1-jack@suse.cz # =
v2

