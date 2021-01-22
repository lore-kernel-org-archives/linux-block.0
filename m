Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E1C433DB
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 10:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D262A2376F
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 10:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbhAVKB0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 05:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbhAVKBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 05:01:03 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EB6C061794
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 01:50:56 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id p20so2675039vsq.7
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 01:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqmXNnhOvww/se+uqGpbG2r6Wj6LjG3RtqIoCGkH17k=;
        b=Bqt3b8b7kp2zQsjWv07hRffU5ZdsKDvLLb7CTBAQdsqsw2qRHDDv257TenVn8PQ0eh
         7Faa1tfN668wJ7fnNrENLH7AoZ+Yz7eIgCNhVFIajtS786Ovqkv97Wr+V6k7E2k62MxY
         +zFfZILJZPCMb2mgb5PIp7UG3mhyPOfuQoIscUoL7KcMmyArbnUdaC0O1T1v40yAIWCH
         kb3Y/uHtCaFYyztgZ4c9IexZUktiJQ8TjmoyT1uO1aGHIVI3c5zzudaDyrdeK9RYpTX9
         cIrmQQoHomR+23NhDIIBOqW/csi0rItWAjz9B7IdKkogQi35H0szd9iVKvGtnr3lgOid
         vpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqmXNnhOvww/se+uqGpbG2r6Wj6LjG3RtqIoCGkH17k=;
        b=N7AZEYEsH1hT5DRgCLCBTBZwf4oIhCBzHme6SFtb9bDx0gC0jUwqLUsaedwxgY3fjm
         /c+eTCHB/sVkpSHpXTyHa10NVCG52sADhDk3MGjns8jnrQNOro9czPKGKDUk1kGkjqUK
         Dhh1D2DoUxxQSDeqvwwme5+6gHTAP4r/tEd/iEYZxk7DLTSVo8g0kQIL4WPF+e0BD0/n
         FZjPujlSk9rhnt9dTepzpRn932fmChGBKPJke6J2QYB8N6+Nipw2I/yQicbJjxOFx1kR
         GEL131MB+pMHWel0SYOb8A3hh3TWRifiIg5Vkro7/fXkA2HJZJqD1YFJikUYVh4wvpTc
         Glig==
X-Gm-Message-State: AOAM531YpyeHAjjR0UoZIhSXD3gbqLM3ErSGAi821CD114RBirVFJyZD
        i+By/yaofaFKTt/ssDqajJE1AugglvS66dgDujQk7A==
X-Google-Smtp-Source: ABdhPJzQkvbtXPAnaOXaJNiT2RO7BkT9eaJIQxnmfKyCTkaPtmRekmQxRuUvkDQuHQpmYuEkgvFe4kOJ3FrZfm16N6Y=
X-Received: by 2002:a67:f997:: with SMTP id b23mr235525vsq.34.1611309056136;
 Fri, 22 Jan 2021 01:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com> <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jan 2021 10:50:20 +0100
Message-ID: <CAPDyKFoPL4drfh3efKXyhXLp6Ce+j=oHwNd9VnVP4aaKQ0zmDQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] block: remove unnecessary argument from blk_execute_rq
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 22 Jan 2021 at 10:28, Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> We can remove 'q' from blk_execute_rq as well after the previous change
> in blk_execute_rq_nowait.
>
> And more importantly it never really was needed to start with given
> that we can trivial derive it from struct request.
>
> Cc: linux-scsi@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-ide@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

[...]

>  drivers/mmc/core/block.c          | 10 +++++-----

[...]

From mmc point of view, please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

At the moment I don't think this will conflict with any changes to
mmc, but if that happens let's sort it then...

Kind regards
Uffe
