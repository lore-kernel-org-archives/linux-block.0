Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD7C32771
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 10:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiI1KEL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiI1KDm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 06:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B59BF1D4A
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664359395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uGN/gn+YJZ4VIu5yaP7PXBIwmM0Ss1jImh/D5mV3zS0=;
        b=ZTKEVzp/8jt+gc7YokwfQkqJfgY3CUCb5I85vlViXoLUKueXNKO7YClZesZcHpGhNeH7E3
        /H1vO3dcos/dWokBOe1g30vB8tiILV7AIs+CNHk0ihm8JUYYvmj74J7EueGMUO0PuVucXc
        kEMIbqXgbWg1uGiFpKVNiYXyYX6uiu0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639--8-vNa5qO56zqqszADQ8wQ-1; Wed, 28 Sep 2022 06:03:13 -0400
X-MC-Unique: -8-vNa5qO56zqqszADQ8wQ-1
Received: by mail-wm1-f70.google.com with SMTP id p9-20020a05600c23c900b003b48dc0cef1so398623wmb.1
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 03:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uGN/gn+YJZ4VIu5yaP7PXBIwmM0Ss1jImh/D5mV3zS0=;
        b=0JtES3LzRtzC5To/lpXHVNIQOlGbfgueb6vL0gDOaKpuHyaJNDkzv+9ncUe5p5l3ep
         /xha3Rj41xixrSUZWV6hhnxjhq6e8oeFSZDRhOqCuv3oNBfQ9qqLElXgXm16nbKJ9L+T
         s5aPk4Jd1yVnHihlnCZ8jxEZ/456U7J69pI9m1APyNdyv7P7SqOyVdMm90PrRW1BuJh3
         orzD8umDqem5E7ySf583mkRIt5ntUBdtVKJscU9sVHzn5SPCuhs9v3HNPqPqh/bvzRtV
         f2TDwJK25/kxUek+YUhNdJCBvkXKmZWFsagu3CXOTCamDLpG24Cw+wYo6vTrkmrVyKAn
         SvhA==
X-Gm-Message-State: ACrzQf0emYikuDhKkYzA2eSpY+Eca6TNHwMSAfKQNOcfdLBEiTgnZRWO
        wIxE0LKlG2OJHV3mLmb3FiPWbD2yHO7aftta8h6HNNSIDQ3jRmBizM3Ks+NlzbtIcXXvl+rNRdi
        TfTQyFbgpNT/4VHKvFlxjmU8=
X-Received: by 2002:a05:6000:1845:b0:22a:4b7a:6f55 with SMTP id c5-20020a056000184500b0022a4b7a6f55mr19857124wri.288.1664359392581;
        Wed, 28 Sep 2022 03:03:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6DD+7gws/rgYCF8YbDNblzEgE00DKcFR13//n9kKka+r2jpPDo/QMjf3VuTYnwOCnvOIKbew==
X-Received: by 2002:a05:6000:1845:b0:22a:4b7a:6f55 with SMTP id c5-20020a056000184500b0022a4b7a6f55mr19857103wri.288.1664359392370;
        Wed, 28 Sep 2022 03:03:12 -0700 (PDT)
Received: from redhat.com ([2.55.17.78])
        by smtp.gmail.com with ESMTPSA id q16-20020adfcd90000000b0022cbf4cda62sm4051657wrj.27.2022.09.28.03.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:03:11 -0700 (PDT)
Date:   Wed, 28 Sep 2022 06:03:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>, jasowang@redhat.com,
        pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liming Wu <liming.wu@jaguarmicro.com>, stefanha@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Message-ID: <20220928055718-mutt-send-email-mst@kernel.org>
References: <20220924034854.323-1-angus.chen@jaguarmicro.com>
 <20220927163723-mutt-send-email-mst@kernel.org>
 <20220928094545.GA19646@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928094545.GA19646@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 28, 2022 at 11:45:45AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 27, 2022 at 04:47:20PM -0400, Michael S. Tsirkin wrote:
> > > The log :
> > > "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
> > > was print because of the irq 0 is used by timer exclusive,and when
> > > vp_find_vqs called vp_find_vqs_msix and return false twice,then it will
> > > call vp_find_vqs_intx for the last try.
> > > Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
> > > flag IRQF_SHARED.
> > 
> > First this is a bug. We can fix that so it will fail more cleanly.
> > 
> > We should check pci_dev->pin and if 0 do not try to use INT#x
> > at all.
> > It will still fail, just with a nicer backtrace.
> 
> How do we end up with a pci_dev without a valid PIN?

This patch is broken but there's no v3 which looks right,
and includes an explanation.

>  Btw, that whole
> vp_find_* code looks extremely fucked up to me.  The whole point of
> pci_alloc_irq_vectors* API is that it keeps drivers from poling into
> details of MSI-X v MSI vs INTX.

Poking? I think that code predates that, a minimal change was
made to support affinity... but again, it does not look like the
main issue has anything to do with that. Or maybe I'm wrong ...

> > - because of auto affinity, we try to reserve an interrupt on all CPUs
> > - as there are 512 devices with a single vector per VQ we would
> >   have no issue as they would be spread between CPUs,
> >   but allocating on all CPUs fails.
> > 
> > 
> > I don't think the issue should be fixed at blk level - it is not
> > blk specifix - but yes this looks like a problem.
> > Christoph, any idea?
> 
> I think this goes into the low-level interrupt vector allocator.  I think
> Thomas is still the expert on it.

syzbot is also telling us there's an issue in next (and not due to
virtio changes - I intentionally removed most of them for a while
and the issue was there) but I could not figure it out.

-- 
MST

