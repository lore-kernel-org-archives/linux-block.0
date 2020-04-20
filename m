Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00DDC3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 07:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B492078E
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 07:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="KCNp8rGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDTHAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTHAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 03:00:08 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945FC061A0C
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 00:00:06 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z12so8686940ilb.10
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 00:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqFHvk9xZJMhRW6+AHUh/bF20SKI/1RsLvajNQQNBGs=;
        b=KCNp8rGwRnCAuSN0lzCD/tn8MYyA7kQF91BbYLmpORDMnrcXuIuChTQYUQyeP8S7VH
         CPEBvqhVypW0z83GmQ4A/efMtysHw6cUuc3zCEe9xUJWQdrxrGQmVsytNtfsYlI1JUUJ
         No/aJnvgMDu1Nx8+mqdcYPwtdFZO3clb1N0QmCzaLIV8yVbw3EByidHrzn3svF8GhZqG
         DPSX2hCCg9hcr+w0fmLk1GQzCYXIzH87lhHMFIvkDu5o6shpWWD6+I7g2wlKdbQc7Tub
         ipYhm51xxqEWiWihA9/ls8m45aUs83avCkOk7E5lgrymYYOKtHDIwFdnuAR7GinnUoq5
         3tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqFHvk9xZJMhRW6+AHUh/bF20SKI/1RsLvajNQQNBGs=;
        b=eWnWdupGBYFdz5X2rCNn4RrkZWudjkZ2tum89S/aD4NHy8ZAKVROoXD2UMCuVpFOEt
         aCue+Te5vM67zAIXV6e3s1XoZDUBH+3EYSGD/yXKM1TGHfb50+/s8ADPigTs3TMUvvTO
         KjcrsFCWYJGT2xlfRmtXeT9NETrHizrynmrbxRPfY3Q9ME9iuiO3vjK/BXTK132gRy2l
         zXlplyY4HUanCycBsrHz6K7pFcoCODWFbE2KG4iIkwsmiGlBDxjjsec8u7tXs1STIEAe
         /u3m6zUtLmXhf3IQjO74aWTPSsRCWkCMeRqxHXOZLD/ZZXXQx4lzDdCus83z0YlrChcH
         fHeA==
X-Gm-Message-State: AGi0PuYxJY8FzqJb7XqHDFMHRZ7Tju2Cq9mzYwdkJPEXohyimSvH9Fm5
        Q87nNGqCWasidFFgW8qhfLgFaFV6dipZz/Q/nVgCow==
X-Google-Smtp-Source: APiQypJhe8HdzU4OnxZXYK5jbfEnwUHB2gcgv8KOyhw/a7sV/4/6jwE73UXeEBFLBVpav1spqkcTALB5Xi4Ei+XBN9E=
X-Received: by 2002:a92:9a0a:: with SMTP id t10mr14601371ili.50.1587366006140;
 Mon, 20 Apr 2020 00:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-22-danil.kipnis@cloud.ionos.com> <d4603c67-ba0c-bb33-51cd-ef454bbb097c@acm.org>
In-Reply-To: <d4603c67-ba0c-bb33-51cd-ef454bbb097c@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 08:59:57 +0200
Message-ID: <CAMGffE=9iiA_-7shU_6P-hjnVbwogMqpBwUmbWj5pjMEw6HZPg@mail.gmail.com>
Subject: Re: [PATCH v12 21/25] block/rnbd: server: functionality for IO
 submission to block dev
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 19, 2020 at 1:38 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This provides helper functions for IO submission to block dev.
>
> Should "submission" in the patch subject perhaps be changed into
> "submitting"?
>
> Anyway:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
"submitting" seems to be a better word, thanks Bart!
