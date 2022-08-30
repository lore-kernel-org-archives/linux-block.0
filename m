Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320D8ECAAD4
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 13:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiH3Naq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiH3Nao (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 09:30:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3019DB47
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:30:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u9so22187678ejy.5
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZXce9kZjeroJq5B1dU7N9ABS124cFfxfP/lumuK5FSA=;
        b=F0Q4tlJPJaXarVlqvTjqYYQ29npsPFnXqLFIdtwiE2AGi7a8eX2p3b5YIK4HIVqEXm
         BFstSE3BafIhme/37lJtjdDvrObJqtdi4gVzWrv09IxuYmO0Hxf7AKIF+kibu8VvywP0
         Gq7DjeWr/UBvCPpRbVWnzvFwGglqHJNEqXkHBYnrmPjtNSzas/s1WQnQ/U9VwiAmU1rN
         t63otQvE/FgHUZJNwE5yXTcJejvZLOZiP3G/X9FxuYT6jxliBbPefRcv2YIuI0PIW5NS
         S1fcYOt7qbU85QpjgGpfsXnI7O9lpHAs+Ny+NaWX1eT7OFitPWQcaOzOagW9N7Hrz2c/
         uoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZXce9kZjeroJq5B1dU7N9ABS124cFfxfP/lumuK5FSA=;
        b=edQdTKW8s6h/x8+wbRX16pV+duTBkJXLmOBXtkQgM03Gzl2QqSYxiWftuZeRiZSGdE
         +cLwc7lS8c7UATfT+pk5qyoFnXmvBRUTk5XUnZYTPAAQQsxUfT9bmRJU9oRXotq3v7QV
         vMknAJnn++LbS0zFpsca5iEqAAgayjvAHdsZ7eedGl9DET3J+ypgUteQ20FGYMdSQ275
         3REs1wE2vgTFS419hLvHwy1qetFMz4KrMS7PDjLE6LeweiK3s4sdtrMmj4WECKyz4rp2
         ft3xZ9zKpU8+SYvElOwyxkeze87gUh4lV/s6jwd/e6drw/JfWKgN7vnw5wfqH5KhwFuQ
         IMLA==
X-Gm-Message-State: ACgBeo2Eoszi7tuILoHQyRDZp/uPBz6UHTRsveHJhWiYje6ULrTnRnB4
        DyQGTjvv3vJzn5ZgstdUmDQFvEAgHybswcfR2tWuLw==
X-Google-Smtp-Source: AA6agR5aFEtZOWvIqS0imarjOwKt9Iy2nohIom1/olvdHG0XhdBJOfpqi7UTRZWs7tPxLPG6Mu4lJ8pNNl4JtFKwsyA=
X-Received: by 2002:a17:907:7292:b0:733:1965:3176 with SMTP id
 dt18-20020a170907729200b0073319653176mr16917491ejc.318.1661866238884; Tue, 30
 Aug 2022 06:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220830123904.26671-1-guoqing.jiang@linux.dev>
 <20220830123904.26671-4-guoqing.jiang@linux.dev> <bb5863e8-35a8-9f47-c9a9-b3a8d45fa258@nvidia.com>
In-Reply-To: <bb5863e8-35a8-9f47-c9a9-b3a8d45fa258@nvidia.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Tue, 30 Aug 2022 15:30:27 +0200
Message-ID: <CAJpMwyhmhFU8tTohmJGYiQuae2OgJmGMPEU8xy4J5Z1dQ3jRew@mail.gmail.com>
Subject: Re: [PATCH 3/3] rnbd-srv: remove redundant setting of blk_open_flags
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 30, 2022 at 3:02 PM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 8/30/22 05:39, Guoqing Jiang wrote:
> > It is not necessary since it is set later just before function
> > return success.
> >
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > ---
>
>
> Looks good.
>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

This looks good,

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

>
>
