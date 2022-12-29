Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C87EC4332F
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 13:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiL2Ncr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 08:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiL2NcU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 08:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DA56240
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672320694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1D/AekxKLpAcu+bYl7a0bmZjxWv5ZDkXjJgeYIo+ziA=;
        b=A8FCwENg4lfwHjerPdCCN7PAHQml/Go7Oii6d5xcYY+9DzUP+IAtnQ94WVdFV0xMD6a5uL
        rBOnEj/yz3oYNOUuaW7f2SBk5510Hhl0L0NdClSNGpHkWimNZ/4HeYXxQ/3zy6CExrBEK4
        uH9JMIZdUPkFe00CWiTtmlgOq99pVrg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-LCUTScvNOsCTsEZWZDZswA-1; Thu, 29 Dec 2022 08:31:32 -0500
X-MC-Unique: LCUTScvNOsCTsEZWZDZswA-1
Received: by mail-wm1-f70.google.com with SMTP id m38-20020a05600c3b2600b003d1fc5f1f80so12668819wms.1
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 05:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D/AekxKLpAcu+bYl7a0bmZjxWv5ZDkXjJgeYIo+ziA=;
        b=z5niHOfcpVJRinC/m0xzHQEthIwDwVQsf1FHo5oJJD1Qcl9Gk9xksfiUkYzFiKhV1h
         2e2Pzy2CHPdc3NvuB3aykrNjDfS45HH6Bcjb4T3I3QnqwngOia9rov3hgtIU7knFmQ3o
         IEYerYZGOjp6uyyOhcndxlq4DqMjpfdVyR+/LGqcvD5EFQbAb9RHgC4kNGeGMRAtliGT
         Drf2cEG3HGdg+cvN9xlq2DVzEOECDXZOI6oYhlCKitJF+IWrsSo+HUVrUx4/Tv5l6WhZ
         zsLP8BZ3+p8zmh8742iIKqVAEaTyr8wNR+mgHOsMzGP/HqAS9ak80MR7S3R5LQgeqKZF
         qtYg==
X-Gm-Message-State: AFqh2kqHFtitX1zZlznRpxbSBZbqlGJdOVlKXTofkauMkYJ5UtFwEsfD
        oD7Jabho1cezEEeFQOUIHX2o90KHmZEcHrn5zB3kB2P0765Zn1e+23tgBH7eCoFjjVHChWuA7cA
        tQ3oF18r7fL72nLlWf6pfOlc=
X-Received: by 2002:adf:e409:0:b0:242:45e7:db17 with SMTP id g9-20020adfe409000000b0024245e7db17mr16250526wrm.66.1672320691716;
        Thu, 29 Dec 2022 05:31:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsWnvN6QyVN1zTOnSfNKEdIudugUP7fkbiKn5gbdcdRZxKN6fb0RQ8JfBa58bamIqgqaTnuhg==
X-Received: by 2002:adf:e409:0:b0:242:45e7:db17 with SMTP id g9-20020adfe409000000b0024245e7db17mr16250519wrm.66.1672320691497;
        Thu, 29 Dec 2022 05:31:31 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb51000000b0027cb20605e3sm10757933wrs.105.2022.12.29.05.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 05:31:30 -0800 (PST)
Date:   Thu, 29 Dec 2022 08:31:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221229082943-mutt-send-email-mst@kernel.org>
References: <20221219122155.333099-1-alvaro.karsz@solid-run.com>
 <20221229030850-mutt-send-email-mst@kernel.org>
 <CAJs=3_ApAnMTC0O81vO=hvRLssLYRnJsVUE5gd_aomCB+5eWLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs=3_ApAnMTC0O81vO=hvRLssLYRnJsVUE5gd_aomCB+5eWLQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 29, 2022 at 02:08:34PM +0200, Alvaro Karsz wrote:
> > So due to my mistake this got pushed out to next linux release.
> > Sorry :(
> 
> No problem at all :)
> 
> > I'd like to use this opportunity to write a new better
> > interface that actually works with modern backends,
> > and add it to the virtio spec.
> >
> > Do you think you can take up this task?
> 
> Sure, I can do it.
> So, the idea is to:
> 
> * Drop this patch
> * Implement a new, more general virtio block feature for virtio spec
> * Add linux support for the new feature
> 
> right?

That's certainly an option.
Let's start with point 2, and get ack from people who objected to this
feature.


-- 
MST

