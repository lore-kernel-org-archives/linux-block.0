Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0688EECAAD1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 15:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiH3Puk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiH3Puj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 11:50:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED3C6BD73
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 08:50:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id se27so15318758ejb.8
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Iio8V0MHxdUQkk4vWtqAomITxYg958FqXvjlgFRaJBQ=;
        b=HWBcmchGQQjDK0EdODX6lW853C53nJMFiJz5RpUYnmIqSQ+J6Hkb8QcE7I159QODcf
         FZ+1AhN3VxmGophxMBtZJB3tN9bdZ3YgTsNIjwu4h8G3vKIeoFq/wlyrlxa3RcwLOP/x
         A3QoCDA4Yujq04x5svuGKw2mnBDP2SyHuRdTejPb971FXv9npc7OiGqpZ3FHd3dPb+6S
         rK2/c0bd8GokLEuWEwK3jA6zOAQ/WzYFHA8XgbmINjFfwDZt/hPH0uVJecnrpfDAEiPG
         S5SB/FUtA8pvoXOyjoKLYAGsPumlgeFP3uC/9gIK3sCEyzNjoS6pTX/+DAy53DXg73Gd
         pgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Iio8V0MHxdUQkk4vWtqAomITxYg958FqXvjlgFRaJBQ=;
        b=5FArTTdhnl+ybIqhFF48rJ5nr/SoqWCbV/S7bxgbb/f5D0MMq0yH5vf1ZoHFFMg/zi
         oifPE7P3UMeax8oy62oOvKzmjfWtZ8XEAljAE3Lg01YbWMspeaRokqao+a/D1uTP6zr0
         FFJUUYaxwqiBtMykvkerDCZe4SLLI4wiWo9wwGOpBrC8YeAjdaLUyO6Nm0m+N7dyZdcj
         c2ku8EniG8GmqRKEiEayUrUiO94W6pR4BDNMrSu/JemI8OQWkfo6nFrQFqjT95YRtLnS
         kQY877KxRwk0efOLhCGgOGxRaYXM3brBsr5Uz63bvF0FPkydFkCMZXpcI4mdVNUAR/Be
         WmRw==
X-Gm-Message-State: ACgBeo16cI09bYhoKaH3/pyyhh8sAqa9J3z0dpn4vFgtdSp7xROj5aMP
        nKYbIXspeLk0rf4jw1Rg79Pp5k/r21l62jypV0Qluqoyisc=
X-Google-Smtp-Source: AA6agR6r1M+XWTo1IZPsOZUPGTqEIcf3l5PkFK5Wu1JCvh5m6+P/QBK8r3CHzPS8VsaKbbDPEOtfeGaCq/5nTZAjVUs=
X-Received: by 2002:a17:907:7f02:b0:73d:dffa:57b3 with SMTP id
 qf2-20020a1709077f0200b0073ddffa57b3mr15018284ejc.19.1661874636297; Tue, 30
 Aug 2022 08:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220830123904.26671-1-guoqing.jiang@linux.dev>
 <20220830123904.26671-2-guoqing.jiang@linux.dev> <CAJpMwyhT4mnbA4xi2xD4-EeJeXNJL6oQ66QfbddnPdZZBWA2_g@mail.gmail.com>
 <8765c12f-eb29-b5f5-b15f-5d09e32eca21@linux.dev>
In-Reply-To: <8765c12f-eb29-b5f5-b15f-5d09e32eca21@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 30 Aug 2022 17:50:25 +0200
Message-ID: <CAMGffEnu7pktPLLu6H_Qh15ivCEjXXYQfXyDWSGS62cXe+s-Ug@mail.gmail.com>
Subject: Re: [PATCH 1/3] rnbd-srv: fix the return value of rnbd_srv_rdma_ev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Haris Iqbal <haris.iqbal@ionos.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 30, 2022 at 5:10 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 8/30/22 9:28 PM, Haris Iqbal wrote:
> > On Tue, Aug 30, 2022 at 2:39 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> >> Since process_msg_open could fail, we should return 'ret'
> >> instead of '0' at the end of function.
> >>
> >> Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> >> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> >> ---
> >>   drivers/block/rnbd/rnbd-srv.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> >> index 3f6c268e04ef..9182d45cb9be 100644
> >> --- a/drivers/block/rnbd/rnbd-srv.c
> >> +++ b/drivers/block/rnbd/rnbd-srv.c
> >> @@ -403,7 +403,7 @@ static int rnbd_srv_rdma_ev(void *priv,
> >>          }
> >>
> >>          rtrs_srv_resp_rdma(id, ret);
> >> -       return 0;
> >> +       return ret;
> > I think the point here was to process the failure through
> > rtrs_srv_resp_rdma() function. If you notice how the return of rdma_ev
> > is processed by RTRS, in case of a failure return; it tries to send a
> > response back through send_io_resp_imm(). Same would happen in the
> > function rtrs_srv_resp_rdma().
> >
> > If we call rtrs_srv_resp_rdma() with the error, and return the err
> > back to the caller of rdma_ev, we may end up sending err response more
> > than once.
>
> Thanks for the explanation, I am wondering if it makes sense to call
> rtrs_srv_resp_rdma when ret == 0,
As haris mentioned above, rtrs_srv_resp_rdma will send back the
confirmation to the client side.
ret==0 means the operation is finished successfully, negative value means error.

> let's just add a comment here.
would be good to add a comment.
>
> Thanks,
> Guoqing
Thx!
