Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A495DC4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 09:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADF96137F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 09:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhHWJ2a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 05:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhHWJ2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 05:28:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB7BC061757
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 02:27:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id me10so7258751ejb.11
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Esa2FafoN8KSXuNWaqN6YvG0PA3NcKwp5nyZgUd3ais=;
        b=RYIew4MS/fLhio3mRclkoFm0wK4XjxXhZDn5RaQwFq3FHuGTD9SHD2wqQNSDdQ4zUl
         llSdIdl5i1bkwBPo1nh1wkyz6O7LI7DctWOwpUelHadERPoiJn7yCYGH0SeLypNfNTv/
         PyMgn9n6WjiW3F/QVtLvp6pXiDD8Wgj8Ju/VNYQbYdp02gMmlRtq6m3KUK/IE0N3aUa3
         wemTJwrjavd37/YkpCvUdzK6bZ3jebqfvNoKe5xjjLniWBMYLwPF+n+a3jcub/3ny3zc
         /kPTPSCic9sIN/jKGwnbFRSWNYO1NreJE6C6Ca1fsTMHVpWC3cVVLVOj2JcFei55JhLJ
         owFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Esa2FafoN8KSXuNWaqN6YvG0PA3NcKwp5nyZgUd3ais=;
        b=J+csiIftQo3apK7soLfpA3IHrW0lAFjcK0V7mwJGIncZQ2You6SL7Y70W//C+I4fjR
         NSh+qi27JhPX5Em76SWYcrq5w/7PNGGmjYhmjm8Q5sGhYcwmwxTzdNBRIGngkqKAWNUq
         GorY8Otu/Vqz+kNWrP2oob1Vv0vI7akYmHY7EFIU+yY/GtlkuvI6CK/I8SEXOkLWvS9e
         kOKFE7EmATcf4kHwLJl4gZR0G9TfiohlyPNi3lrIa2VLhN1pA3di0nUrkTF5N/iZYyMX
         Q9AMKTNTRfYMiBGP8HLbm7dF1WHjwS83we09H4NW07ZJlu9o+uo2ctO+f8MZRXWLEvTR
         OUrw==
X-Gm-Message-State: AOAM530taF9b42ZLKnXOx/wPHJJijhfzDNalboWijD3TaOiY87IGQ8gz
        E9zZv+gVlGDaXQa4NPm9QnDYn4gdYc4msjDcjdVU
X-Google-Smtp-Source: ABdhPJwv7hWFCXeVLr4W5C1PjnJTQDsp8Fpj+3Knt8NgePlDKwOAtak8Mc8sSySJx46nUtyIEFQPOjdRcdJhwQtWTHs=
X-Received: by 2002:a17:906:b25a:: with SMTP id ce26mr2947564ejb.174.1629710866738;
 Mon, 23 Aug 2021 02:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com> <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com>
In-Reply-To: <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 23 Aug 2021 17:27:35 +0800
Message-ID: <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 23, 2021 at 5:04 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 8/23/2021 11:35 AM, Yongji Xie wrote:
> > On Mon, Aug 23, 2021 at 4:07 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 8/23/2021 7:31 AM, Yongji Xie wrote:
> >>> On Mon, Aug 23, 2021 at 7:17 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>>> On 8/9/2021 1:16 PM, Xie Yongji wrote:
> >>>>> An untrusted device might presents an invalid block size
> >>>>> in configuration space. This tries to add validation for it
> >>>>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> >>>>> feature bit if the value is out of the supported range.
> >>>> This is not clear to me. What is untrusted device ? is it a buggy device ?
> >>>>
> >>> A buggy device, the devices in an encrypted VM, or a userspace device
> >>> created by VDUSE [1].
> >>>
> >>> [1] https://lore.kernel.org/kvm/20210818120642.165-1-xieyongji@bytedance.com/
> >> if it's a userspace device, why don't you fix its control path code
> >> instead of adding workarounds in the kernel driver ?
> >>
> > VDUSE kernel module would not touch (be aware of) the device specific
> > configuration space. It should be more reasonable to fix it in the
> > device driver. There is also some existing interface (.validate()) for
> > doing that.
>
> who is emulating the device configuration space ?
>

A userspace daemon will initialize the device configuration space and
pass the contents to the VDUSE kernel module. The VDUSE kernel module
will handle the access of the config space from the virtio device
driver, but it doesn't need to know the contents (although we can know
that).

> > And regardless of userspace device, we still need to fix it for other cases.
>
> which cases ? Do you know that there is a buggy HW we need to workaround ?
>

No, there isn't now. But this could be a potential attack surface if
the host doesn't trust the device.

Thanks,
Yongji
