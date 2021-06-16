Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F42C48BE6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CF6610CA
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 08:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhFPIh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 04:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPIhZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 04:37:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E1C061574
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 01:35:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id my49so2495640ejc.7
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gp4U6YSCPwVtPXy/TVoR1GhhUWzSE9Eyi0KJRY31j3A=;
        b=LMKCPgyRy7f+knB/klKU3hvRqWPJ9Y4i8wY8aRC34ehMg7JPePoxmFFDo4GjUxtJXG
         XUe+fbVJi2OhfNzXbmI+FKOsFmAmZ9ABXQIA6OBNt45tl5htz3gOW+J05wmyy2NFpL0v
         ROUEyzt41iE4721eZBRsaw3htpcZYxACpyax6D6IQ0oor+wFIzwQdIn5zFpw5tIowLav
         CcsPrhdsEb3qWUYdh/XgPzEWk4GhzMIWlsloD/0tfsX1eniyUkH4eunVSIPpfKuSBEjK
         usNjdWaiDQNE/dhrDC4/DyxR1aUDO3ljnQRCQr3U3GcELfWetABOKV3b81CcfL8mQh6Z
         MIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gp4U6YSCPwVtPXy/TVoR1GhhUWzSE9Eyi0KJRY31j3A=;
        b=ndOuFLy6FyzQsSovuUb0CDydADipIhxzLMdIjOs6zdi7SFPZKQ9nHBPsScIiHQWUH1
         dqyQrrpqHmt3oAVMOoHAn0spxenSAoEQOtYbhzdiRRVcVUsflM85hm0gxo1c88vsQ/3o
         /qmH1WxURraWkX/O0wHvy1GZGSch7o7e94IB5PPccKDGGIh/sUApcbM+eyYz3upGqfke
         vJzPJ7QNMPvWiUJ6Urk+yZ/hrTZRnJuJE2Cv8csnZsT1fZp77udTA2DI/Q2GXGoTzb5+
         nkiFjf0V9mH7TBVDwS0k0Zm0wA98z5bzuSJOluraIKPxI58InLO1Tq452hpwhr+q5ycS
         xvpg==
X-Gm-Message-State: AOAM533Y8/0SUqsuk3zzTFBt0xmW02QRqZPvKwF807nyFx5zHDAUnCN9
        veTXHFXoGomDubvdoWE+LSdr9C+NmGfRe95VKaL8
X-Google-Smtp-Source: ABdhPJxfB9bTRfOoTYC2AOEheM8QNpLoI4xIS22CZKj+x+O7PQjTS/OOugJwSPwSvND/NzxJI/HxWaY3FpAzXIKugMQ=
X-Received: by 2002:a17:906:b84f:: with SMTP id ga15mr4071921ejb.372.1623832517360;
 Wed, 16 Jun 2021 01:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210615104810.151-1-xieyongji@bytedance.com> <20210615112612-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210615112612-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 16 Jun 2021 16:35:06 +0800
Message-ID: <CACycT3u-ZUQUDVvJZEck+j0F4VZ8H62_Zo-QPDs_97aWrvgL=A@mail.gmail.com>
Subject: Re: Re: [PATCH v2] virtio-blk: Add validation for block size in
 config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 11:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 15, 2021 at 06:48:10PM +0800, Xie Yongji wrote:
> > This ensures that we will not use an invalid block size
> > in config space (might come from an untrusted device).
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
> I'd say if device presents an unreasonable value,
> and we want to ignore that, then we should not
> negotiate VIRTIO_BLK_F_BLK_SIZE so that host knows.
>
> So maybe move the logic to validate_features.
>

Looks good to me. Will do it in v3.

Thanks,
Yongji
