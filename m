Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D085C433ED
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 07:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4612F61449
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 07:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhD2HP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 03:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbhD2HP1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 03:15:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D12CC06138B
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 00:14:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so98285544ejc.10
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 00:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqAWH45jRWdgyTy2vjfyUi3E8yZmGvelI1ZJKsPMIds=;
        b=VSwv9YS9I/lBFs/IN7IUEF+2BTCx3OHcMdiplR+lrXBXAtH2x6YeZiFSKtQfGwCJ63
         chd7KsyX2OTqULmCqT+/JFtFbRRrtyG33bQM+KulrM4MKnQbBRFl74mgZbw59yWUAPez
         DFqO6aMuXnrQKTnv26qw5aFTMpK3U+Sl1DkDHkUOjhhoRt/fJnRKzPX4wWGJQtrmby6m
         safy4FK+iIbP3T7E8KdYhZWdLKpxzbiAl4rHB9Ba4ukvLRN1aMriWshXX1IetiOyuSoa
         7xrmRhAUFYgnQegX08jGoZI+S9hdc+F/guYTR+Oue3DaZMRO4ZWqw4GENJsoigSEFzLQ
         4etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqAWH45jRWdgyTy2vjfyUi3E8yZmGvelI1ZJKsPMIds=;
        b=Ee1WffPsmRjtHlNjwmJNieOalcJ1dkcDcSGAnuoGU5k8HhCnYm3hfhL71AuqE5L7I8
         qsUNsnOn9b27Tnd1oCbyIU3BISk+M9SE90ejSBK/ODT1qcrDbOABHKC77q81eGdm0bAB
         dNjKEIjBXSUdFP1ZytEIxswUyI9IHI5QnslKmsmQGUSj4XeTSAMESsnhTxqYDMkPxOPe
         hP8+m9pnfXb9oTv2v7EcvEhgbnHphZ0EgmNqrDJEN+HMTkNLK51a9GcdVxfPfj+O19CE
         fyuER7n1sN+kqjhTE0lhVYYVDtfSgzT8AQebM+L0Eqp+HPsUrBWu+KtXDGyQn5CY24EP
         OKOQ==
X-Gm-Message-State: AOAM5339bEm9WySgdV+MAAMiYudT2C0zu+MrjTIHI5vubszP0ZCHlxFa
        ohQrih1MP+3R3vF3YZl9EDC9zw2G0G+VunQSmCxFcA==
X-Google-Smtp-Source: ABdhPJyDNuaDth9n4XTzWoPlDtmpTv6KRYHjL6/OTOpzC+KOSr0mJjOzSMdo763CEyHtrUiP+KnAqXVqcYQd+aKtMew=
X-Received: by 2002:a17:906:828b:: with SMTP id h11mr25061172ejx.305.1619680479976;
 Thu, 29 Apr 2021 00:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210428061359.206794-1-gi-oh.kim@ionos.com> <20210428061359.206794-5-gi-oh.kim@ionos.com>
 <BYAPR04MB496504E1348ABFEE30FFC0C186409@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB496504E1348ABFEE30FFC0C186409@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Thu, 29 Apr 2021 09:14:04 +0200
Message-ID: <CAJX1YtbJXWL7du8+6QzMisQhF72zRfMx92G2_LiLd3Nj6JSUYg@mail.gmail.com>
Subject: Re: [PATCH for-next 4/4] block/rnbd: Remove all likely and unlikely
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 28, 2021 at 8:33 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 4/27/21 23:14, Gioh Kim wrote:
> > The IO performance test with fio after removing the likely and
> > unlikely macros in all if-statement shows no performance drop.
> > They do not help for the performance of rnbd.
> >
> > The fio test did random read on 32 rnbd devices and 64 processes.
> > Test environment:
> > - AMD Opteron(tm) Processor 6386 SE
> > - 125G memory
> > - kernel version: 5.4.86
>
> why 5.4 and not linux-block/for-next ?

We have done porting only 5.4 for the server machine yet.

>
> > - gcc version: gcc (Debian 8.3.0-6) 8.3.0
> > - Infiniband controller: InfiniBand: Mellanox Technologies MT26428
> > [ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
> >
> > before
> > read: IOPS=549k, BW=2146MiB/s
> > read: IOPS=544k, BW=2125MiB/s
> > read: IOPS=553k, BW=2158MiB/s
> > read: IOPS=535k, BW=2089MiB/s
> > read: IOPS=543k, BW=2122MiB/s
> > read: IOPS=552k, BW=2154MiB/s
> > average: IOPS=546k, BW=2132MiB/s
> >
> > after
> > read: IOPS=556k, BW=2172MiB/s
> > read: IOPS=561k, BW=2191MiB/s
> > read: IOPS=552k, BW=2156MiB/s
> > read: IOPS=551k, BW=2154MiB/s
> > read: IOPS=562k, BW=2194MiB/s
> > -----------
> > average: IOPS=556k, BW=2173MiB/s
> >
> > The IOPS and bandwidth got better slightly after removing
> > likely/unlikely. (IOPS= +1.8% BW= +1.9%) But we cannot make sure
> > that removing the likely/unlikely help the performance because it
> > depends on various situations. We only make sure that removing the
> > likely/unlikely does not drop the performance.
>
> Did you get a chance to collect perf numbers to see which functions are
> getting faster ?

I knew somebody would ask for it ;-)
No, I didn't because I have been occupied with another task.
But I will check it soon in a few weeks.

Thank you for the review.

>
>
