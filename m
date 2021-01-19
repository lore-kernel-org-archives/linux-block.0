Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD520C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FBE20776
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390133AbhASRNz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391060AbhASRNh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 12:13:37 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E954AC061575
        for <linux-block@vger.kernel.org>; Tue, 19 Jan 2021 09:12:56 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ke15so21885653ejc.12
        for <linux-block@vger.kernel.org>; Tue, 19 Jan 2021 09:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UJPK5CKb0wcUY0ytM1Iv21srZ4iUx0Yma6nHEQVa5Nk=;
        b=h3j+E4fVWvZlVGfFRLrwMN4TLzWzH0l9C3vPGAnBTk96EoS+ZreRLQfvvbyap2PvFA
         efDFcP1MQZx6YwPhKcyihjAe7a5Urh0q0CtLSp9SIAjwqYt3SuPt1uMlkrnmhxGDJ+Cg
         imLzrR7Di6uGNcviJTaKQdgzLRGftRy7P77FiuD2X5OeHhDdeJSFi4nbTpXT4C9IaVmZ
         a9SrMnkAGScIvLYxB/82cu3JjNu8XbDzMyPB2hUczjooRoVqHvmBqF2pmGDwIkKmpX62
         FO0HYz+Yfhn8abK7d1N17ZKfoWGnsaTO9FGex1wwWuvKMqTMr871DXeLJFTMWZvCkG79
         h6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UJPK5CKb0wcUY0ytM1Iv21srZ4iUx0Yma6nHEQVa5Nk=;
        b=Fc/N4Q5t/Yd40bxQJnwIzVYEDDv/i4Np95BSMEjDYNGlqvSdgxAXt17O84dWk3IS3A
         df/caqdnIKDFshaZqkYNDxxGy/FBTinQsB0zYOmrj4apWr0SgnJmi2jHjWuRchRcY3JP
         yjNNAa28vSQaOjXiLQ0Xyk5/j9cTw7pK3gEQYerc3VUMORSi+UJcjNRJbTll6+9pwgVS
         Tif/NDR4fORz1S97cAITgoIGyz/iCBkbrFso0rPs7RKMWNgSf52ox6OE3J7IIVvvz+e9
         zPjEGbVyomSaHIm9fnj0QdjFmvStZGj3Xh5H4KGvpmUmN26kgLcYzKDKqsqdyOm+vuMT
         pZAw==
X-Gm-Message-State: AOAM533G7brpFhjIlRipJueVE5C9RQfnuMlLyyVp3HWAz5LC04COXRaT
        gSjNxGhaHN08TyqLuC29OYzkWW6EN6DOiJk+U1xMLNNQJKc=
X-Google-Smtp-Source: ABdhPJwlzs3mKH5XCXsK5FB3ODrtX3QjgRCccS62xO+tJGzz36TaQLR4fAUYzxIwg5scnxQvlf7jbpFXYYVNhyAFOIw=
X-Received: by 2002:a17:907:1b27:: with SMTP id mp39mr3580960ejc.519.1611076375571;
 Tue, 19 Jan 2021 09:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20200723211748.13139-1-pasha.tatashin@soleen.com>
In-Reply-To: <20200723211748.13139-1-pasha.tatashin@soleen.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 19 Jan 2021 12:12:19 -0500
Message-ID: <CA+CK2bDg-sPzUe2pUsXTxx8+vykyaL+Mr3J2OZELtmU2b_pmBg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] scale loop device lock
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 23, 2020 at 5:17 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:

It has been half a year, and no activity on this patch. Can it be applied?

Thanks,
Pasha

>
> Changelog
> v2: Addressed Tyler Hicks comments
>         - added mutex_destroy()
>         - comment in lo_open()
>         - added lock around lo_disk in
>
>
> ===
>
> In our environment we are using systemd portable containers in
> squashfs formats, convert them into loop device, and mount.
>
> NAME                      MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
> loop5                       7:5    0  76.4M  0 loop
> `-BaseImageM1908          252:3    0  76.4M  1 crypt /BaseImageM1908
> loop6                       7:6    0    20K  0 loop
> `-test_launchperf20       252:17   0   1.3M  1 crypt /app/test_launchperf20
> loop7                       7:7    0    20K  0 loop
> `-test_launchperf18       252:4    0   1.5M  1 crypt /app/test_launchperf18
> loop8                       7:8    0     8K  0 loop
> `-test_launchperf8        252:25   0    28K  1 crypt app/test_launchperf8
> loop9                       7:9    0   376K  0 loop
> `-test_launchperf14       252:29   0  45.7M  1 crypt /app/test_launchperf14
> loop10                      7:10   0    16K  0 loop
> `-test_launchperf4        252:11   0   968K  1 crypt app/test_launchperf4
> loop11                      7:11   0   1.2M  0 loop
> `-test_launchperf17       252:26   0 150.4M  1 crypt /app/test_launchperf17
> loop12                      7:12   0    36K  0 loop
> `-test_launchperf19       252:13   0   3.3M  1 crypt /app/test_launchperf19
> loop13                      7:13   0     8K  0 loop
> ...
>
> We have over 50 loop devices which are mounted  during boot.
>
> We observed contentions around loop_ctl_mutex.
>
> The sample contentions stacks:
>
> Contention 1:
> __blkdev_get()
>    bdev->bd_disk->fops->open()
>       lo_open()
>          mutex_lock_killable(&loop_ctl_mutex); <- contention
>
> Contention 2:
> __blkdev_put()
>    disk->fops->release()
>       lo_release()
>          mutex_lock(&loop_ctl_mutex); <- contention
>
> With total time waiting for loop_ctl_mutex ~18.8s during boot (across 8
> CPUs) on our machine (69 loop devices): 2.35s per CPU.
>
> Scaling this lock eliminates this contention entirely, and improves the boot
> performance by 2s on our machine.
>
> Pavel Tatashin (1):
>   loop: scale loop device by introducing per device lock
>
>  drivers/block/loop.c | 99 ++++++++++++++++++++++++++------------------
>  drivers/block/loop.h |  1 +
>  2 files changed, 59 insertions(+), 41 deletions(-)
>
> --
> 2.25.1
>
