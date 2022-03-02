Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92171C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 13:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiCBNQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242090AbiCBNQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 08:16:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AD5DC42A1
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646226932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Du9bGCJyeYUBZfdICrU8RSrBiIwvIrsG9nwUtijwSEs=;
        b=OSWg5Lq1SuaxO9Y3iiSKXrfdF+qgOGkG00yqtbgYMIEhqzLoYv7EjVrr6V2ZenVDjQiMab
        7qQV8ueKlvkdiCmzeN4lGADnMTSKy/Apppa6QjU2xSQfq8dKIUL4kPHr+e4QerPFis3uZI
        VrygsxbfzsQjhDjS+mIrayvBbbvutfs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-llHcHMX1NSi42IsjLtp0zA-1; Wed, 02 Mar 2022 08:15:31 -0500
X-MC-Unique: llHcHMX1NSi42IsjLtp0zA-1
Received: by mail-wm1-f69.google.com with SMTP id v67-20020a1cac46000000b00383e71bb26fso384835wme.1
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 05:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Du9bGCJyeYUBZfdICrU8RSrBiIwvIrsG9nwUtijwSEs=;
        b=3MUwbZnegZILjBsEkv8qW6lvd0n/h2gisZFlM+4HdAndfVLDRZ/ogFYFbQqMnlQVZp
         /8+picfrPntb2Pn7P+mn5Gbl4EA+Ws6KwGuXZEigsFfXGzrdcyuhh/VD+nGBz2wXHiT1
         vaQY4M4G7P2VRuhgnxSQQse668rYadDT3qpXyQSJvkbvvyWSD3MMVghqen5MEswb3vka
         RxbivvkD+LnEmEjIiaHgq7vQomDRCflITyk1fhBRlr0k4BPAD78UUjYRhre692v3J9Uy
         bL/HxGtpZueZh3Hmtttb38qAhUrZoCx1OA5cq2f7CtpgAl90JUOrs8g903TDXMBiCW0F
         2v/Q==
X-Gm-Message-State: AOAM532UpjIPNoCl7PlElgzW6tp3HsPWdxbHyUpfmu5YPLMM75BXJkBU
        P0joCYcZjd8cuH2YnqlEY63fp3PJzJ/T59W5ox0HD8nwg/DMyBmd2i+Y33VFSp2wKYKAQRHrLeH
        rJEjJ+BReHMimc7sew4iPg40=
X-Received: by 2002:a05:600c:252:b0:381:3461:1c64 with SMTP id 18-20020a05600c025200b0038134611c64mr21144416wmj.94.1646226930026;
        Wed, 02 Mar 2022 05:15:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZJmM2k8Z2gkRZ6tQ2eyXfqvnd5MRyL0aZPeaUpRONJZZWaNLdaPzAsWX9cAQOFDBaEdSYZw==
X-Received: by 2002:a05:600c:252:b0:381:3461:1c64 with SMTP id 18-20020a05600c025200b0038134611c64mr21144400wmj.94.1646226929824;
        Wed, 02 Mar 2022 05:15:29 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id f16-20020adff450000000b001f0122f63dbsm5028342wrp.86.2022.03.02.05.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:15:28 -0800 (PST)
Date:   Wed, 2 Mar 2022 08:15:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220302081017-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <CACycT3uGFUjmuESUi9=Kkeg4FboVifAHD0D0gPTkEprcTP=x+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3uGFUjmuESUi9=Kkeg4FboVifAHD0D0gPTkEprcTP=x+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 02, 2022 at 06:46:03PM +0800, Yongji Xie wrote:
> On Tue, Mar 1, 2022 at 11:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > Currently we have a BUG_ON() to make sure the number of sg
> > > list does not exceed queue_max_segments() in virtio_queue_rq().
> > > However, the block layer uses queue_max_discard_segments()
> > > instead of queue_max_segments() to limit the sg list for
> > > discard requests. So the BUG_ON() might be triggered if
> > > virtio-blk device reports a larger value for max discard
> > > segment than queue_max_segments().
> >
> > Hmm the spec does not say what should happen if max_discard_seg
> > exceeds seg_max. Is this the config you have in mind? how do you
> > create it?
> >
> 
> One example: the device doesn't specify the value of max_discard_seg
> in the config space, then the virtio-blk driver will use
> MAX_DISCARD_SEGMENTS (256) by default. Then we're able to trigger the
> BUG_ON() if the seg_max is less than 256.
> 
> While the spec didn't say what should happen if max_discard_seg
> exceeds seg_max, it also doesn't explicitly prohibit this
> configuration. So I think we should at least not panic the kernel in
> this case.
> 
> Thanks,
> Yongji

Oh that last one sounds like a bug, I think it should be
min(MAX_DISCARD_SEGMENTS, seg_max)

When max_discard_seg and seg_max both exist, that's a different question. We can
- do min(max_discard_seg, seg_max)
- fail probe
- clear the relevant feature flag

I feel we need a better plan than submitting an invalid request to device.

-- 
MST

