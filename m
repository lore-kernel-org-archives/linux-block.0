Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8C1C433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 07:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiC2Hwa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 03:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiC2Hw3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 03:52:29 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9D20A3AF
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 00:50:45 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id j20so988467uan.1
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 00:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oq+Z6jNlZq+ZQofugfp2fRT6ds4wfKxot/aZdwn2WhA=;
        b=yZhdVjxwh2/m5mbLgEngbkgE3G3gnxZFRf1jW13GjQM5F98zv7M82fzW8oKWfZSKUF
         kluYlmO7/djcCa8os2SM3k7YOg+loZt0FPygDR9ComSmwQxnkNHbWxildLYxmsKVkXDb
         DxyJesNbu7I7TwfK9xMRH1fit0kbIQ3DRgi3aOoe33j4XbntfXHuMGxiZBbsCdhlaCMt
         3Jq20be/b7HvMOVMr9CZHcCAcpxSR6s3i7RaHeD3ZZSZr1s+cG8i8RIe7mqtt2RRtCgS
         u51da3zY7RvzdQZihKHdUI5EDco+FytktD3YVJYkeoz/wes7UkclKvRM1J8sV6BlmVgt
         nVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oq+Z6jNlZq+ZQofugfp2fRT6ds4wfKxot/aZdwn2WhA=;
        b=YbK2kZHdoZnYKPxOIdt0EUn5VyUEvifJMVwyobu8PW/VIdbD06IdYwLJsQ+/GIQNZz
         3wPYRso0mHiHQ5MnZAaGjxMf/Hk1OZkUoUTbFSE96bzExGtxc1Hx25+bMxupS91XeuOh
         yEBlRd0n6An8W+PRS/A0MWKEBNO55YdunBErfLBjiSIzscOO2p/pT4/qnR1dWS8F7rqc
         xUZ0oYZh+r9cD7WjdjOJhSP1uGeDEtTcCFBcrURulsp5hsss3iBtHTbMx8adzxxQWExx
         vdmrVGPemlPzuQTgLqVsdi5nQPrbMr4cDpYDKGcuDmDK9fQTwW3+rlM8303JLcW3FvMk
         lmZg==
X-Gm-Message-State: AOAM533xVEk9mRwhEsBpv0TVS4G6cV2sGh3XB9B2+i0Zj8YwmShHPD0E
        cj93EUcw2JYzPE2egDyBT9j/OyCrUXlKpGdH5IXyOQ==
X-Google-Smtp-Source: ABdhPJw5plfdPb+L2JPLk102d32wrj5zplTwmUxFp7a5XaOP/QkyG0KqpejT+kgULLuf4pgaK9Mu7q3gz8Vv5zQqzws=
X-Received: by 2002:ab0:6c48:0:b0:359:cfea:c24f with SMTP id
 q8-20020ab06c48000000b00359cfeac24fmr9497635uas.104.1648540244878; Tue, 29
 Mar 2022 00:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220329070618.GA20396@lst.de> <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de>
In-Reply-To: <20220329073254.GA20691@lst.de>
From:   Philipp Reisner <philipp.reisner@linbit.com>
Date:   Tue, 29 Mar 2022 09:50:33 +0200
Message-ID: <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
Subject: Re: state of drbd in mainline
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The complete lack of bug reports and maintainer interaction usually
> suggests low to no use and heavy bitrot.  If that is not the case
> here that's fine, just asking..
>

FYI, feature-wise the in-tree DRBD is frozen. Maintenance only. Users,
seeking advanced
features switch to the out-of-tree DRBD and use other means of communication:
Github issues, linbit's community slack channel, last not least
linbit's ticketing system.

That is why you see virtually no activity.
