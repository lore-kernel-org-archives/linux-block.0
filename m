Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F69C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 16:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiDFQFW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbiDFQFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 12:05:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFCD4DC5B8
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 06:36:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s2so2482119pfh.6
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oLzrwcwVKbeLtq4d0GyQ5Yb1VFbRLaFYawc0s0e3Fcc=;
        b=Jid+wq0ecpyo8YNJ3MxJG096H1pQultuJCZLiSsBIF4uCG9mOTV1mNLdjnpwoC9stz
         2sLf+udnUQs9IpFY8D5SCG791YaWUi0g1ejb6BH4cGMLOhGnTDAY45+T2dcLU9ipQxGf
         IlA1FXzHDUS2aGMFD+6eJxZwXk6ZbZoVt4taMISPMsGAL6OAVFyjg3EsO4mzw1aTdf2b
         XUx5LPffPWcZyTWekpVFuSQ1y91s1OEwsPik/6NpjpQ/XnBgpztXXDOG10HilsGEYn9F
         GBu5JlNPDnrxjhbVsJc/gYA32WwhOK6EkiCCHVifYv1AxJ2rM7EGFO1H4fQYCJ84+9gu
         bAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLzrwcwVKbeLtq4d0GyQ5Yb1VFbRLaFYawc0s0e3Fcc=;
        b=oE9l5slfgyriI4rQtuTMtx63CtHMnCfbiECZKZE4pZYCWjq0AWMNVHel9LrWa/+OgB
         lEpDubyubnBXomuBro8Xa/GypQCTjTzDuOkw/im05L9dy1EBV9EUbKhCSV8jP6pjiFZ9
         /ibe4zrgiPogKTPJulgJGs8WV8gi1Bk1zYVFx6emlybXpb1HvHUUkK/zUk3n+LBIr75T
         +LAXKVTBUui5qdoW0YAwz1N0P88+z4B5o/oNLFB9voKagzy18AVCq8SE813Tsoow6gzi
         Aq3T+Zhq7k4k6/fdKCnaYH/jerGhjfxnP/RO4f494l1qctRroUAZGgxE6nxZLg4A6q4c
         xOqg==
X-Gm-Message-State: AOAM532ir++I07gSvkK0B2XNvIxuAthtPEsOSVtz9Le5d/WFxzVJBY7k
        viufLcDv9eTUCYGp48W55ZY=
X-Google-Smtp-Source: ABdhPJx0pR2TcK+9DuXTJ1DQHJiRVyok7NpRmBdmWiaaBNlWkYTg6LmHH9DNfF0Rjjkd0BHEYO/HtQ==
X-Received: by 2002:a05:6a00:2484:b0:4fa:997e:3290 with SMTP id c4-20020a056a00248400b004fa997e3290mr8842279pfv.37.1649252210010;
        Wed, 06 Apr 2022 06:36:50 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090ab28700b001ca9514df81sm5522528pjr.45.2022.04.06.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:36:48 -0700 (PDT)
Date:   Wed, 6 Apr 2022 22:36:42 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] virtio-blk: support polling I/O
Message-ID: <Yk2Xasrjam8Qq6gR@localhost.localdomain>
References: <20220405150924.147021-1-suwan.kim027@gmail.com>
 <20220405150924.147021-2-suwan.kim027@gmail.com>
 <MW5PR84MB18421588C1806B6E37FCECAEABE79@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB18421588C1806B6E37FCECAEABE79@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 06, 2022 at 01:43:55AM +0000, Elliott, Robert (Servers) wrote:
> 
> 
> > -----Original Message-----
> > From: Suwan Kim <suwan.kim027@gmail.com>
> > Sent: Tuesday, April 5, 2022 10:09 AM
> > Subject: [PATCH v5 1/2] virtio-blk: support polling I/O
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > @@ -81,6 +85,7 @@ struct virtio_blk {
> > 
> > 	/* num of vqs */
> > 	int num_vqs;
> > +	int io_queues[HCTX_MAX_TYPES];
> >  	struct virtio_blk_vq *vqs;
> ...
> >  };> @@ -565,6 +572,18 @@ static int init_vq(struct virtio_blk *vblk)
> >  			min_not_zero(num_request_queues, nr_cpu_ids),
> >  			num_vqs);
> > 
> > +	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
> > +
> > +	memset(vblk->io_queues, 0, sizeof(int) * HCTX_MAX_TYPES);
> 
> Using
>     sizeof(vblk->io_queues)
> would automatically follow any changes in the definition of that field,
> similar to the line below:

Thanks for the feedback. I think that memset is unnecessary because
all entries of vblk->io_queues[] is set.
I will remove it.

Regards,
Suwan Kim
