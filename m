Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588E3C31E44
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 12:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3633621537
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 12:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfFNMRs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:17:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45573 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfFNMRs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 08:17:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id a14so3164983edv.12
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 05:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+8quq0k8tqu/xsODhVIPdEOM4T34ZCS4DIB0amj5ChA=;
        b=es3MiZ0wLUnNCv7xtTBog1vPRurS5YFGSc4mPbhEFZPMoOC1WlXrMlYp+BlClKCNq5
         M3dGiItoPzEXmM2mGLKwKa++7japNaPPz5FRiCW8X1Uscs1U15zItwbSFlEKqWj2a0ou
         BJGDJcC2eiI8/ZVFt3nUpgtk2AP5Tbvsy62yZDJos6S94ejaRnti47qxZDtSeRvl+4Ni
         DcpTyC/Z2BumyNCWgn3+TlTL3zGbDNDmPZYYiVyRDTCHB6YhABAVHo1vHoZrXsboy96r
         wzJX3Stlafr5+CYTmKOO0hUe0Q+8BMsnvKAHIgT49MFHsEWzm/tfxQY6qrYpGjIDOco6
         nN0w==
X-Gm-Message-State: APjAAAUaghGR593x+ci6sw27gDJbIXQvOebL22ppmbcqFG7yc7u1g4zn
        JoWu90l9UmHGSpUGvcBwTbS9QA==
X-Google-Smtp-Source: APXvYqyqOun6k3rFPZiHWrWAxUeMwEI/iqTNd06JTPho68It+7LHZEn/6EYjihJLeJfIdRD2OVDxgw==
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr82883736ejb.217.1560514666534;
        Fri, 14 Jun 2019 05:17:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id z40sm847346edb.61.2019.06.14.05.17.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 05:17:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3194F1804AF; Fri, 14 Jun 2019 14:17:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk, newella@fb.com,
        clm@fb.com, josef@toxicpanda.com, dennisz@fb.com,
        lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 08/10] blkcg: implement blk-ioweight
In-Reply-To: <20190614015620.1587672-9-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org> <20190614015620.1587672-9-tj@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 14 Jun 2019 14:17:45 +0200
Message-ID: <87pnngbbti.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> This patchset implements IO cost model based work-conserving
> proportional controller.
>
> While io.latency provides the capability to comprehensively prioritize
> and protect IOs depending on the cgroups, its protection is binary -
> the lowest latency target cgroup which is suffering is protected at
> the cost of all others.  In many use cases including stacking multiple
> workload containers in a single system, it's necessary to distribute
> IO capacity with better granularity.
>
> One challenge of controlling IO resources is the lack of trivially
> observable cost metric.  The most common metrics - bandwidth and iops
> - can be off by orders of magnitude depending on the device type and
> IO pattern.  However, the cost isn't a complete mystery.  Given
> several key attributes, we can make fairly reliable predictions on how
> expensive a given stream of IOs would be, at least compared to other
> IO patterns.
>
> The function which determines the cost of a given IO is the IO cost
> model for the device.  This controller distributes IO capacity based
> on the costs estimated by such model.  The more accurate the cost
> model the better but the controller adapts based on IO completion
> latency and as long as the relative costs across differents IO
> patterns are consistent and sensible, it'll adapt to the actual
> performance of the device.
>
> Currently, the only implemented cost model is a simple linear one with
> a few sets of default parameters for different classes of device.
> This covers most common devices reasonably well.  All the
> infrastructure to tune and add different cost models is already in
> place and a later patch will also allow using bpf progs for cost
> models.
>
> Please see the top comment in blk-ioweight.c and documentation for
> more details.

Reading through the description here and in the comment, and with the
caveat that I am familiar with network packet scheduling but not with
the IO layer, I think your approach sounds quite reasonable; and I'm
happy to see improvements in this area!

One question: How are equal-weight cgroups scheduled relative to each
other? Or requests from different processes within a single cgroup for
that matter? FIFO? Round-robin? Something else?

Thanks,

-Toke
