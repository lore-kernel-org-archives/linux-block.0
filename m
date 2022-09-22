Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B0DC6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 16:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIVQ5Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiIVQ5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 12:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA18F50AF
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663865826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yyt8s7rtR8wMMR0HFPkltZSreD1Ms3xAJkzr/utjGb0=;
        b=K3bOlocXLVja1EUkS8RrsouteZQw2K88cRHqytvDRvELneNpTxfIzz9e1JTIeYEDcce4sa
        QDe+FKvLDYRYeBx1+Qd2IWuVgCGHe4n+IgU5G3YTxGP1xeB0zgwKRX8H1d67jVvkywO0U7
        Mmuo+PQ0aSKkeSSVj9o1E6tR87l/zGs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-9W2gorBiNoKSnwvZILTXIw-1; Thu, 22 Sep 2022 12:57:04 -0400
X-MC-Unique: 9W2gorBiNoKSnwvZILTXIw-1
Received: by mail-wr1-f71.google.com with SMTP id v22-20020adf8b56000000b0022af189148bso3443622wra.22
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 09:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Yyt8s7rtR8wMMR0HFPkltZSreD1Ms3xAJkzr/utjGb0=;
        b=cyNarfigReBhMVAE1Fx5reh8lsuVjIP0x9M4h/HwOzM6/5cZ+zKRt7VTDdtAxRjEvj
         la9i+arWn1kn16wertKBSvvFsW8RJx3IaFufS0ggW3M878nhIXr3ZxfVng/L6wjvZWVn
         jyusLxMMB8EUNOTkra3+NkxDb+XVMxKDjD5uzN+WFD5h0jEMZj5sWQsGMVEzFuI5049f
         bwmXlT7bl00Z8oepXmI+Zcrtf2IIAQejbk3l+7zEwsQTjdKpWDKs5R9BXvcxXPHwfCQ2
         gH23GrR56bXSdRE7qD8wLw9Pk5HDJ9t9sDfHaIFqV/xn4GsJWK9Evj5lPuKyoxd0iT6D
         LTtQ==
X-Gm-Message-State: ACrzQf1MoyQ8l8W0+F5oc+GjUaVK2BurRgQRhssKWUUUP0ZOATTYrPPt
        B3vsUNa4WFiV7HHFhydfrCupTLeGX0WgQ51zxxSLLzlw5N7sQo0pPkFyeQA17RXAi7DZcXPo4bK
        DVykohijQ/MPj2DkdtMVOA0U=
X-Received: by 2002:a1c:f406:0:b0:3a5:d667:10 with SMTP id z6-20020a1cf406000000b003a5d6670010mr3153547wma.70.1663865821830;
        Thu, 22 Sep 2022 09:57:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5HQ9wUXgateIanUNTPd9egfTTPl/FeoXUYGmnE0AnooT0W5RTbRrdSGb3SrKD5a9/fCVNzKw==
X-Received: by 2002:a1c:f406:0:b0:3a5:d667:10 with SMTP id z6-20020a1cf406000000b003a5d6670010mr3153528wma.70.1663865821535;
        Thu, 22 Sep 2022 09:57:01 -0700 (PDT)
Received: from redhat.com ([2.55.16.18])
        by smtp.gmail.com with ESMTPSA id t2-20020adfe102000000b0022917d58603sm5691394wrz.32.2022.09.22.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:57:00 -0700 (PDT)
Date:   Thu, 22 Sep 2022 12:56:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     Pankaj Raghav <pankydev8@gmail.com>, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, acourbot@chromium.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <20220922125632-mutt-send-email-mst@kernel.org>
References: <20220830150153.12627-1-suwan.kim027@gmail.com>
 <20220831124441.ai5xratdpemiqmyv@quentin>
 <CAFNWusaxT38RyQBFZu6jN_kaL3p3hTQ0oXPQZkZdEJ3VjUMVWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFNWusaxT38RyQBFZu6jN_kaL3p3hTQ0oXPQZkZdEJ3VjUMVWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 22, 2022 at 11:45:15PM +0900, Suwan Kim wrote:
> Hi Michael,
> 
> Can this patch be merged to the next rc?
> We received two bug reports about this issue and need to fix it.
> 
> Regards,
> Suwan Kim
> 
> 
> On Wed, Aug 31, 2022 at 9:44 PM Pankaj Raghav <pankydev8@gmail.com> wrote:
> >
> > On Wed, Aug 31, 2022 at 12:01:53AM +0900, Suwan Kim wrote:
> > > If a request fails at virtio_queue_rqs(), it is inserted to requeue_list
> > > and passed to virtio_queue_rq(). Then blk_mq_start_request() can be called
> > > again at virtio_queue_rq() and trigger WARN_ON_ONCE like below trace because
> > > request state was already set to MQ_RQ_IN_FLIGHT in virtio_queue_rqs()
> > > despite the failure.
> > >
> > > To avoid calling blk_mq_start_request() twice, This patch moves the
> > > execution of blk_mq_start_request() to the end of virtblk_prep_rq().
> > > And instead of requeuing failed request to plug list in the error path of
> > > virtblk_add_req_batch(), it uses blk_mq_requeue_request() to change failed
> > > request state to MQ_RQ_IDLE. Then virtblk can safely handle the request
> > > on the next trial.
> > >
> > > Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> > > Reported-by: Alexandre Courbot <acourbot@chromium.org>
> > > Tested-by: Alexandre Courbot <acourbot@chromium.org>
> > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > ---
> > Looks good.
> > Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

Stefan, Paolo, any feedback here?

-- 
MST

