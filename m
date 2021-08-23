Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB88AC4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 10:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD76D61391
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 10:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhHWKeN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbhHWKeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 06:34:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC7C06175F
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 03:33:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h9so36008861ejs.4
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/DY+OKWTsrv1NoEpSDvo3NhS3o2ve347PTYrzSDCA4=;
        b=axMEufMVfMOFUPSzDbB+7DkaSjLMi/NpJEetF40eqwcyX9WtPbHi274IfxagBjKMjN
         zdTR3HuIWWG8YAdyCCoO4LyDnQwE0r03whY6vvpG9CZVOZHGJFVdvMGtpgxnoxfYfq6r
         V57QgC+vCR7VTCzatYQ4NqWL8BB6+cr9T6YzUZjN0YROng7MwTDtKHMkeY7zpkghdHJs
         iuXHf2GpGJcWgfVHuOklQ2Mp335SCY8qmuDGWd59vSW4CARuH9Nwc2/emiVeeRKMk2QF
         ykypaN/yxKBZ/RxmVd91QjsV58cSuBp7Cj6cE4lI6L4COmK2/DPy/buvc7yfMggQBPld
         Kgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/DY+OKWTsrv1NoEpSDvo3NhS3o2ve347PTYrzSDCA4=;
        b=HGyZ77ZIUzqB3gcGUwqSIWUuriTHAmeMtdeRCbyBrQqMQC+XwLSReiDFTlrKtzZSEw
         qQvxFxUL7Hmd8bnP2wHH4FYD7nTzEIo9r8czq5q7fh/+BASW1FpWfBSDyLhHz3Wcac0Q
         wFvpqbJTQVfXjrF6uTyl2G5KjHnfrK0g54j4i9je2wEePX/dDnh+hAq0ZiwaH+RtvNMn
         ooiWqu0saQ2IVlKF4CECctbXMN+0e2fRl2fa3tHEjvHUxzwaKwnd5kmS59HSsez0GuRf
         2e6kp0QcZBSRRXcMR6icbXf0VUjl7CA5kQ970JVkwkv3G1jBrc+17+7ZjlAuwGV3W6jP
         j1HA==
X-Gm-Message-State: AOAM533GbylDKUvVz5CkWJXhE/R9AaGI3aurfrE88h0pREWzAS18/haw
        nibTLBvjvvDTUDVwxOoYDsYmPWu/YBGOlVa/IagP
X-Google-Smtp-Source: ABdhPJxTs6QWMv9oHFniTNQ3vYdFrUqCP8BbffggF1haCGVsPaSO+zFPLdBGW72j2m4f47s1sWVyM2q9ZPG9sx9VJx8=
X-Received: by 2002:a17:906:659:: with SMTP id t25mr34672931ejb.372.1629714805449;
 Mon, 23 Aug 2021 03:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com> <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com> <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com>
In-Reply-To: <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 23 Aug 2021 18:33:14 +0800
Message-ID: <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
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

On Mon, Aug 23, 2021 at 5:38 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 8/23/2021 12:27 PM, Yongji Xie wrote:
> > On Mon, Aug 23, 2021 at 5:04 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 8/23/2021 11:35 AM, Yongji Xie wrote:
> >>> On Mon, Aug 23, 2021 at 4:07 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>>> On 8/23/2021 7:31 AM, Yongji Xie wrote:
> >>>>> On Mon, Aug 23, 2021 at 7:17 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>>>>> On 8/9/2021 1:16 PM, Xie Yongji wrote:
> >>>>>>> An untrusted device might presents an invalid block size
> >>>>>>> in configuration space. This tries to add validation for it
> >>>>>>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> >>>>>>> feature bit if the value is out of the supported range.
> >>>>>> This is not clear to me. What is untrusted device ? is it a buggy device ?
> >>>>>>
> >>>>> A buggy device, the devices in an encrypted VM, or a userspace device
> >>>>> created by VDUSE [1].
> >>>>>
> >>>>> [1] https://lore.kernel.org/kvm/20210818120642.165-1-xieyongji@bytedance.com/
> >>>> if it's a userspace device, why don't you fix its control path code
> >>>> instead of adding workarounds in the kernel driver ?
> >>>>
> >>> VDUSE kernel module would not touch (be aware of) the device specific
> >>> configuration space. It should be more reasonable to fix it in the
> >>> device driver. There is also some existing interface (.validate()) for
> >>> doing that.
> >> who is emulating the device configuration space ?
> >>
> > A userspace daemon will initialize the device configuration space and
> > pass the contents to the VDUSE kernel module. The VDUSE kernel module
> > will handle the access of the config space from the virtio device
> > driver, but it doesn't need to know the contents (although we can know
> > that).
>
> So you add a workaround in the guest kernel drivers instead of checking
> these quirks in the hypervisor ?
>

I didn't see any problem adding this validation in the device driver.

> VDUSE kernel should enforce the security for the devices it
> emulates/presents to the VM.
>

I agree that the VDUSE kernel should enforce the security for the
emulated devices. But I still think the virtio device driver should
handle this case since nobody can make sure the device can always set
the correct value. Adding this validation would be helpful.

> >>> And regardless of userspace device, we still need to fix it for other cases.
> >> which cases ? Do you know that there is a buggy HW we need to workaround ?
> >>
> > No, there isn't now. But this could be a potential attack surface if
> > the host doesn't trust the device.
>
> If the host doesn't trust a device, why it continues using it ?
>

IIUC this is the case for the encrypted VMs.

> Do you suggest we do these workarounds in all device drivers in the kernel ?
>

Isn't it the driver's job to validate some unreasonable configuration?

Thanks,
Yongji
