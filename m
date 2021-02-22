Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CA0C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 09:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501764E13
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 09:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBVJzS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 04:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhBVJzP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 04:55:15 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F6C061574
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 01:54:29 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id o16so51529313ljj.11
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 01:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2At3HZEJZazFw4OSX565LuS6mDlQ72rczHhb0TBGoo=;
        b=MgZ/+RnGjk3zzTU+UMh7jter9MmzhwMeDhnzpC02/bOkBXyrHPnLF5nBVDtDgWRTbj
         sUmdt8BrR/SSjipj+l1iW8quzfsuGDDTDq3hjFTsyDYrwrDouKOKZxBJdhQWCdxggBAK
         x/re62EReCKZCDheaKghQzx35uG/wiGdWQI/1+NdyIxzHN2s6b4ZarvbE9Wa1RfLdukd
         r3Jew7DzxQ7A2fKHYnLwJs4rUGO6VcaD2QmoGzokLd6xbeiH/9yppJF8XUf9XsA7DQfp
         qHpa/j/7Bfmjt4MjO5LEUju+goKAs9X2RnRYNGG124ibQKqNwdf587N4ws4OL3EepIVs
         66MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2At3HZEJZazFw4OSX565LuS6mDlQ72rczHhb0TBGoo=;
        b=MEHqj9I5cQYYcp9hOMt/eAB6vbU1kdlp0t/87Lj2/pYFMCH5zGuMKR5IRIbAt/dxw0
         WNEwMHRVpL8JdOZLfKIW1XwqB6gBZUFTc1fUjvkFl/TV+u/zY9sA0D14edr+P5wClryI
         9rXUJPeC/XOZDTLHaYlsraIteqArKHFTvPbQ7EKN5HWwnvW00iya/irS4Yiy0QfVrNoQ
         tbHPxOOPLoA6UjufC0UIYBd4ccYjsjeS3pwV+92qICSNOZXUPfeB4/GfI/KKujcOP0CO
         mcrj4nIAlSLrQFMhMT8k3ArFOCjZdEipycI8bM7Nicaq2XQNHF7LSDl6dh72SOuSek07
         F1tw==
X-Gm-Message-State: AOAM531DcfXShIuTOwbq5+rJswZnp7tGGx0PtTcYjJaWrjlrWdKjR7Rq
        Sp3lgPJiu1yEzerdu6V6xPYk4L1guub4wzTBzAsc
X-Google-Smtp-Source: ABdhPJwAlFZfwI2u8BC48t3DkmYYfkXijav9S/xHknlwCO94d/nxPT8nioIMRg43+7I+qQbO2VYKNFr9r3TwL7lUvn0=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr14285084ljg.65.1613987668182;
 Mon, 22 Feb 2021 01:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20210203151019.27036-1-guoqing.jiang@cloud.ionos.com> <d3e8d3e3-9061-373e-5a6a-47216dfe6778@cloud.ionos.com>
In-Reply-To: <d3e8d3e3-9061-373e-5a6a-47216dfe6778@cloud.ionos.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 22 Feb 2021 10:54:17 +0100
Message-ID: <CAHg0HuzrcnVEWpkE_TCPS8UjLednb48SbaPkMGDKVkSM7QEuAQ@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] block: add two statistic tables
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:RNBD BLOCK DRIVERS" <linux-block@vger.kernel.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hallo Jens,

any updates on this patchset?

Thank you,
Danil


On Tue, Feb 9, 2021 at 1:42 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Hi Jens,
>
> Any chance can this be considered for 5.12?
>
> Thanks,
> Guoqing
>
> On 2/3/21 16:10, Guoqing Jiang wrote:
> > Hi Jens,
> >
> > This version adds Reviewed-by tag from Johannes.
> >
> > Thanks,
> > Guoqing
> >
> > PATCH V3: https://lore.kernel.org/linux-block/7f78132a-affc-eb03-735a-4da43e143b6e@cloud.ionos.com/T/#t
> > * reorgnize the patchset per Johannes's suggestion.
> >
> > PATCH V2: https://lore.kernel.org/linux-block/20210201012727.28305-1-guoqing.jiang@cloud.ionos.com/T/#t
> > *. remove BLK_ADDITIONAL_DISKSTAT option per Christoph's comment.
> > *. move blk_queue_io_extra_stat into blk_additional_{latency,sector}
> >     per Christoph's comment.
> > *. simplify blk_additional_latency by pass duration time directly.
> >
> > PATCH V1: https://marc.info/?l=linux-block&m=161176000024443&w=2
> > * add Jack's reviewed-by.
> >
> > RFC V4: https://marc.info/?l=linux-block&m=161027198729158&w=2
> > * rebase with latest code.
> >
> > RFC V3: https://marc.info/?l=linux-block&m=159730633416534&w=2
> > * Move the #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT into the function body
> >    per Johannes's comment.
> > * Tweak the output of two tables to make they are more intuitive
> >
> > RFC V2: https://marc.info/?l=linux-block&m=159467483514062&w=2
> > * don't call ktime_get_ns and drop unnecessary patches.
> > * add io_extra_stats to avoid potential overhead.
> >
> > RFC V1: https://marc.info/?l=linux-block&m=159419516730386&w=2
> >
> > Guoqing Jiang (3):
> >    block: add io_extra_stats node
> >    block: add a statistic table for io latency
> >    block: add a statistic table for io sector
> >
> >   Documentation/ABI/testing/sysfs-block | 26 ++++++++++
> >   Documentation/block/queue-sysfs.rst   |  5 ++
> >   block/blk-core.c                      | 43 ++++++++++++++++
> >   block/blk-sysfs.c                     |  3 ++
> >   block/genhd.c                         | 74 +++++++++++++++++++++++++++
> >   include/linux/blkdev.h                |  2 +
> >   include/linux/part_stat.h             |  6 +++
> >   7 files changed, 159 insertions(+)
> >
