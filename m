Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FEFC4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 06:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiLTGpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 01:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiLTGpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 01:45:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CAD13DD6
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 22:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671518669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwzbCVxJgzqh/hZntLgZPVw/8F+zWvpGjiJvEA/MIXQ=;
        b=fOT8LjDr7XUfp+a4RAtm99I9HZKBSmGtUs5DevYXnP1VicAX0sU7YKconJeIBCf2CGBndk
        rQs3jHOX8Y5FbW823MVFZcLo40XNGc7PVkyN8ef81sDUiH4oqTTSodFiv5wI3IJSGCz4Y1
        ustFzTjHLSCfVijSgtmCwflVEg+T2yY=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-zC43077sNhK2qiJwKHDC3Q-1; Tue, 20 Dec 2022 01:44:28 -0500
X-MC-Unique: zC43077sNhK2qiJwKHDC3Q-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-144ea535efbso5222232fac.16
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 22:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwzbCVxJgzqh/hZntLgZPVw/8F+zWvpGjiJvEA/MIXQ=;
        b=TGpAF542bVHEhLDa7j5cI0Oj/Cgujs4FNWqyJ/0YQ3FFE8QwgtauZieNlcUfjIBpyN
         oc6gnFeTiexds+bGFaUTHENROQEq5/C7lplj0tToAKcClcUH0DRGj2+ctMmeV1MzD6Aq
         j36bSDvcyhJITK+5Kw0QKQLjrFZR0eciOovuOCjRLzbGPq0Q1caBzdyCbtBTSDBP1/ax
         mwF8fC7fgyacBDVnzdedbc+QOR8J/CNIMIe/0QQYZEVn7CUUYVLMBw0vgj9tgKBMr1GX
         mMXTQiNg5wU6zpDNDjZQZJoO5v4HPL12kRdl6F/psZ4kH7KAX3odWXN/PbwUZVkpB5Tx
         rbrA==
X-Gm-Message-State: ANoB5pmeflFum8b/GK3ZED15ViPwu9nj4A5e6dmJzTZKUFER0xfR4lY1
        sTITlN3ArWPQa1nPk186ijBGIjY7Qh1dofgfQ4I8q9SI/D0KnnmvYXjKPmbQP1go6dCzF+ORLop
        tgP4jIi50BPXI8IRQRdzoPxScWmAWDogL4OY3BuY=
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id u12-20020a056808114c00b0035e7a427ab5mr1228659oiu.280.1671518667327;
        Mon, 19 Dec 2022 22:44:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jGysDqwGrWJu197Nisc2Stp5MBJuSZWK+fp7URpsNdbjTOdPL95/ws7E6NNNRPis0ciTrq34bL9g/AETi3fk=
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id
 u12-20020a056808114c00b0035e7a427ab5mr1228649oiu.280.1671518667107; Mon, 19
 Dec 2022 22:44:27 -0800 (PST)
MIME-Version: 1.0
References: <20221128021005.232105-1-lizetao1@huawei.com> <20221128042945-mutt-send-email-mst@kernel.org>
 <CACGkMEtuOk+wyCsvY0uayGAvy926G381PC-csoXVAwCfiKCZQw@mail.gmail.com> <20221219050716-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219050716-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 20 Dec 2022 14:44:16 +0800
Message-ID: <CACGkMEsHojBVQWUDH4L1xiVTjNm3JgkYBppyOHKr8QLUg3=FsQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Li Zetao <lizetao1@huawei.com>, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk, kraxel@redhat.com,
        david@redhat.com, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, rusty@rustcorp.com.au,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 19, 2022 at 6:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Nov 29, 2022 at 11:37:09AM +0800, Jason Wang wrote:
> > >
> > >
> > > Quite a lot of core work here. Jason are you still looking into
> > > hardening?
> >
> > Yes, last time we've discussed a solution that depends on the first
> > kick to enable the interrupt handler. But after some thought, it seems
> > risky since there's no guarantee that the device work in this way.
> >
> > One example is the current vhost_net, it doesn't wait for the kick to
> > process the rx packets. Any more thought on this?
> >
> > Thanks
>
> Specifically virtio net is careful to call virtio_device_ready
> under rtnl lock so buffers are only added after DRIVER_OK.

Right but it only got fixed this year after some code audit.

>
> However we do not need to tie this to kick, this is what I wrote:
>
> > BTW Jason, I had the idea to disable callbacks until driver uses the
> > virtio core for the first time (e.g. by calling virtqueue_add* family of
> > APIs). Less aggressive than your ideas but I feel it will add security
> > to the init path at least.
>
> So not necessarily kick, we can make adding buffers allow the
> interrupt.

Some questions:

1) It introduces a code defined behaviour other than depending on the
spec defined behavior like DRIVER_OK, this will lead extra complexity
in auditing
2) there's no guarantee that the interrupt handler is ready before
virtqueue_add(), or it requires barriers before virtqueue_add() to
make sure the handler is commit

So it looks to me the virtio_device_ready() should be still the
correct way to go:

1) it depends on spec defined behaviour like DRIVER_OK, and it then
can comply with possible future security requirement of drivers
defined in the spec
2) choose to use a new boolean instead of reusing vq->broken
3) enable the harden in driver one by one

Does it make sense?

Thanks

>
>
>
> --
> MST
>

