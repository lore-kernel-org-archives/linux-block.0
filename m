Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B0AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 12:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCB861056
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 12:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhJMMxr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232949AbhJMMxq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 08:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634129503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/7FiCB1ISKOEoQmv0h0vU/4qoNS1mIBBsK6BA/38aI=;
        b=eQS7Da+meQrkDunshiehhtY1ofFpXtpZtF/twq99yQcJcmUJMxuoTZ2UJsa0BHsLHc8jj/
        ZHCTLf0Ko/8V4tFPq3QoU4wsxJ2TWm1Isj2B8XxVKp/xSLwGWxUy/RKoFQlTWKnwGYkTK7
        Xyfex4ajtKs1xhO/X87muA8CgVTcxv4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-hCbcuFxzMgixxsf8J7ONOA-1; Wed, 13 Oct 2021 08:51:42 -0400
X-MC-Unique: hCbcuFxzMgixxsf8J7ONOA-1
Received: by mail-wr1-f69.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so1893929wrc.9
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 05:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/7FiCB1ISKOEoQmv0h0vU/4qoNS1mIBBsK6BA/38aI=;
        b=dUnSbXnarqaTZxAnInd84k/j68jCOdaASAYbNYYbEg+e4Z7lO6g0WmaOFdgUmpOBsg
         1j6+yD9Z0Gjs+2ukxRlEYe54whdBKJv+9dT6Rsm/Xg87U4xp5zzF1DUmCt712jLag2C2
         RIN7jkm3mrFZZR4j6waH7GCA5Tkpm789/6N5JDoTG8hkWnp4ztpNG0xhbU4WKrRpKzGw
         VgkCzPPEPYd2hgAQAdUgbJApAs8KurKpkaCmT4edF44Esqbf3J5+VMgiaeRBjd5CzmrY
         7ofl+koua23v68HY/1J+U4Q0TlFww9r5AS4A9lFa+rVzZtdpLLdWr3DMXcXWrUlSmotB
         6mAw==
X-Gm-Message-State: AOAM531sE0u/YRl0rnlKFZdb2EY+DqBHjulN82TrHp/YMEppWMkSVJgp
        34RdcG+YO4o+CaE1GSP2Dfx+7ym1D3MqRYeMiyzeNIOFZSu3Dnax8x1UXpTs9QoQ4PU3qO0gFJM
        l23RQQqrCujFJvSqYYpnQXUI=
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr12443699wmp.65.1634129500756;
        Wed, 13 Oct 2021 05:51:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxXShSsCgY6/PDbrJUPITVtStrZWvnffqdaNuTNNoDSChn1zbY5sZOccceeIhneM0FjogR/A==
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr12443682wmp.65.1634129500615;
        Wed, 13 Oct 2021 05:51:40 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id j1sm16548759wrb.56.2021.10.13.05.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:51:40 -0700 (PDT)
Date:   Wed, 13 Oct 2021 08:51:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kevin Wolf <kwolf@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211013084711-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <20211004112623-mutt-send-email-mst@kernel.org>
 <20211005062359-mutt-send-email-mst@kernel.org>
 <20211011114041.GB16138@lst.de>
 <20211013082025-mutt-send-email-mst@kernel.org>
 <CACycT3skLJp1HfovKP8AvQmdxhyJNG6YFrb6kXjd48qaztHBNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3skLJp1HfovKP8AvQmdxhyJNG6YFrb6kXjd48qaztHBNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 08:34:22PM +0800, Yongji Xie wrote:
> On Wed, Oct 13, 2021 at 8:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 01:40:41PM +0200, Christoph Hellwig wrote:
> > > On Tue, Oct 05, 2021 at 06:42:43AM -0400, Michael S. Tsirkin wrote:
> > > > Stefan also pointed out this duplicates the logic from
> > > >
> > > >         if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
> > > >                 return -EINVAL;
> > > >
> > > >
> > > > and a bunch of other places.
> > > >
> > > >
> > > > Would it be acceptable for blk layer to validate the input
> > > > instead of having each driver do it's own thing?
> > > > Maybe inside blk_queue_logical_block_size?
> > >
> > > I'm pretty sure we want down that before.  Let's just add a helper
> > > just for that check for now as part of this series.  Actually validating
> > > in in blk_queue_logical_block_size seems like a good idea, but returning
> > > errors from that has a long tail.
> >
> > Xie Yongji, I think I will revert this patch for now - can you
> > please work out adding that helper and using it in virtio?
> >
> 
> Fine, I will do it.
> 
> Thanks,
> Yongji

Great, thanks! And while at it, pls research a bit more and mention
in the commit log what is the result of an illegal blk size?
Is it memory corruption? A catastrophic failure?
If it's one of these cases, then it's ok to just fail probe.

-- 
MST

