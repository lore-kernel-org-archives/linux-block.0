Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B29C433E2
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 14:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D6C2078C
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 14:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="VmPqDHSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgEOOjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 10:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727098AbgEOOjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 10:39:54 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5368C061A0C
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 07:39:53 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id r7so2386066edo.11
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2VffbjNRn/hIG8YGeScI30zMZc3Q8yYP/kX8vo17MQ=;
        b=VmPqDHSrw7woxyrqt8DCU3c7jPIpUxTnoTjE0E349n9Rw0gHx9UnmlRme6+JY0TXS4
         JuMfqhRE9fwgpchjIdDZryx0jBDgf9zXQbFmqw6t52VcWoeODDqtfgd8x9glMAya5NVP
         hK6TOt+ybWxwkKkfs3q96WiQwUvrJ4j/QcgAZZ4nd8bVCGmqLb7RUEtL72q3jFuuexHY
         RIcUhaWwWROCqDrwf2qsYaTMDcAhXG3cp/jnRFFuPOp8lJgAagnPhrvpq+hSq3uYOl6t
         nFAKsXsQkbyT9i/TZhM9BPPqdelH57dUhXvsV/CO0RC4EquiMvmkHKDwQU0NrQt/FmKT
         0pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2VffbjNRn/hIG8YGeScI30zMZc3Q8yYP/kX8vo17MQ=;
        b=ibSI8JjTYl2bHe2yMmUI52xE5J5DRncUjyKQo4dSXAUvxr8JqABJnLSlcMQZ9G9wSh
         6mBILVWpH33z6t1G/cmI63hOBSi1RDsS+SMs6otY7kYrMrO0NVT5N8rX+CVscY4iFLQC
         oiKZMz4ojpBMGVUueKPHjSui1qf3bv/SOmfeEekrN8+Ja+9dxZhEqgieeGFqv61UbpGV
         tIY6yaM1hAsiAStkeVt9euAPMYxy5u7Z6k09iZXkbfw+iPsNbO/IRPGg01UoOnfgx+9Y
         i5effJwtj5TzhITN4Y4+JEXG0hd6cKLF1v7TyMJ7aSt7UQV+OfxsRD8aAXkHvI7PaKkb
         8h7g==
X-Gm-Message-State: AOAM533saId9q+QvScS3BGqGukFpPBf1j6FxLzh/GP/JGdpkrTYkvGBA
        wGwxOmZIaev37y0iqS++j73GLgWLj8Jmj3oofgn3tw==
X-Google-Smtp-Source: ABdhPJzMJ1q32NljMhLiqfWLMarIBo67FcKd3tUwshX5jswNyqESrr1W012P1tM9iGaWo4h5NGdXDia7Gs0yjXad30k=
X-Received: by 2002:a05:6402:1596:: with SMTP id c22mr3352804edv.100.1589553592331;
 Fri, 15 May 2020 07:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
 <CAHg0HuyYO913MmHt7qi12T6mVXo9nabUs6GJyqRAGfWAdfPjCQ@mail.gmail.com> <e04fc798-ee25-53a5-fae0-5985306b55fd@kernel.dk>
In-Reply-To: <e04fc798-ee25-53a5-fae0-5985306b55fd@kernel.dk>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 15 May 2020 16:39:41 +0200
Message-ID: <CAMGffE=NJfdMzbv7wk0XR902UQPNDdBjCK+ATe+P_JcWbSqoew@mail.gmail.com>
Subject: Re: [PATCH v15 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 15, 2020 at 3:53 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/15/20 4:29 AM, Danil Kipnis wrote:
> > Hi Jens,
> >
> > we've fixed the kbuild cross-compile problem identified for our
> > patches for 5.7-rc4. The block part has been reviewed by Bart van
> > Assche (thanks a lot Bart), we also replaced idr by xarray there as
> > Jason suggested. You planned to queue us
> > for 5.7: https://www.spinics.net/lists/linux-rdma/msg88472.html. Could
> > you please give Jason an OK to take this through the rdma tree, see
> > https://www.spinics.net/lists/linux-rdma/msg91400.html?
>
> My main worry isn't the current state of it, it's more how it's going
> to be handled going forward. If you're definitely going to maintain
> the upstream code in a suitable fashion, and not maintain an on-the-side
> version that you push to clients, then I'm fine with it going upstream
> and you can add my acked-by to the block part of the series.
>
> But maintaining the upstream version as the canonical version is key
> here.
>
> --
> Jens Axboe

Hi Jens,

Thank you very much for your reply.  As mentioned in the past, we are
committed to maintaining the code once
it's in upstream,  we tried hard to make sure the upstream version is
compatible with our in house version, so
we can switch to the upstream version in the future, the main
difference is the driver name/sysfs, we have to adapt
other in house tools which use the old "ibnbd/ibtrs" names to new
"rnbd/rtrs" names, it will take a bit time, but it will
happen for sure.

And we will follow the upstream process to push RNBD/RTRS further.

Regards!
Jack Wang
