Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5254C433EF
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 22:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6A0610CF
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 22:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbhKIXBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbhKIXBY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 18:01:24 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FBCC061230
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 14:58:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v11so2647601edc.9
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 14:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piVw7EQFiHd4yQr382mTiOSVMWD2myq2lpTp7X6eA3k=;
        b=O9CVHBq6fW+VYtGUwY7auFg42mdgiZ6EoM67vnO7Hnhax3TN4kIevGCFBAJvT9EunP
         26OsuxNhaTTNJUfY8PyTws2pMxGcU4PZlQp5J7S61j4fuCKeoiT85ON25cJKEy6P9S0Y
         afPCgJ0ZxvqgMBq8E1ZbhQwWUDGq5CEd0eRtINKk9nCoCuQSQaCbCDQkC3hsa+y6NxMt
         ilWyv/7z0LyQb/f/nSh9OmYhNXTNzap1QBKbMexdmH0wYndHv+VV4kkqTXiwPwYOvgdg
         aTKVFEOhNXGqQL3st+oyNekNX28t4y2y/h6RCtEWJqu8+60beAZLIfyGws8DPfpKTlkX
         UVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piVw7EQFiHd4yQr382mTiOSVMWD2myq2lpTp7X6eA3k=;
        b=4feCzgL43nQavlZjrOEY2IQBpeKdrBHWutC7KPxfNMLc8XwF90OtV5oZRPYFu55F9B
         uzPVQqplqib82oYJwTN4sAYiX49Tw/GMl135mUPIo1IeK0h0DYDz06xGcT3BMiKr/aPD
         T1auo2d5gfhxLFgiGsfDcjaD6haJ6vKshYrgnYVRLtcwepTImILcZn5QszGLwyK35IbV
         oHwitc0hSErEkRCnaPSXU/tPiaHm2lq27dlBmJawtZeAC+Ytu79d2N2tSSqqicA91+V+
         RC+yI5tRQHxHHtnisUIiF/BAifeT/KLgqcBlT0jYgaGl+6R10bULHRasynBos7oDEX3b
         gaBg==
X-Gm-Message-State: AOAM532fMJqERoo/jA8rhUpnh+/zCPEwR827DOxav43ZX5zpO/sh8ZnM
        1EYG2jBqhV+BOZAPHViOf0EB+gqZpkxTqo5BYgtIIg==
X-Google-Smtp-Source: ABdhPJzlwcZnxz7msbWulktUOOQ9sLZGkeFb0OLKMvRh0D/3C7m/Xg2Ze/gLLrInjFuqa48yUkcnt3S5mV8QbwryQEg=
X-Received: by 2002:a17:906:ff47:: with SMTP id zo7mr14675046ejb.148.1636498693361;
 Tue, 09 Nov 2021 14:58:13 -0800 (PST)
MIME-Version: 1.0
References: <CABVffENnJ8JkP7EtuUTqi+VkJDBFU37w1UXe4Q3cB7-ixxh0VA@mail.gmail.com>
 <77f9feaa-2d65-c0f5-8e55-5f8210d6a4c6@gmail.com> <8cd3d258-91b8-c9b2-106c-01b577cc44d4@gmail.com>
 <CABVffEOMVbQ+MynbcNfD7KEA5Mwqdwm1YuOKgRWnpySboQSkSg@mail.gmail.com>
 <23555381-2bea-f63a-1715-a80edd3ee27f@gmail.com> <YXz0roPH+stjFygk@eldamar.lan>
 <CABVffEO4mBTuiLzvny1G1ocO7PvTpKYTCS5TO2fbaevu2TqdGQ@mail.gmail.com>
In-Reply-To: <CABVffEO4mBTuiLzvny1G1ocO7PvTpKYTCS5TO2fbaevu2TqdGQ@mail.gmail.com>
From:   Daniel Black <daniel@mariadb.org>
Date:   Wed, 10 Nov 2021 09:58:02 +1100
Message-ID: <CABVffEMy+gWfkuEg4UOTZe3p_k0Ryxey921Hw2De8MyE=JafeA@mail.gmail.com>
Subject: Re: uring regression - lost write request
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Sat, Oct 30, 2021 at 6:30 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
> > Were you able to pinpoint the issue?

While I have been unable to reproduce this on a single cpu, Marko can
repeat a stall on a dual Broadwell chipset on kernels:

* 5.15.1 - https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15.1
* 5.14.16 - https://packages.debian.org/sid/linux-image-5.14.0-4-amd64

Detailed observations:
https://jira.mariadb.org/browse/MDEV-26674

The previous script has been adapted to use MariaDB-10.6 package and
sysbench to demonstrate a workload, I've changed Marko's script to
work with the distro packages and use innodb_use_native_aio=1.

MariaDB packages:

https://mariadb.org/download/?t=repo-config
(needs a distro that has liburing userspace libraries as standard support)

Script:

https://jira.mariadb.org/secure/attachment/60358/Mariabench-MDEV-26674-io_uring-1

The state is achieved either when the sysbench prepare stalls, or the
tps printed at 5 second intervals falls to 0.
