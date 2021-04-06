Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA0AC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4AD3613C0
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhDFISr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhDFISo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:18:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2582DC06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:18:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dd20so8231507edb.12
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEPjT+5wmyo/wIppd9sri0XtriMc83+vMgvhOpvs3Hc=;
        b=ZAxSc+w9yqL7n0OkmjP61VcRNgg9MhnnZWmXx2rbxNnhiEFTe1yHNBt17HgO/5R36M
         If7fG25RK7Jh8UC1A+8L5ElZXa86N5f4oRsnhuKjwDlp0dvCfwJm8FQxveLkUxJi7nk7
         MTemm9rr/wfRsFs7QmWxaabqGTOAJoMHHdJnl2xs5Ngg/rk8Be/BWKJHjpJ3CAIugNUE
         SuC/I1tdJ7lPTIockKC1hos9FpQUC3jKlxuUgeQ+zWvF2HwFSdvQD04Ltdpw2ViB7fM0
         Z1YPVmt+L7N8DFGoON+vFq1GpljEyMt8LZrXzbyf7zkCuRRlGyzjDq9rZNErDNg9SIby
         oleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEPjT+5wmyo/wIppd9sri0XtriMc83+vMgvhOpvs3Hc=;
        b=Zb3kTksvSUGTMq98A15y/P6tTQBmGENl+Mm0o2aLu27iAum71RNL9qjvgjrGCmp7dc
         JLYNNVNFzF5CuFpZ3lLrztFvsLhbDoQPD5YUyYQTFlOZhyIYv78bOtUSi2aZW0zcxN7h
         Q8OT16KgTQvJuyETZ9NxkRJOpAoWyIyL7x/VJGg/lEZKhChhIhk2jN/2w12OtMQlYmcL
         6U+i8U28bUrWIUQGgU/a7fTv7U8Wlrd1SqENmW1fHIWzD/CdXBrSrBXUPzmYr6udLgHb
         fb8yxR+y7PI8AqRb9u8D/ZyBxG1olfaaGKwgtSkj1900rhDWCOHTiAFYoM2mh89QoHrz
         nAaA==
X-Gm-Message-State: AOAM532gfLUhS0xqebusBt2GOWyG39Rx9eoZN6nFpJ5ZTK55P8Rfle20
        XPleUaGX5J1fgyqwI1sy4uIbHR3T3L3mY03EJ18hJt0YcFfHr0gm
X-Google-Smtp-Source: ABdhPJyK3XhwYz/04V6l/LC5JnbL9V0rmFlKCI8Sf1cl1YoOG/dmFvnHRS4whiD7Xp9ZNJFmi+/0ZQ/Ygw9gnk9zee4=
X-Received: by 2002:a05:6402:1c04:: with SMTP id ck4mr2242904edb.74.1617697115838;
 Tue, 06 Apr 2021 01:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com> <20210406070716.168541-6-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-6-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:18:00 +0200
Message-ID: <CAJX1YtY2bFiBohBCH5UeCcg8kvo6Ch6vB6ncSpU81hiFM8jbhg@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 05/19] block/rnbd-clt: Move add_disk(dev->gd)
 to rnbd_clt_setup_gen_disk
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@gmx.com>
>
> It makes more sense to add gendisk in rnbd_clt_setup_gen_disk, instead
> of do it in rnbd_clt_map_device.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
> Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
