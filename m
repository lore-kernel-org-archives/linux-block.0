Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEA9C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188426109D
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhJYIAi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhJYIAh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 04:00:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99853C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 00:58:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w15so7531302wra.3
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a6fR8q6eNfsmjxHH24h5OIsBTG+JgcE11ntIofTu6IQ=;
        b=utU5vIGSYsxzcD4eKbs4vpBA4Z5LRhftVp6KwpgL60LTcvoH2hC6VNg695fbLY55/c
         UpLWV/WKi/7g9caVWIgU6ZfEfUVjDA82qcqR54c/ftAbfwb43+dELA0WtPaVb17YgKuz
         e6PJ59L/cS6XJ6S81PwDvt19CLSBfPsKJztGGT73OzC6aBYgymuWBoD3t9fc+xf3rM3a
         9FONwNxy6Na8vzp/6dnPkgqJWxCeqMokbYKqvAVtPlPjmZLA8/oYNIFyH6KrfHpj+oYu
         8mTZtGiZYY9nT/rFsVMWaqy9z/cYacQrlD3fd36gQnEDoPcZNMtqli/PbxoyKxBM9zSn
         cxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a6fR8q6eNfsmjxHH24h5OIsBTG+JgcE11ntIofTu6IQ=;
        b=foo+T3kzKKArOVeKSM3/9ECjbux0vI9uSkOV/dBbAQS5AuxLJN8sVgHAJKgBsdVTcZ
         zDpsowM/2xVeXnRAQwhSN0cKy0rrrwgGq6qP8+At460a7oOGhi0+vs/RNZYvBeeQf79G
         63JlPlNkClV/Kl8DSD8FkDvZ3/n9oSbB22vjixyvCn2pUG3COnavPEqDGdCjHOcP67rL
         BeqBwUUT21e5F4bmqRPyG2lz8eFTPe/ia5kvgW6MwJDNWurK7Auqopb3EmLYOKPuDk9K
         DNLiTK7o6vOOSyKgSu7Pt//3pcf/AiP4rptpjrv+RySvOIQGNLsuW8uqs9f63BuyShwQ
         foeQ==
X-Gm-Message-State: AOAM532g5MjFML2sdQCH+XEccuTXvE3MiVMS2+8UubtVNBcpb8axFusQ
        uEIYJ7ifUG8WJHq7bRO+fLc4BQ==
X-Google-Smtp-Source: ABdhPJwiYLYqnn0HU8rlXS4l+sODBtyCNA29X206eiSraXmGN2KIHh46nsoSdORsJhvLwh+b+Yafgw==
X-Received: by 2002:a5d:438b:: with SMTP id i11mr6502916wrq.188.1635148693938;
        Mon, 25 Oct 2021 00:58:13 -0700 (PDT)
Received: from [192.168.17.250] (elgamal.mat.unimo.it. [155.185.5.192])
        by smtp.gmail.com with ESMTPSA id z135sm20589672wmc.45.2021.10.25.00.58.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 00:58:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/8 v3] bfq: Limit number of allocated scheduler tags per
 cgroup
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <D76F0193-9573-44B9-A401-97D2A0DB846B@linaro.org>
Date:   Mon, 25 Oct 2021 09:58:11 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        237826@studenti.unimore.it, 224833@studenti.unimore.it,
        Giacomo Guiduzzi <224804@studenti.unimore.it>,
        238290@studenti.unimore.it,
        PAOLO CROTTI <204572@studenti.unimore.it>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7CBAECF-A7F3-4AA0-8F10-D7EC267AD4BE@linaro.org>
References: <20211006164110.10817-1-jack@suse.cz>
 <D76F0193-9573-44B9-A401-97D2A0DB846B@linaro.org>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 7 ott 2021, alle ore 18:33, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 6 ott 2021, alle ore 19:31, Jan Kara <jack@suse.cz> ha =
