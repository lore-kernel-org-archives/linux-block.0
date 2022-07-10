Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA5EC433EF
	for <linux-block@archiver.kernel.org>; Sun, 10 Jul 2022 01:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiGJBPM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Jul 2022 21:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJBPK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Jul 2022 21:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B50F5BF77
        for <linux-block@vger.kernel.org>; Sat,  9 Jul 2022 18:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657415707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LnmwoE1ESaUSXake5lmFYTPM0/kp0klpWUDGs+CL1aM=;
        b=iexgIstEzH0mvfOwUWvrOuMXkDkio3ncneZJZNjxfPwNkqK1i13UtIx0cvxDXNdbKn+xLv
        nLS5qMxaWCVFLLuEKZltvcdSozxnypwoWMBTacORxV9VE9imEvJ5NvpiFsi+uL90vs7xAu
        v/dKEQSQgNgIixv0iKLPAkMmlaK2UZM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-x9VX5zMlMgSbJzb2pe4ISg-1; Sat, 09 Jul 2022 21:15:06 -0400
X-MC-Unique: x9VX5zMlMgSbJzb2pe4ISg-1
Received: by mail-pl1-f200.google.com with SMTP id c15-20020a170902d48f00b0016c01db365cso1525578plg.20
        for <linux-block@vger.kernel.org>; Sat, 09 Jul 2022 18:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnmwoE1ESaUSXake5lmFYTPM0/kp0klpWUDGs+CL1aM=;
        b=E9e9yQsi7OAOeEz6jp/mF0wtQaNPwFzzQB40oOPS4oCoz0niEs3x1973ul9scWd9fV
         thZVciUCAN5U1KNuMSSPXoQ8keWaxPgg3VHQjSteWxPCPUScqFGo37Y2rsG6wetZJqmu
         b7V6Z+niByr1A0P/V6WVLOlnntL4R58WDdxoNGbOinFoevUz/0cm8WU4qZ4ENlP4+LXl
         oO/ghEP/W59mGOdLNNGkDgl2pEVF+nGsrQ3S4VANEFNG8tYSnhwsxFM1nKm5BVeYRERX
         m+SkonxKG8yeNRQf4ER1nYs5fRUFfPRFBwFRDUm0s5n1lot9NnVigiOlsHyh/xRtLYKs
         7j+Q==
X-Gm-Message-State: AJIora9mxAcvS3fyZVJa+an1QfP3gTkFFoDbB9Gt18w7S7TYs8YzF/3t
        opNkwV4/qrAzA+GXcsspEhRjG6KZKqRULsAioo+ZkYGxKfZFpGiOnowP9KO/BIS+TO0YW2VKrTw
        rwLahaBNgvQKB+l8o/N05VbQrJLbvAHFtcR12JT0=
X-Received: by 2002:a05:6a00:793:b0:52a:b261:f8e7 with SMTP id g19-20020a056a00079300b0052ab261f8e7mr10004223pfu.20.1657415705341;
        Sat, 09 Jul 2022 18:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tqJATeVZl4K9fNLEfFlRcSBawUoqH1LFdOK/P3Q+zc5HAvKZdmY9aMRgLd4rtICcDO1JtOVkruH4QCr3aZBZs=
X-Received: by 2002:a05:6a00:793:b0:52a:b261:f8e7 with SMTP id
 g19-20020a056a00079300b0052ab261f8e7mr10004202pfu.20.1657415705013; Sat, 09
 Jul 2022 18:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9Jhg4DZRnck_rdGWtpv9nLTAF__CVtPQu9vViVUZ-Odg@mail.gmail.com>
 <def01493-bd2d-bed4-ab1a-9b4304687692@acm.org> <CAHj4cs-xUroRHbvY4kBPCBFgch7d24yXDFLo4P_ym8KEkHCvug@mail.gmail.com>
In-Reply-To: <CAHj4cs-xUroRHbvY4kBPCBFgch7d24yXDFLo4P_ym8KEkHCvug@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sun, 10 Jul 2022 09:14:53 +0800
Message-ID: <CAHj4cs960iq+KfSaCWCtm=xB3bNYNVkewLmZPpuaO66ZZ9nwXQ@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/005 trigered debugfs: Directory
 'hctx0' with parent '/' already present!
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 9, 2022 at 11:19 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Sat, Jul 9, 2022 at 2:59 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 7/8/22 09:32, Yi Zhang wrote:
> > > I found below error log when I ran blktests nvme/ tests on aarch64
> > > with the latest linux-block/for-next,
> > > Please help check it, and feel free to let me know if you need any
> > > info/test for it, thanks.
> >
> > Is this 100% reproducible? I tried to reproduce this yesterday but
> > without success. See also
> Yes, it always can be reproduced at the second run of "nvme_trtype=tcp
> ./check nvme/005"
> I reproduced it on aarch64, not sure if it's arch related.

Just reproduced it on x86_64, so pls try to run two times for the test.


>
> > https://bugzilla.kernel.org/show_bug.cgi?id=216191.
> I tried block/001, and cannot reproduce it.
>
> >
> > Thanks,
> >
> > Bart.
>
> >
>
>
> --
> Best Regards,
>   Yi Zhang



-- 
Best Regards,
  Yi Zhang

