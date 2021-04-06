Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFE9C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E49613C2
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhDFIRe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhDFIRe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:17:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E028C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:17:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id p4so5176575edr.2
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUdsd596Zp7Do7xPuKCOdkwkhsHwm1c1Kp4quEj/1cU=;
        b=WLS4Q7zTdM+0+SoruEHgpdWX6kfzsvfGiu9Su34CODcex5aI1IW8v7RcIBBNLjj9ep
         WU9Q+uyukpdTqTVjDC56Gt2b/0LtGN36opkqCFmKSkKGvRSGsJf6nuFK8Ze6zLQcFJ+h
         nl+dlWgXq5uiFsA3WmAd//X0/FqG2faJ554t88YKHhurqbL+XBYYluFGziU9ka2kH3x7
         SqMFxxXb2Cjd8nzc5RAAcv4iB7Jr0BdmWbiFVddMKWR556MZWqjr3aveEC5XBCQzkOoF
         rUvQ/X5Kc3x6vBxiFubJhgOSozO/K4XBd5oDayh8AuAywgMPZmwBxK0OtGz8zbKyZmvB
         a2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUdsd596Zp7Do7xPuKCOdkwkhsHwm1c1Kp4quEj/1cU=;
        b=tkjzTSLCAt46k6nurx9fDShetu0pJs56aMsAFqfPmJJ8W8vOKd9BwaW+gL+YePtlME
         s9en0MgLCdvvV93HTEFXeY7+sluRiHjHHE2SXlbFcAXRcJTk+cEZMz4hFh926ppiFbzC
         vUGbk33H+7y8iGSGflYUdmKQkddz2SUE45xdEk7T2D3dTB3u0+TQfJzxJY7E+Rd0gvZd
         i1Nwm4lMuVKbDK84R17t/MkYq+jhNLS0tj8zH+wCjax3vr45Di8EZNKhimCSZ9Ge/rBC
         QbGBmIiBGPPIwjPjh9AMcB6Za+Ankfoy58q9oSbtNgbo2cOsKnER1b7bS2aszchyo7Mi
         w+HA==
X-Gm-Message-State: AOAM530Ci6m9U3LxgBrygDrBgVJ+H24pny3AZXUSg7aW2RBJ3C+LEDK2
        Jq7hd/KqRUqzkrDhmOmkJd3p9Pk8o81DRcoghP7hjo8j79P/+mH6
X-Google-Smtp-Source: ABdhPJzKRqmPIJU1NWJGaxx00jw/sB1qFGgfb8e09ZJjadgs1FdrYPKAVZY+OtdMPp2q3lAMxip8yvt4xU88mj0jP3s=
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr36670325edu.268.1617697044861;
 Tue, 06 Apr 2021 01:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:16:49 +0200
Message-ID: <CAJX1YtbeANRYiKHrw4sY22hw0U+JmC6vTtjK9qPVM=H1nRDWUQ@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 00/19] Misc update for rnbd
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> This is the misc update for rnbd. It inlcudes:
> - Change maintainer
> - Change domain address of maintainers' email: from cloud.ionos.com to ionos.com
> - Add polling IO mode and document update
> - Fix memory leak and some bug detected by static code analysis tools
> - Code refactoring

Hi Jens,

I am really sorry that I forgot to add the Reviewed-by line at 9 patches.
I wrote which patches I missed below.
And I will send a reply for each patch to show you.

If you want for me to send patch set V4, I will do.

>
> V3->V2
> - Exclude patches relevant the Fault-injection feature
>
> V2->V1
> - Change the title: for-rc -> for-next
> - Remove unnecessary (void) casting requested by Leon
>
> Best regards
>
> Danil Kipnis (1):
>   MAINTAINERS: Change maintainer for rnbd module
>
> Dima Stepanov (2):
>   block/rnbd-clt-sysfs: Remove copy buffer overlap in
>     rnbd_clt_get_path_name
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

>   block/rnbd: Use strscpy instead of strlcpy
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

>
> Gioh Kim (8):
>   Documentation/sysfs-block-rnbd: Add descriptions for remap_device and
>     resize
>   block/rnbd-clt: Replace {NO_WAIT,WAIT} with RTRS_PERMIT_{WAIT,NOWAIT}
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

>   block/rnbd-srv: Prevent a deadlock generated by accessing sysfs in
>     parallel
>   block/rnbd-srv: Remove force_close file after holding a lock
>   block/rnbd-clt: Fix missing a memory free when unloading the module
>   block/rnbd-clt: Support polling mode for IO latency optimization
>   Documentation/ABI/rnbd-clt: Add description for nr_poll_queues
>   block/rnbd-srv: Remove unused arguments of rnbd_srv_rdma_ev
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

>
> Guoqing Jiang (5):
>   block/rnbd-clt: Remove some arguments from
>     insert_dev_if_not_exists_devpath
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

>   block/rnbd-clt: Remove some arguments from rnbd_client_setup_device
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

>   block/rnbd-clt: Move add_disk(dev->gd) to rnbd_clt_setup_gen_disk
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

>   block/rnbd: Kill rnbd_clt_destroy_default_group
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

>  block/rnbd: Kill destroy_device_cb
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
