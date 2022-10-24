Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65361C38A2D
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 06:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJXGcV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 02:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJXGcU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 02:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B815B7A4
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 23:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666593139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQPZZWPPHwbN9plT9WHXwS2wUf+Q7J+W0QxGUvuSQzQ=;
        b=ik//zuSvVk+iC8UlEH2z/FKpZiPs2tEk9fce+7X9yVwow16L3rUdgHmHApuTHml0u6So/+
        /07B8gb0uK3VjsQA2t7A1ShZujfy6sUyJDO6BaB8SuCFIiWykvKbHA5OohDHj35mnwiBhn
        LcGVgi7pjRlY55xF+Iyq54U/nDIBXCs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-41-lMHj4aB0PFGF2_bgarvGZg-1; Mon, 24 Oct 2022 02:32:17 -0400
X-MC-Unique: lMHj4aB0PFGF2_bgarvGZg-1
Received: by mail-pf1-f199.google.com with SMTP id i14-20020aa78d8e000000b0056b275d8a48so3363544pfr.20
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 23:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQPZZWPPHwbN9plT9WHXwS2wUf+Q7J+W0QxGUvuSQzQ=;
        b=bOEl2lS/13HisFTQA/gU5Dzdx9VAP1sTHH2Yl8Ja1YAL813//9mhbAJZgvm7XKziZR
         oXDCZb3L6N74bxkkywQtBtPwNKPNliLKXZHRl3RsAgOwK9VAr6ZzbzHdobpKdkkZh7J2
         VGgIJDpaZo3aVp9cXh37xniluNFX445jHfhKhP+kn8gxxUQnMbPSqjw45LbOrb4/obhE
         by3FWa9gljSegx8momVv9jHYz0DUExjfYViCkGVGEhQAkZ/i+SIDiVD/7Z270I0zSXZp
         7nj22kr3tJSZtkthtogklv5eUc02TovUFLyXIfSc/Q7xRyQT+Vjg/YUmzpTC8FhfYasF
         j1Tw==
X-Gm-Message-State: ACrzQf3bFtYZmJwHVmOoeHJSGve3/+thE2Ikf1h6kJwo900RZ0trowtI
        TmxWrK0DEbfZslayIud21IlMYvxEFT02XDaXBiqxXFMkwi09WVGKHxhcW2TbTM8IQx4HcfE60Cm
        1Byx34pxkozXR2CycsApWxCerhZZ5cQa3RrFzOQ8=
X-Received: by 2002:a62:ea0d:0:b0:55f:8624:4d8b with SMTP id t13-20020a62ea0d000000b0055f86244d8bmr31953497pfh.74.1666593136345;
        Sun, 23 Oct 2022 23:32:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM69XqlJ7Y2tHxxvdGFUUVpmCvlkxf7Ew/IScse+QLdbThp3+FBorJ4z6n3Vj97mlQ/7VSs6Y1e/SHJba0dd3/c=
X-Received: by 2002:a62:ea0d:0:b0:55f:8624:4d8b with SMTP id
 t13-20020a62ea0d000000b0055f86244d8bmr31953476pfh.74.1666593136059; Sun, 23
 Oct 2022 23:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221019051244.810755-1-yi.zhang@redhat.com> <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
 <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net> <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
 <20221021085809.zkzw23ewnv6ul3b4@shindev> <0f2957e1-2b05-73ec-85b1-91cb643ccb54@nvidia.com>
 <20221021235656.fxl7k4x3zjbbaiul@shindev> <CAHj4cs-Vx0+QBF5cSNh4iHEhPao8iJ2gtfE_W7XHKwUh6eFNPg@mail.gmail.com>
 <20221024005000.givqygw4jyjzjp7q@shindev>
In-Reply-To: <20221024005000.givqygw4jyjzjp7q@shindev>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 24 Oct 2022 14:32:04 +0800
Message-ID: <CAHj4cs92c_3t+Ov780F5wsO_B=Mq=0T31Xhv=FWaAy=KqmXpDA@mail.gmail.com>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during mkfs.xfs
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 24, 2022 at 8:50 AM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Oct 23, 2022 / 23:27, Yi Zhang wrote:
> > On Sat, Oct 22, 2022 at 7:57 AM Shinichiro Kawasaki
> > <shinichiro.kawasaki@wdc.com> wrote:
> > >
> > > On Oct 21, 2022 / 21:42, Chaitanya Kulkarni wrote:
> > >
> > > ...
> > >
> > > > I think creating a minimal setup is a part of the testcase and we should
> > > > not change it, unless there is a explicit reason for doing so.
> > >
> > > I see, I find no reason to change the "minimal log size policy". Let's go with
> > > 64MB log size to keep it.
> > >
> > > Yi, would you mind reposting v2 with size=64m?
> > Sure, and before I post it, I want to ask for suggestions about some
> > other code changes:
> >
> > After set log size with 64M, I found nvme/012 nvme/013 will be
> > failed[1], and there was not enough space for fio with size=950m
> > testing.
> > Either [2] or [3] works, which one do you prefer, or do you have some
> > other suggestion for it? Thanks.
>
> Thank you for testing. I guess fio I/O size=950m was chosen subtracting some
> super block and log size from 1GB NVME device size. Now we increase the log
> size, then the I/O size 950m is larger than the usable xfs size, probably.
>
> Chaitania, what' your thought about the fix approach? To keep the "minimal log
> size policy", I guess the approach [3] to reduce fio I/O size to 900m is more
> appropriate, but would like to hear your insight.
>
>
> From Yi's observation, I found a couple of improvement opportunities which are
> beyond scope of this fix. Here I note them as memorandum (patches are welcome :)

I resend the patch to set log size to 64M and another two which could
address below :)

>
> 1) Assuming nvme device size 1GB define in nvme/012 and nvme/013 has relation to
>    the fio I/O size 950m defined in common/xfs, these values should be defined
>    at single place. Probably we should define both in nvme/012 and nvme/013.
>
> 2) The fio I/O size 950m is defined in _xfs_run_fio_verify_io() which is called
>    from nvme/035. Then, it is implicitly assumed that TEST_DEV for nvme/035 has
>    size 1GB (or larger). I found that nvme/035 fails with 512MB nvme device.
>    We should fix this by calculating fio I/O size from TEST_DEV size. (Or
>    require 1GB nvme device size for the test case.)
>
> --
> Shin'ichiro Kawasaki
>


-- 
Best Regards,
  Yi Zhang

