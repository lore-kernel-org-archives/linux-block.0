Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375A6C3A5A7
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 16:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiLFQmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiLFQl7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 11:41:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61438CE8
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 08:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670344816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6ge3pwq/JlMlTkSjEGqqkwIK42+btCPQr7/pr8xaxyc=;
        b=DeK9UUHZA+NXpCyFrPUwn6263SV/bUmTLRlrUJ8KotrAoWMmNl+8u1ulmJYs6jnpZft6hB
        XHBdm8APdFuzvY2ltJ4AUVtLXA7HncFGNU3pTL8xUDEEdBpbeO7bXVf6lnAtNpFTWCEcEq
        dmKTTqStNT2VVesIDxjFj4Qm7WWYQ68=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-2nWASnlaOYe0PE9zI87BYQ-1; Tue, 06 Dec 2022 11:40:14 -0500
X-MC-Unique: 2nWASnlaOYe0PE9zI87BYQ-1
Received: by mail-wr1-f70.google.com with SMTP id k1-20020adfb341000000b0024215e0f486so3405582wrd.21
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 08:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ge3pwq/JlMlTkSjEGqqkwIK42+btCPQr7/pr8xaxyc=;
        b=zpQpVV3nJt4Zf4HG8/dxPBpQ+sQZX2tr8Rlz6Yd7KJcOTqEIvNHY3/5iq1eAnq7Kt8
         cf6ZKbG8k7a7PiLoKR4tuYB8eZdyMJL9Lj8Wcyr0ooxiN29qiunMXwOhBq3GKRzM1PO8
         twg1IuxetyAOdBD3jObujir0whyi2yA3Un1m8cqXzsNJ8XLya8sx011rK3F8aGQZZm8q
         Cu6BDbHqdDRhGgIuor7moLZXX/w4Q1v1yk2/o03UfEBHx1j63TrEcmq6K4vpgzbR5D39
         8KymYBA7IyPjv9hiSRzKufdI8OnLH/yxF1IG7koIzNvZkwmLDab5ZOL7DXiiYXlm/WnQ
         /93Q==
X-Gm-Message-State: ANoB5pnFKutC9XL5la0XyyEK6bH5hziqWfR0COlm2rB8EXo5NLcu/obU
        tGU1cAx8yV+0X4znKp2pCJiHNvFuVf1tWLBtZt+7vyufG2nz8hOXIpgxJl/skVqsVd3aDrBZJoB
        Vl8JPWKvZvznEZiVJHBaBCCk=
X-Received: by 2002:a05:600c:43d6:b0:3cf:a856:ba2f with SMTP id f22-20020a05600c43d600b003cfa856ba2fmr54374398wmn.37.1670344813013;
        Tue, 06 Dec 2022 08:40:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4NVS4Nr5mwzewnBswh2mp5LN3uIb1H6IjnbaF2zAiGYSd8n0GAdY9XUcgUa+xExhq9zeGgKw==
X-Received: by 2002:a05:600c:43d6:b0:3cf:a856:ba2f with SMTP id f22-20020a05600c43d600b003cfa856ba2fmr54374381wmn.37.1670344812837;
        Tue, 06 Dec 2022 08:40:12 -0800 (PST)
Received: from redhat.com ([109.253.207.7])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003c6cd82596esm29427965wmq.43.2022.12.06.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:40:12 -0800 (PST)
Date:   Tue, 6 Dec 2022 11:40:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221206113744-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y49ucLGtCOtnbM0K@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49ucLGtCOtnbM0K@fedora>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 06, 2022 at 11:31:44AM -0500, Stefan Hajnoczi wrote:
> On Mon, Dec 05, 2022 at 06:20:34PM +0200, Alvaro Karsz wrote:
> 
> I don't like that the ioctl lifetime struct is passed through
> little-endian from the device to userspace. The point of this new ioctl
> is not to be a passthrough interface. The kernel should define a proper
> UABI struct for the ioctl and handle endianness conversion. But I think
> Michael is happy with this approach, so nevermind.
> 
> > @@ -219,4 +247,8 @@ struct virtio_scsi_inhdr {
> >  #define VIRTIO_BLK_S_OK		0
> >  #define VIRTIO_BLK_S_IOERR	1
> >  #define VIRTIO_BLK_S_UNSUPP	2
> > +
> > +/* Virtblk ioctl commands */
> > +#define VBLK_GET_LIFETIME	_IOR('r', 0, struct virtio_blk_lifetime)
> 
> Does something include <linux/ioctl.h> for _IOR()? Failure to include
> the necessary header file could break userspace applications that
> include <linux/virtio_blk.h>.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Good point. I think it's preferable to add a new header
for this stuff. virtio_blk_ioctl.h ? Have that pull in linux/ioctl.h
Also VIRTIO_BLK_IOCTL_GET_LIFETIME
might be a better name to avoid confusion and collisions.
And s/Virtblk/virtio-blk/

-- 
MST

