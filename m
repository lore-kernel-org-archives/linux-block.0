Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07501C433EF
	for <linux-block@archiver.kernel.org>; Fri, 27 May 2022 10:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbiE0KTe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 May 2022 06:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbiE0KTd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 May 2022 06:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AD011269A9
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653646771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0t2zU9MXz4VT6MECWOHvsoDoBu3fXaqhY69+YDYTXFs=;
        b=iSthZXA6Zjt4uw3ofPtU05aaQc3w4+6gIUKWFHjL4dD4szFfcY2YYAwVrS5IaLlp9tta5A
        ck67FDaIwDVHR+p6u0lw9uPcpBoKuMCqYbzEK5BhffZTtRZZUTtnJnxX7yiL/OJGO5cWpl
        EC5d0mIVZs4v/GElmTTcHMTzm5AMnb8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-h3Z6-r8ROvKzm25PUVbvKA-1; Fri, 27 May 2022 06:19:30 -0400
X-MC-Unique: h3Z6-r8ROvKzm25PUVbvKA-1
Received: by mail-ej1-f69.google.com with SMTP id v13-20020a170906b00d00b006f51e289f7cso2159609ejy.19
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 03:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0t2zU9MXz4VT6MECWOHvsoDoBu3fXaqhY69+YDYTXFs=;
        b=26PDbVpUWFdBKF8vJNSLmLamiwBs9Iijtl+qjB8kuPS3P7GPaA+fhCMssUx9qvmPX2
         +Xy0qgRIlpHVHqkmzXF0m5SPDkZdg3BSPLOw0hUBBrGQjS6N2dfmxNmaDJ0xPkFyny73
         2b852brKX55G+a8EaV6o8OS5AgQbA0XGhTl+Om9ueAT0DF8iWVA+6RPa9uzuhIYmRALF
         HsuOYQe4pr9S/uuV1BPT2MAKgbOfT4nBVI5pdmAHRLutjg+F8il+bwBLqlV7jvUtEqPE
         7CCYbNZl+b+J3Hsdgm8hBhtPvAxe43Fo90OOSTDHMUhNdKp0HD+YkqY1rubhR4lbb/St
         Gl5A==
X-Gm-Message-State: AOAM531/+jzUlYUcg32cgdGJm72yTQe+msi1qYFCb6IdVbJDGNQfwwjl
        RIK3nSwArCd7C72o6HCGCfQVUdGtCC+OzK4dkwBucWBKv9zLKjdLVB5LRp0n846w+rK1nhdahOC
        ljnq6yiUqXdiftnXFLJ05LTg=
X-Received: by 2002:aa7:cc01:0:b0:42a:402b:b983 with SMTP id q1-20020aa7cc01000000b0042a402bb983mr44184447edt.257.1653646768543;
        Fri, 27 May 2022 03:19:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2w1aOFqWoL18Qhgq6ACsfKPjRn/tewWbSjC97sWOBqBfI9rnw+ZKnDTyxZqb0tSdLhb6XOg==
X-Received: by 2002:aa7:cc01:0:b0:42a:402b:b983 with SMTP id q1-20020aa7cc01000000b0042a402bb983mr44184423edt.257.1653646768272;
        Fri, 27 May 2022 03:19:28 -0700 (PDT)
Received: from redhat.com ([2.55.130.213])
        by smtp.gmail.com with ESMTPSA id s23-20020a1709064d9700b006fe8b3d8cb6sm1338752eju.62.2022.05.27.03.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:19:27 -0700 (PDT)
Date:   Fri, 27 May 2022 06:19:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kch@nvidia.com, jasowang@redhat.com, linux-block@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        keliu <liuke94@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] virtio-blk: remove deprecated ida_simple_XXX()
Message-ID: <20220527061845-mutt-send-email-mst@kernel.org>
References: <fa54e172-ef9d-fba5-ad37-72a6698c7cb8@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa54e172-ef9d-fba5-ad37-72a6698c7cb8@wanadoo.fr>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 27, 2022 at 10:04:46AM +0200, Christophe JAILLET wrote:
> (Resend, my email client sent it as HTML. So sorry for the duplicate)
> 
> 
> Hi,
> 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 74c3a48cd1e5..e05748337dd1 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -720,8 +720,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> > 		return -EINVAL;
> > 	}
> >
> >-	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> >-			     GFP_KERNEL);
> >+	err = ida_alloc_max(&vd_index_ida, minor_to_index(1 << MINORBITS),
> >+			    GFP_KERNEL);
> > 	if (err < 0)
> > 		goto out;
> > 	index = err;
> 
> 
> this patch, already applied to -next, is wrong.
> 
> 
> The upper bound of ida_simple_get() is exlcusive, while the one of
> ida_alloc_max() is inclusive.
> 
> So, 'minor_to_index(1 << MINORBITS)' should be 'minor_to_index(1 <<
> MINORBITS) - 1' here.
> 
> 
> (adding keliu in cc: because he is proposing the same kind of patches, so he
> will see how to to these changes that are slighly tricky)
> 
> 
> CJ

I will drop this for now, please resend with either
a corrected version or a comment explaining why it's correct.

Thanks!

-- 
MST

