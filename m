Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1655C433E1
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 09:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D950207D3
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 09:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="JBeDOUVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgESJOk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgESJOk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 05:14:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82FEC05BD0A
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 02:14:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m185so2601479wme.3
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0FCRf+dTi24ioQ6++WoKkPel78TMMaMNtTZJxFedYM=;
        b=JBeDOUVJfKjg7U2LLMc02GY5YYWKYyQdU+bXVcwdKGAN7MkkoGTWVymmpJcC274eul
         5tAw3a0i3JsksqpDcPYux77IV0YSeu2c4EkpG6ABWAbLPrnGDkKNHbwnm1fGn7fVc509
         ox9J746CMxG3WSr8aYfE2UIvRi/DeHzB2H7CuXMaUEooiinpupI7nM4/koDAcRWUlrgE
         9NIZ05/g4lWW3Gaqw2Tl2iGyJt/t3Br1//3CHkiEBA9F5TUaXGH9FZPs/Sx5vdtEhx37
         V4sExMi3n5L1PXLrPVBML+4hUHZOt5nXynlAh8MtBtnS5T/u0bWTQl+ig0ZkPWecD/KN
         QFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0FCRf+dTi24ioQ6++WoKkPel78TMMaMNtTZJxFedYM=;
        b=d5tvJNOoh70CEwFO4m+59o8Sh6G5QYLr/AcBwkT2UMso8FvdL6KJvnbeWP66+TrbM2
         gDc0jzJk+Ir3LKTy0Rv5xyLPTtjNc/iYlt9T/Ck7SPUljBRTWYKAeaPpkvj0Ti02b2HX
         8ItYP2p7GOObrPk3YLqdKKJnsTsLVeDF+g09CGoCU8RN33SapACPvo5O/i9uC7LieomP
         ZLRxlSeNXuk8MzYNurYa5fIwha7LGcJamA9SccZsevYo4dh+wbtdP5sAd/Z59ossxjWW
         NaBPWakmuyLrTaKexHc0CJO4kUQeQ6Ffq4q8q1mcUV0+4mlEH8TvZDyKGM3HMcTlV7dY
         7Azw==
X-Gm-Message-State: AOAM533TCGRnUmw8ZwL6ffwzfW95hJW4+d6LbnhFCV3FnKT+5vvlWc4b
        a3wDwBxRMFIjWUjKifGoasqtXafXOWF7LxnyVl+X
X-Google-Smtp-Source: ABdhPJxt33H5r+9EPh/ct/Nqr2KLJ99l+vxPSm+tzYDY5aP1Zl3ChyyW0lQX55W6h/Lz1Picbq395Wj70Cthjbj3NHg=
X-Received: by 2002:a1c:5402:: with SMTP id i2mr4567374wmb.185.1589879677255;
 Tue, 19 May 2020 02:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
 <20200519080136.885628-1-danil.kipnis@cloud.ionos.com> <20200519080136.885628-2-danil.kipnis@cloud.ionos.com>
 <20200519084812.GP188135@unreal>
In-Reply-To: <20200519084812.GP188135@unreal>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 19 May 2020 11:14:26 +0200
Message-ID: <CAHg0Huw9HiNz1jYcypiirbB6encMcBOuGMLDE+9m0wGp0B6VfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] rnbd/rtrs: pass max segment size from blk user to the
 rdma library
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Leon

On Tue, May 19, 2020 at 10:48 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, May 19, 2020 at 10:01:36AM +0200, Danil Kipnis wrote:
> > When Block Device Layer is disabled, BLK_MAX_SEGMENT_SIZE is undefined.
> > The rtrs is a transport library and should compile independently of the
> > block layer. The desired max segment size should be passed down by the
> > user.
> >
> > Introduce max_segment_size parameter for the rtrs_clt_open() call.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
>
> Please, add fixes line.
I'm new to this for-next fix up procedure. What tree the commit I
should reference with the fixes line should come from? Should I split
this commit so that I can reference the commits which add separate
files in the original patchset here
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=for-next
? And also if I have to fix yet another issue - how do I then
reference the commit this patch creates if applied?
Thank you!

>
> Thanks