scritto:
>>=20
>> Hello!
>>=20
>> Here is the third revision of my patches to fix how bfq weights apply =
on cgroup
>> throughput and on throughput of processes with different IO =
priorities. Since
>> v2 I've added some more patches so that now IO priorities also result =
in
>> service differentiation (previously they had no effect on service
>> differentiation on some workloads similarly to cgroup weights). The =
last patch
>> in the series still needs some work as in the current state it causes =
a
>> notable regression (~20-30%) with dbench benchmark for large numbers =
of
>> clients. I've verified that the last patch is indeed necessary for =
the service
>> differentiation with the workload described in its changelog. As we =
discussed
>> with Paolo, I have also found out that if I remove the "waker has =
enough
>> budget" condition from bfq_select_queue(), dbench performance is =
restored
>> and the service differentiation is still good. But we probably need =
some
>> justification or cleaner solution than just removing the condition so =
that
>> is still up to discussion. But first seven patches already noticeably =
improve
>> the situation for lots of workloads so IMO they stand on their own =
and
>> can be merged regardless of how we go about the last patch.
>>=20
>=20
> Hi Jan,
> I have just one more (easy-to-resolve) doubt: you seem to have tested
> these patches mostly on the throughput side.  Did you run a
> startup-latency test as well?  I can run some for you, if you prefer
> so. Just give me a few days.
>=20

We are finally testing your patches a little bit right now, for
regressions with our typical benchmarks ...

Paolo

> When that is cleared, your first seven patches are ok for me.
> Actually I think they are a very good and relevant contribution.
> Patch number eight probably deserve some ore analysis, as you pointed
> out.  As I already told you in our call, we can look at that budget
> condition together.  And figure out the best tests to use, to check
> whether I/O control does not get lost too much.
>=20
> Thanks,
> Paolo
>=20
>> Changes since v2:
>> * Rebased on top of current Linus' tree
>> * Updated computation of scheduler tag proportions to work correctly =
even
>> for processes within the same cgroup but with different IO priorities
>> * Added comment roughly explaining why we limit tag depth
>> * Added patch limiting waker / wakee detection in time so avoid at =
least the
>> most obvious false positives
>> * Added patch to log waker / wakee detections in blktrace for better =
debugging
>> * Added patch properly account injected IO
>>=20
>> Changes since v1:
>> * Fixed computation of appropriate proportion of scheduler tags for a =
cgroup
>> to work with deeper cgroup hierarchies.
>>=20
>> Original cover letter:
>>=20
>> I was looking into why cgroup weights do not have any measurable =
impact on
>> writeback throughput from different cgroups. This actually a =
regression from
>> CFQ where things work more or less OK and weights have roughly the =
impact they
>> should. The problem can be reproduced e.g. by running the following =
easy fio
>> job in two cgroups with different weight:
>>=20
>> [writer]
>> directory=3D/mnt/repro/
>> numjobs=3D1
>> rw=3Dwrite
>> size=3D8g
>> time_based
>> runtime=3D30
>> ramp_time=3D10
>> blocksize=3D1m
>> direct=3D0
>> ioengine=3Dsync
>>=20
>> I can observe there's no significat difference in the amount of data =
written
>> from different cgroups despite their weights are in say 1:3 ratio.
>>=20
>> After some debugging I've understood the dynamics of the system. =
There are two
>> issues:
>>=20
>> 1) The amount of scheduler tags needs to be significantly larger than =
the
>> amount of device tags. Otherwise there are not enough requests =
waiting in BFQ
>> to be dispatched to the device and thus there's nothing to schedule =
on.
>>=20
>> 2) Even with enough scheduler tags, writers from two cgroups =
eventually start
>> contending on scheduler tag allocation. These are served on first =
come first
>> served basis so writers from both cgroups feed requests into bfq with
>> approximately the same speed. Since bfq prefers IO from heavier =
cgroup, that is
>> submitted and completed faster and eventually we end up in a =
situation when
>> there's no IO from the heavier cgroup in bfq and all scheduler tags =
are
>> consumed by requests from the lighter cgroup. At that point bfq just =
dispatches
>> lots of the IO from the lighter cgroup since there's no contender for =
disk
>> throughput. As a result observed throughput for both cgroups are the =
same.
>>=20
>> This series fixes this problem by accounting how many scheduler tags =
are
>> allocated for each cgroup and if a cgroup has more tags allocated =
than its
>> fair share (based on weights) in its service tree, we heavily limit =
scheduler
>> tag bitmap depth for it so that it is not be able to starve other =
cgroups from
>> scheduler tags.
>>=20
>> What do people think about this?
>>=20
>> 								Honza
>>=20
>> Previous versions:
>> Link: http://lore.kernel.org/r/20210712171146.12231-1-jack@suse.cz # =
v1
>> Link: http://lore.kernel.org/r/20210715132047.20874-1-jack@suse.cz # =
v2

