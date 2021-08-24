Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5520C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 12:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CADBE61373
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 12:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhHXMxE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbhHXMxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 08:53:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E1C061757
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 05:52:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h9so44173426ejs.4
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 05:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rF5LX7bcoF4k9NLEvLggyMdDUIHzQk8nVL5kZ2BjI4I=;
        b=kedr7XrCeegz+SetLGq88UQyk9f1bicxT3ylBeG3tKgppTTG9VAGMckhCzdPVzhsmg
         PMeUtZkcMLF08Vhpx0J0/ys1oJtOtANHrdgLWcnOGORgHXnnm7y0irKGeTnB8COiS/V6
         ZIhtxzNM4Jkw6FtwWps77g3hKMjz0mYd9sKCOuUB65Ekz3Q7QazNrRGit9vpfmz+jc/F
         jpmA8lXTsXUf/ALzGg9okPUNNVX3SIEU9Z3mHw9fmwEiM7y5iJMzUQrgKE/pETdhR94/
         AjwuC5GcrYVkyrdstfLFRFrYe1VhltRCu/Un7Ffdn5tXJ8YDEJ07W1dndoc6cdU1iT/I
         /MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rF5LX7bcoF4k9NLEvLggyMdDUIHzQk8nVL5kZ2BjI4I=;
        b=p29prAeWnzvxDI9xtJQ+PDMpzovOyrZv2F86XV9g/RrjNp67H4i4jw9Q1P9UciPDgx
         iWf/mbXXdRxxRQWdgiHKUj9QVyHu8KFwCCVIOR/iBRoA9PJJduy7wCCcTT9q88IaP7Vt
         c12qs/Ya+qIUhUemdXFWJ1pIlwb2Z2pw1IiG/rYSnzNt16bPu6n1niskrSt8h+ATHZJd
         82pcyCh23jW7JcqCWkdMyyg+sgxX6bwXVW4NE6e6ypsOxpyxBaNnMXYNkRVmDiKF4bVh
         zdiZkekoc4MyS/VeV6JWNkTf16QhAm+R3h4mvxHt9rbSHnNs9zD1hLHGJXpF2ToxG8X+
         gKRw==
X-Gm-Message-State: AOAM533NcSat1k/HxwLK2Gx7mHIzjkH+x4z3dgZB4ZO1mUdkDx0TZ+F7
        kYqvr1+MH8/nuSUNDJ4r8JTgF6hmq5rldl9bGSyj
X-Google-Smtp-Source: ABdhPJxZ5X0+aPv9JUU0NSZ38FiUrCJVeWHPVM5RcZqWY++RsvN97pFmLXobEnv9DA0vstyyEs93waEvekTwGw5gi5g=
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr40023101ejs.197.1629809538488;
 Tue, 24 Aug 2021 05:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com> <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com> <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com> <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com> <20210823080952-mutt-send-email-mst@kernel.org>
 <b9636f39-1237-235e-d1fe-8f5c0d422c7d@nvidia.com> <CACGkMEuc0C0=te3O6z76BniiuHJgfxHnaAZoX=+PCy4Y7DxRow@mail.gmail.com>
 <c238448b-9915-a4fc-4ec8-c807a06b359f@nvidia.com>
In-Reply-To: <c238448b-9915-a4fc-4ec8-c807a06b359f@nvidia.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 24 Aug 2021 20:52:07 +0800
Message-ID: <CACycT3vCfydrCq8vR9-WMq+-KDJx1Z+q1saOmp0yW0TRvLrqGg@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 24, 2021 at 6:11 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 8/24/2021 5:47 AM, Jason Wang wrote:
> > On Tue, Aug 24, 2021 at 6:31 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 8/23/2021 3:13 PM, Michael S. Tsirkin wrote:
> >>> On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
> >>>> It helpful if there is a justification for this.
> >>>>
> >>>> In this case, no such HW device exist and the only device that can cause
> >>>> this trouble today is user space VDUSE device that must be validated by the
> >>>> emulation VDUSE kernel driver.
> >>>>
> >>>> Otherwise, will can create 1000 commit like this in the virtio level (for
> >>>> example for each feature for each virtio device).
> >>> Yea, it's a lot of work but I don't think it's avoidable.
> >>>
> >>>>>>>>> And regardless of userspace device, we still need to fix it for other cases.
> >>>>>>>> which cases ? Do you know that there is a buggy HW we need to workaround ?
> >>>>>>>>
> >>>>>>> No, there isn't now. But this could be a potential attack surface if
> >>>>>>> the host doesn't trust the device.
> >>>>>> If the host doesn't trust a device, why it continues using it ?
> >>>>>>
> >>>>> IIUC this is the case for the encrypted VMs.
> >>>> what do you mean encrypted VM ?
> >>>>
> >>>> And how this small patch causes a VM to be 100% encryption supported ?
> >>>>
> >>>>>> Do you suggest we do these workarounds in all device drivers in the kernel ?
> >>>>>>
> >>>>> Isn't it the driver's job to validate some unreasonable configuration?
> >>>> The check should be in different layer.
> >>>>
> >>>> Virtio blk driver should not cover on some strange VDUSE stuff.
> >>> Yes I'm not convinced VDUSE is a valid use-case. I think that for
> >>> security and robustness it should validate data it gets from userspace
> >>> right there after reading it.
> >>> But I think this is useful for the virtio hardening thing.
> >>> https://lwn.net/Articles/865216/
> >> I don't see how this change is assisting confidential computing.
> >>
> >> Confidential computingtalks about encrypting guest memory from the host,
> >> and not adding some quirks to devices.
> > In the case of confidential computing, the hypervisor and hard device
> > is not in the trust zone. It means the guest doesn't trust the cloud
> > vendor.
>
> Confidential computing protects data during processing ("in-use" data).
>
> Nothing to do with virtio feature negotiation.
>

But if a misbehaving device can corrupt the guest memory, I think it
should be avoided.

Thanks,
Yongji
