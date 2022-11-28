Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822A2C433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 10:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiK1KPo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 05:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiK1KPm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 05:15:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFD213E36
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 02:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669630487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBqAwBRWRjtW0ICmoI0uX4BeXltXbya2cc38sf5NvgE=;
        b=Jok5diD349xXsNGnd7Y3yasef1IwrCziYi3AQ5iENZ2xI11Qa3U6ORAkieCm1JH8f1XpyP
        AwD6YAxGiZwwf2vkExqyMKRoK6NajXF46QesT1m4e8P7uCxr0Afa+T8ZpieYWA4tRw2Oko
        zfo6vBcJmfaVUTJ4c+NuLIsUZxIF0Dc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-530-b4NnN_jJNqePgk7o7cQMbg-1; Mon, 28 Nov 2022 05:14:45 -0500
X-MC-Unique: b4NnN_jJNqePgk7o7cQMbg-1
Received: by mail-wr1-f70.google.com with SMTP id l9-20020adfa389000000b00241f907e102so1709869wrb.8
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 02:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBqAwBRWRjtW0ICmoI0uX4BeXltXbya2cc38sf5NvgE=;
        b=ElJTrtAHdl/eskNGzxtDXPBGCfDuNvoCGl18be31qbiM0S/4dXEhIsldzU7Csz9A3f
         Dx8K/QRUskjAhMccXQXV30fk5+W/bR1Ro/xDB6YpLHgt6RpMyNqy35CeID+1sO0MCEFD
         mg252W8ZXr+LBgZwtLPaSsmduRjLkoDR7mAc4n80Y5WZmAQapjIciMwPEPtLrhX7Wvpp
         WGJJV5TwlToi6oQLd73t0PrLF1gq4pD94eAlq43X2GQdNx6cEQ4Eaj0qU6q/DK+yTuoo
         AImcCo9QDlGjg7MUoUP5o27fx+bBjKkzrTDAfB8XBUp/ziOAxGbjAbDjSy/XKnQ1Ce7z
         A7/Q==
X-Gm-Message-State: ANoB5plB+gcsDXnBj9ekn3ho90G8hFI9JKdGr71me5iyz6xWWPBrTpxJ
        5cbz7FRFCYr3Qupq0FskCyJvhmHD4ps00IFypkVCcBCRSX6dRzwdIFkFmAJLhry7SWTZO8vd2K2
        6GPM5GQfX6hE8lROUwn2xHYg=
X-Received: by 2002:adf:f302:0:b0:242:1dbc:2d29 with SMTP id i2-20020adff302000000b002421dbc2d29mr318245wro.609.1669630484334;
        Mon, 28 Nov 2022 02:14:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ewYVQblwq/AEaxJGpgSzFXdQ+34eT0h/HaNR6C/0BgeFYG90YGVYdSwR7BSPWiouADYG5SQ==
X-Received: by 2002:adf:f302:0:b0:242:1dbc:2d29 with SMTP id i2-20020adff302000000b002421dbc2d29mr318211wro.609.1669630484132;
        Mon, 28 Nov 2022 02:14:44 -0800 (PST)
Received: from redhat.com ([2.52.149.178])
        by smtp.gmail.com with ESMTPSA id a12-20020adfe5cc000000b0022cc3e67fc5sm10146135wrn.65.2022.11.28.02.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:14:43 -0800 (PST)
Date:   Mon, 28 Nov 2022 05:14:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk, kraxel@redhat.com, david@redhat.com,
        ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, rusty@rustcorp.com.au,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
Message-ID: <20221128042945-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128021005.232105-1-lizetao1@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 28, 2022 at 10:10:01AM +0800, Li Zetao wrote:
> This patchset fixes similar issue, the root cause of the
> problem is that the virtqueues are not stopped on error
> handling path.

I've been thinking about this.
Almost all drivers are affected.

The reason really is that it used to be the right thing to do:
On legacy pci del_vqs writes 0
into vq index and this resets the device as a side effect
(we actually do this multiple times, what e.g. writes of MSI vector
 after the 1st reset do I have no idea).

mmio ccw and modern pci don't.

Given this has been with us for a while I am inlined to look for
a global solution rather than tweaking each driver.

Given many drivers are supposed to work on legacy too, we know del_vqs
includes a reset for many of them. So I think I see a better way to do
this:

Add virtio_reset_device_and_del_vqs()

and convert all drivers to that.

When doing this, we also need to/can fix a related problem (and related
to the hardening that Jason Wang was looking into):
virtio_reset_device is inherently racy: vq interrupts could
be in flight when we do reset. We need to prevent handlers from firing in
the window between reset and freeing the irq, so we should first
free irqs and only then start changing the state by e.g.
device reset.


Quite a lot of core work here. Jason are you still looking into
hardening?



> Li Zetao (4):
>   9p: Fix probe failed when modprobe 9pnet_virtio
>   virtio-mem: Fix probe failed when modprobe virtio_mem
>   virtio-input: Fix probe failed when modprobe virtio_input
>   virtio-blk: Fix probe failed when modprobe virtio_blk
> 
>  drivers/block/virtio_blk.c    | 1 +
>  drivers/virtio/virtio_input.c | 1 +
>  drivers/virtio/virtio_mem.c   | 1 +
>  net/9p/trans_virtio.c         | 1 +
>  4 files changed, 4 insertions(+)
> 
> -- 
> 2.25.1

