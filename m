Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F20C4332F
	for <linux-block@archiver.kernel.org>; Mon, 19 Dec 2022 10:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiLSKQG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiLSKQF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2022 05:16:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475652DFD
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 02:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671444920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0F60KxR0W9IzjgTzMiPaONsb+3DC5K9NhR1i6GY+9bw=;
        b=UCyJWuRWj0jWxC73KOYjHtojHh6nXW+7UV36fdidehnR2PGoybgiQHbLO7xspk1LJKiMYW
        4DpH62xFMl/9r/uo51fhf0x6wXc8Std2dAmQdqDLS/XAb8AzTFa26g5vvNQz/u2HKH3+vS
        IW8RfFFNLnp7n8LYPCrhO8/zSRGFJJs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-296-4ZQxOIkyPGyrt7fyxM1CKQ-1; Mon, 19 Dec 2022 05:15:18 -0500
X-MC-Unique: 4ZQxOIkyPGyrt7fyxM1CKQ-1
Received: by mail-qv1-f72.google.com with SMTP id od14-20020a0562142f0e00b0051a47174c4eso260875qvb.10
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 02:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0F60KxR0W9IzjgTzMiPaONsb+3DC5K9NhR1i6GY+9bw=;
        b=vv/x68caQHsGynzocDyLGxqpZpF38ied+qB5/dd5i1HHZrKEpG0fRwUqjjvUhJF9uI
         pNGbir3DqBrmZ/5V0oOd+6uRjBTrd9I0Lg6dmj+z7RITCgugVbWwwAU0E1IUKhk/m7bG
         JBxCJAuMaerDJMxViX424MLyWHqNo2PyxlYOR3iTreV3YKnEZCyVqBbhjxuTvsBGCdR9
         9iiJ8qc5/2VHWYvEWk9/wWRwC1kpw/tbd8rTiAWAoC5TN4t6yGLQKTOZ2hnfTxqRnrb0
         r0sA0ZYPrEag1qH/2ZhJUKZKLISUsRpN/NcKwO6GoAe8gF+k88mYOR9z13U5eXjwA+zr
         6wEg==
X-Gm-Message-State: ANoB5pmZCMGKBhhCHRORqd1c0ob6hLMqxxINXJ8VymEp8DayoONYBFjh
        z/FvPO4k8AO527gli5e3XSJt0nLQmNEwENdZqHnNjiqcTtxk8eNhG7EnlIJQxm1XPw0HFfIy4M5
        IhKoa0ewftpTHHk1t9mjNl40=
X-Received: by 2002:ac8:4e51:0:b0:3a5:2704:d4bd with SMTP id e17-20020ac84e51000000b003a52704d4bdmr74303347qtw.16.1671444918009;
        Mon, 19 Dec 2022 02:15:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5bm5Qnb85eW38Qmkj26T6UAoQXiAZKZbsD/6lF6kYKtBjYMui2UsCvc851kAw1QZmfTvQTLw==
X-Received: by 2002:ac8:4e51:0:b0:3a5:2704:d4bd with SMTP id e17-20020ac84e51000000b003a52704d4bdmr74303318qtw.16.1671444917765;
        Mon, 19 Dec 2022 02:15:17 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id r17-20020a05620a299100b006fb8239db65sm6819951qkp.43.2022.12.19.02.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:15:17 -0800 (PST)
Date:   Mon, 19 Dec 2022 05:15:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Li Zetao <lizetao1@huawei.com>, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk, kraxel@redhat.com,
        david@redhat.com, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, rusty@rustcorp.com.au,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
Message-ID: <20221219050716-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128042945-mutt-send-email-mst@kernel.org>
 <CACGkMEtuOk+wyCsvY0uayGAvy926G381PC-csoXVAwCfiKCZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtuOk+wyCsvY0uayGAvy926G381PC-csoXVAwCfiKCZQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 29, 2022 at 11:37:09AM +0800, Jason Wang wrote:
> >
> >
> > Quite a lot of core work here. Jason are you still looking into
> > hardening?
> 
> Yes, last time we've discussed a solution that depends on the first
> kick to enable the interrupt handler. But after some thought, it seems
> risky since there's no guarantee that the device work in this way.
> 
> One example is the current vhost_net, it doesn't wait for the kick to
> process the rx packets. Any more thought on this?
> 
> Thanks

Specifically virtio net is careful to call virtio_device_ready
under rtnl lock so buffers are only added after DRIVER_OK.

However we do not need to tie this to kick, this is what I wrote:

> BTW Jason, I had the idea to disable callbacks until driver uses the
> virtio core for the first time (e.g. by calling virtqueue_add* family of
> APIs). Less aggressive than your ideas but I feel it will add security
> to the init path at least.

So not necessarily kick, we can make adding buffers allow the
interrupt.



-- 
MST

