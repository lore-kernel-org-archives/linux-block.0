Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017C7C47089
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 10:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiLGKWw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 05:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLGKWw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 05:22:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0F1C435
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 02:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670408515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lPzI0+evVSHS3ztOGGIP3CFHgC5aN3okr0QkVN6UmJ0=;
        b=XxqhSdMO3ZmBnSnuyb1+dDd4LLSqFogsTW24UMzyWLu5hOaQ+9HKM6V2KuhWP9N+2ShkZr
        5PSHSp+YbgEBsz+DsKWjAu2TOXI3V9WfFHgfa4DQicVb64xvnmRogjhrB7N/FxwC2/+bsE
        v2GVNUDKkU+j491woh1Ow96fbEe9rbs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-nLFSCZQ1Nv26VvxyhAF82A-1; Wed, 07 Dec 2022 05:21:54 -0500
X-MC-Unique: nLFSCZQ1Nv26VvxyhAF82A-1
Received: by mail-wm1-f71.google.com with SMTP id a6-20020a05600c224600b003d1f3ed49adso436321wmm.4
        for <linux-block@vger.kernel.org>; Wed, 07 Dec 2022 02:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPzI0+evVSHS3ztOGGIP3CFHgC5aN3okr0QkVN6UmJ0=;
        b=aSiysC4KN524wxXtqdbbxsZWnuvASy69vM3OHv3KCdiaamIQats1h+MMZrGlvGA+tn
         4+qvTIlo9c7WBUIoqWYYT2Jbf/cfJ8CbOWpPY7kF7yVWKQoUXyyK8I1Hm4WsD3HTbI4C
         1+AxRvh0BaLSEFDim845k9W2RdoAOvu3/nZZz56yj1B38gksWr1ROFXabfzdXXpTfDk/
         D8ypeDs8PxfYLfEeon3wyjPvEUfIjDDDa1D7MXQPsQzJguNeiQuD21kUzzBkSE+KqVqC
         3ueH9a1uM16yOob/tzbshfkmKtfepa/y6dKH4rJLCkVh7BbPdE2gETbVa37ZFY7lyoua
         uiqQ==
X-Gm-Message-State: ANoB5pnQATrQRe31XnTYSoPu6qqWPmjK7KBawBKQX3ymSkwBn1J8RQXW
        zK84HC0uc9UlswJZdH0cHO51iD7D/3oPE8UDGXah12BS4Ml33gXZUDOz6ydJGQc5zaowYUYGIET
        ic+6HX0ReySwLPv3OdLLz3hE=
X-Received: by 2002:a5d:6745:0:b0:242:7e6:a0a0 with SMTP id l5-20020a5d6745000000b0024207e6a0a0mr32733377wrw.512.1670408513092;
        Wed, 07 Dec 2022 02:21:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7DMVf3SQ+wTGuF0LUdq4DNgtoQvJFTl9h4t7vhp8I5BZbj8QdljNko1W2iVKGLUD6JkmsMhA==
X-Received: by 2002:a5d:6745:0:b0:242:7e6:a0a0 with SMTP id l5-20020a5d6745000000b0024207e6a0a0mr32733365wrw.512.1670408512850;
        Wed, 07 Dec 2022 02:21:52 -0800 (PST)
Received: from redhat.com ([2.52.154.114])
        by smtp.gmail.com with ESMTPSA id a3-20020adffac3000000b0024245e543absm13739316wrs.88.2022.12.07.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:21:52 -0800 (PST)
Date:   Wed, 7 Dec 2022 05:21:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221207052001-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5BCQ/9/uhXdu35W@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 06, 2022 at 11:35:31PM -0800, Christoph Hellwig wrote:
> This just seems like a horrible interface.  And virtio-blk should be
> a simple passthrough and not grow tons of side-band crap like this.
> 
> If you want to pass through random misc information use virtio-scsi
> or nvme with shadow doorbell buffers.

Christoph you acked the spec patch adding this to virtio blk:

	Still not a fan of the encoding, but at least it is properly documented
	now:

	Acked-by: Christoph Hellwig <hch@lst.de>

Did you change your mind then? Or do you prefer a different encoding for
the ioctl then? could you help sugesting what kind?

Thanks,

-- 
MST

