Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA11C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 10:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9984235F9
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 10:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbhAVKN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 05:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbhAVKKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 05:10:37 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7754DC0613D6
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 02:09:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id bx12so5866422edb.8
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 02:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rxps84K060dLRA1prw6kyh1V/Q5jjcU2iVlPCK5Im2E=;
        b=XB4tr4g84F5wjdpRmJ7s0RBeTwtYPUhpRQfEmYhZ88VJOF2vSw8LabuEN2yTMUom1c
         D3eoLjJZmTdO0rvTydYO4Eg106XKX5riUYsgfXIoYVibdlU7k6yUdIfE5DM8MTfXzGzg
         QFOOckJSmXpw60q8UVEbtoRW71AYsoq1tqBqzkDhserfBvxQFe7JZxIYvRXk1dNasHnB
         dBDlF+UUI14JOoZgFYWf2muwkIDsNaje5vyZcqcCbEs9EA9+SiSLI7QnDHdkVVGxaxDH
         HuDDP2cwLijRG1gKXEs8NsD2AHfH3qQU7aBtlMz64CsEiTXpdr9X59eY+A/uP78aSIbK
         iy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rxps84K060dLRA1prw6kyh1V/Q5jjcU2iVlPCK5Im2E=;
        b=V3Xxdvlsi/MbbRWHdZ6yKef5nWcWCwppAjsKdo0Fgc82YhXU9bJqv1uG7OmPUZgK/X
         Oy7YOqe2pboBAdvIPmNHIJVYzmYj6paxeEClCsXkCOi70C7F2VSSZR5dHjB9AGcOxxG9
         y6Dk7r5UdGrnaxzmTKMg9Dn0uogUAza1jRECm8bNZsXSLFlO3xah49dhXnNbmI4Enmnn
         t+pVJAgW1NBBeUvTZgxH7PNaQgcVFu3rlO2rbrjs3JxhkWRhycNw7FhJ54EqpKnVOksJ
         VDvyIqvgJJr/WFuNafk5B5pKZ1VEJyhCoLrC6aIaG+H9bCIWKk7T62bX0ZCOpclAHwDT
         vpcQ==
X-Gm-Message-State: AOAM5322WH3ZL+dPSqLZPgE7wBBlVohf3BlFT69VlAfg3CX7z3Q1POJD
        Nt7+4NtyYNBCBEyx96ds7Zbzug==
X-Google-Smtp-Source: ABdhPJyzLlhkix5AgSecCEcFwYXP8sADlkAjp5zNPZEfy6zI7CnL5SrNPToxJQJdEGSjIvvRNYCYmw==
X-Received: by 2002:aa7:d1d4:: with SMTP id g20mr2632593edp.244.1611310183120;
        Fri, 22 Jan 2021 02:09:43 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id r22sm4963970edp.9.2021.01.22.02.09.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 02:09:42 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: question about relative control for sync io using bfq
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
Date:   Fri, 22 Jan 2021 11:09:40 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        hch@lst.de, linux-block@vger.kernel.org,
        chenzhou <chenzhou10@huawei.com>,
        "houtao (A)" <houtao1@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E41BC22-33EA-4D0F-9EBD-3AB0824E3F2E@linaro.org>
References: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 11 gen 2021, alle ore 14:15, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> Hi,
>=20
> We found a performance problem:
>=20
> kernel version: 5.10
> disk: ssd
> scheduler: bfq
> arch: arm64 / x86_64
> test param: direct=3D1, ioengine=3Dpsync, bs=3D4k, rw=3Drandread, =
numjobs=3D32
>=20
> We are using 32 threads here, test results showed that iops is equal
> to single thread.
>=20
> After digging into the problem, I found root cause of the problem is =
strange:
>=20
> bfq_add_request
> bfq_bfqq_handle_idle_busy_switch
>  bfq_add_bfqq_busy
>   bfq_activate_bfq
>    bfq_activate_requeue_entity
>     __bfq_activate_requeue_entity
>      __bfq_activate_entity
>       if (!bfq_entity_to_bfqq(entity))
>        if (!entity->in_groups_with_pending_reqs)
>         entity->in_groups_with_pending_reqs =3D true;
>         bfqd->num_groups_with_pending_reqs++
>=20
> If test process is not in root cgroup, num_groups_with_pending_reqs =
will
> be increased after request was instered to bfq.
>=20
> bfq_select_queue
> bfq_better_to_idle
>  idling_needed_for_service_guarantees
>   bfq_asymmetric_scenario
>    return varied_queue_weights || multiple_classes_busy || =
bfqd->num_groups_with_pending_reqs > 0
>=20
> After issuing IO to driver, num_groups_with_pending_reqs is ensured to
> be nonzero, thus bfq won't expire the queue. This is the root cause of
> degradating to single-process performance.
>=20
> One the other hand, if I set slice_idle to zero, bfq_better_to_idle =
will
> return false early, and the problem will disapear. However, relative
> control will be inactive.
>=20
> My question is that, is this a known flaw for bfq? If not, as cfq =
don't
> have such problem, is there a suitable solution?
>=20

Hi,
this is a core problem, not of BFQ but of any possible solution that
has to provide bandwidth isolation with sync I/O.  One of the examples
is the one I made for you in my other email.  At any rate, the problem
that you report seems to occur with just one group.  We may think of
simply changing my condition

bfqd->num_groups_with_pending_reqs > 0

to

bfqd->num_groups_with_pending_reqs > 1

If this simple solution does solve the problem you report, then I
could run my batch of tests to check whether it causes some
regression.

What do you think?

Thanks.
Paolo


> Thanks!
> Yu Kuai
> such problem,

