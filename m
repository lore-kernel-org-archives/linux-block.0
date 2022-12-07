Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700DFC63705
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 20:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLGU3Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 15:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLGU3W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 15:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7247530573
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 12:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670444899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ERzjyp7zk5Z5+YVLaxlhiooylxoMa/YnIAQSVI50Phc=;
        b=HNfgA+EBdik8a7ImgHBkU261GvxFLalqqOlJh1EE5gbfAPKF36NxpZa8qVD9wrzcp/adNT
        kS9kJ7FL/HlkELxVa5h3KDrkNaKqo5SjLZ9Qkd+LtmCb/zvAz8QwCddWEZMF/UmpTfVlaF
        ipCfryf8vSSMuMMY8CH4hRwRYnLZ5rY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-507-VFMp9BVeNfym3-D6XNncLA-1; Wed, 07 Dec 2022 15:28:18 -0500
X-MC-Unique: VFMp9BVeNfym3-D6XNncLA-1
Received: by mail-wm1-f72.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so1267480wme.7
        for <linux-block@vger.kernel.org>; Wed, 07 Dec 2022 12:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERzjyp7zk5Z5+YVLaxlhiooylxoMa/YnIAQSVI50Phc=;
        b=wM2k7/bdNcpxvdO82UEDQQeJbswoOT3JdrnbFX0Gi0BFvPmZJWuCmYtXhlDFy3x0XJ
         UIkp0TRUissXFMkz0K7PSu1qGHsJq5UNoIp2o0SWH6djwKwkcNa+qJRwPkQkiRSPiSTg
         qFRPoFX/tdamhYdXv0EqrewquREOrk2z/3kG3zBiHLBI2pOOIgEmHG1vJ7qvAw6lmRrD
         XC9BQUHJCfReClGcM6aqO4ERRrnhqCM4ZFIQhkWHt+4gcp/UL2aOwQ3N5vmYpmNbv5N8
         gFKmxfS5WVOK1jF0tX2OF5W78ieFS/3h7P0fQZoxn4zkg2nNHonmQs2EHaJ1/BsChGgu
         EHWg==
X-Gm-Message-State: ANoB5pmYvZyzEEi36FG9JRSFeZHsFrHybZ2al0uQMSHIrjQs5iQrOUiR
        G6lwqF0CUiV9Uj/5yX1Gvj/mIwvF9ezQj6cy0gcd6i44/zmBb92pgGt994NArz3uGUb04noSbis
        RmWLzjWFWuTLITdekCU2NkFk=
X-Received: by 2002:adf:f98e:0:b0:242:324:ff88 with SMTP id f14-20020adff98e000000b002420324ff88mr35473840wrr.81.1670444897079;
        Wed, 07 Dec 2022 12:28:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4QOq0RAPymVdkyXnh7/V2ZIzFLtZtJ+dwe3UW02/93b8NTVphp6L78PZAaWRCEXF7iho9Mtw==
X-Received: by 2002:adf:f98e:0:b0:242:324:ff88 with SMTP id f14-20020adff98e000000b002420324ff88mr35473829wrr.81.1670444896831;
        Wed, 07 Dec 2022 12:28:16 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:1a4f:ce60:357c:370b:cc7e])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b00241e8d00b79sm25007953wrw.54.2022.12.07.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:28:16 -0800 (PST)
Date:   Wed, 7 Dec 2022 15:28:10 -0500
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
Message-ID: <20221207152116-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org>
 <20221207052001-mutt-send-email-mst@kernel.org>
 <Y5C/4H7Ettg/DcRz@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5C/4H7Ettg/DcRz@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 07, 2022 at 08:31:28AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 07, 2022 at 05:21:48AM -0500, Michael S. Tsirkin wrote:
> > Christoph you acked the spec patch adding this to virtio blk:
> > 
> > 	Still not a fan of the encoding, but at least it is properly documented
> > 	now:
> > 
> > 	Acked-by: Christoph Hellwig <hch@lst.de>
> > 
> > Did you change your mind then? Or do you prefer a different encoding for
> > the ioctl then? could you help sugesting what kind?
> 
> Well, it is good enough documented for a spec.  I don't think it is
> a useful feature for Linux where virtio-blk is our minimum viable
> paravirtualized block driver.

No idea what this means, sorry.  Now that's in the spec I expect (some)
devices to implement it and if they do I see no reason not to expose the
data to userspace.

Alvaro could you pls explain the use-case? Christoph has doubts that
it's useful. Do you have a device implementing this?

-- 
MST

