Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB06C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 10:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E9D60F14
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 10:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbhH0KIN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244492AbhH0KIM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 06:08:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3647C061757
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 03:07:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i6so9591283wrv.2
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WPM/GdqIDYPIdm9g8U8r6TMVUEsXihbn2CBDUO0bnsA=;
        b=cIX1EpawwpmoSQFSBaTgGBL5DNv0275ZkSQEGsRnUfYYghfTWXn6KUw0KLRIgLlFwP
         zJCdCen1XMghAZatzt8nu/a0xpOZr030+H1v2TQr5xQnpHgcMyhlquwPi7QWXHTKx1QL
         vePJGSJtn4jIZzOqGomVzUUA9ZRD3jwVFljp1/QXQnVm67qx0+4JTym4oY6zp6m4KLnr
         2SKeKRFbxs1/ARpaaJufWXR/Jg7epwIh4YBOVXtARC628bEoTpnNqp/u7S1HZw7ZOuYU
         ecE+5N/0uU+UDRXLBGq8N9wOPR1Gzob0TkkkkbzCmDjtUTFedDa5szc8JN/ZYjxCV/CJ
         mrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WPM/GdqIDYPIdm9g8U8r6TMVUEsXihbn2CBDUO0bnsA=;
        b=P6dRcL8VJ7mXYlZvdLKT5bDaSSvkXW5HeiippOmj2YUW/u2CZWs6WawubwbA6+rwv5
         vfIBES94Qf9lA8TragKdQtGiNpG+RlI1jfSfY6WZ2oCNwS4uO+ClGXyz1Jf32Zf+XJqK
         bLLhl2Uqq/Sc/ZTVjf+K5LPMG06ItfCYZkEMgedkqhzAG1o/QD/hd2dl8HTtzdGEt0f5
         Awos7ngRjyEMVQqYOKxbpuaYWK57TULoE06xuJAjsJUz4m59OhU/uvGFnz//Bm7s0W6A
         /dtJ6gW1kaDGKjvWp/eVPb9ynh0Xe+3cw1O/bi7oQoPR8UVH/zRietNxuN16+WIij+No
         flpg==
X-Gm-Message-State: AOAM531233XWsS6rLjO+3KtQALS7AHpX/w9BLaf8zQG9av/Ns2o3+JcU
        CfH+u0rOm1jlgg0Dlv7p3nBOOyeqSoSH8A==
X-Google-Smtp-Source: ABdhPJyPOCl7xGCzS+vsrv/D5tawbWBe1Sp6RxA9qvP9/Kpu7VrXLEE2gCk7s1bauo2ZwFiGJEq1MQ==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr9585156wrn.248.1630058842202;
        Fri, 27 Aug 2021 03:07:22 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id k14sm5785826wri.46.2021.08.27.03.07.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 03:07:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3 v2] bfq: Limit number of allocated scheduler tags per
 cgroup
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210715132047.20874-1-jack@suse.cz>
Date:   Fri, 27 Aug 2021 12:07:20 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <751F4AB5-1FDF-45B0-88E1-0C76ED1AAAD6@linaro.org>
References: <20210715132047.20874-1-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 15 lug 2021, alle ore 15:30, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Hello!
>=20

Hi!

> Here is the second revision of my patches to fix how bfq weights apply =
on
> cgroup throughput.

I don't remember whether I replied to your first version.  Anyway,
thanks for this important contribution.

> This version has only one change fixing how we compute
> number of tags that should be available to a cgroup. Previous version =
didn't
> combine weights at several levels correctly for deeper hierarchies. It =
is
> somewhat unfortunate that for really deep cgroup hierarchies we would =
now do
> memory allocation inside bfq_limit_depth(). I have an idea how we =
could avoid
> that if the rest of the approach proves OK so don't concentrate too =
much on
> that detail please.
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

Before discussing your patches in detail, I need a little help on this
point.  You state that the number of scheduler tags must be larger
than the number of device tags.  So, I expected some of your patches
to address somehow this issue, e.g., by increasing the number of
scheduler tags.  Yet I have not found such a change.  Did I miss
something?

Thanks,
Paolo

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

