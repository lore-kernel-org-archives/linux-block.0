Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808DCC433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 15:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6354F60F70
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 15:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhJXPv3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 11:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:61000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229782AbhJXPv2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 11:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635090547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iIwcOgxDydqUDrVTMb3PzkTwW1PIvsFo+sr+SoGyWp4=;
        b=Lezx+wcDzENcBlLvsQ0Zckk1dkY2EAnT/lH85Jq2/g0Z06FnwOv0I5SKYGi34FGYqPGMhG
        A2UNpzUG4v7ps6WZiRKlcmEcn3veiSf2XXGtbxGPDfiFSr/5hMwk3TnNUuSX+a1YSHcWjR
        99B9aRdoCb4FeYaHhV/1QGXc9wjSY+w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-34I8BehUNYS4FJttU_6kUg-1; Sun, 24 Oct 2021 11:49:06 -0400
X-MC-Unique: 34I8BehUNYS4FJttU_6kUg-1
Received: by mail-ed1-f72.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so7674182edx.15
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 08:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iIwcOgxDydqUDrVTMb3PzkTwW1PIvsFo+sr+SoGyWp4=;
        b=PDuTInjFjty+djqorfwtzqlhQR0RDqEg+sN9fWGhLHgN9w8irkRQZGm/Ld17g9NUte
         syp8X++1Q28hIEnyvYlb0SHGBy2eftb8jGcjVAQda0j/voGjW3tjNPyQYsdfylb/w2Le
         L3NRhl6yHHUNTRmQHaTMQnz8+Di2snb/cnT5DTQ2YQdGXuI4INWaEhCyDHV2Av1BbFAr
         XjKcP0IQgQwZKoEJe4YF5HdApxFpD79JGyaDPyDweuLBm8LdpcI+mTi2iZMtCpGcwpby
         4g/iUA+5AQs8ftIp/46py9zcY9Eo7aGHQwy2VPETJUp/1mLL5ERi+tWQFZDMVDpJdFLe
         sdow==
X-Gm-Message-State: AOAM533TjuJNJK4yvm5fgDsf2XXOxOdOZzCZ9/qpqgsDeBRgEAQD6VZX
        gTPzuqwn7AB2thoojHbAIefZkbDNK4HmhJO36XgO9kYg3VSSNDOekZ+M/Sn7HKGEila/AFI9xTA
        fOifQXqpymJENFHWpC4s2/rI=
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr18732578ede.377.1635090545011;
        Sun, 24 Oct 2021 08:49:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwceJaD3mgfUfOcL3JmT6ez6YIJACUuR4rgEbsYq8YD1WUQPLwHGdhd5PCLO6vxePnaWXJKGQ==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr18732560ede.377.1635090544850;
        Sun, 24 Oct 2021 08:49:04 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
        by smtp.gmail.com with ESMTPSA id j1sm7558360edk.53.2021.10.24.08.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 08:49:04 -0700 (PDT)
Date:   Sun, 24 Oct 2021 11:49:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: allow 0 as num_request_queues
Message-ID: <20211024114746-mutt-send-email-mst@kernel.org>
References: <20211024135412.1516393-1-mst@redhat.com>
 <855eb993-074b-24b9-a184-d479bd0b342b@nvidia.com>
 <20211024105841-mutt-send-email-mst@kernel.org>
 <a2060fc7-cc4d-c4d4-e7fe-e4a1e544104f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2060fc7-cc4d-c4d4-e7fe-e4a1e544104f@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 24, 2021 at 06:29:59PM +0300, Max Gurtovoy wrote:
> 
> On 10/24/2021 6:11 PM, Michael S. Tsirkin wrote:
> > On Sun, Oct 24, 2021 at 05:19:33PM +0300, Max Gurtovoy wrote:
> > > On 10/24/2021 4:54 PM, Michael S. Tsirkin wrote:
> > > > The default value is 0 meaning "no limit". However if 0
> > > > is specified on the command line it is instead silently
> > > > converted to 1. Further, the value is already validated
> > > > at point of use, there's no point in duplicating code
> > > > validating the value when it is set.
> > > > 
> > > > Simplify the code while making the behaviour more consistent
> > > > by using plain module_param.
> > > > 
> > > > Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
> > > > Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >    drivers/block/virtio_blk.c | 14 +-------------
> > > >    1 file changed, 1 insertion(+), 13 deletions(-)
> > > > 
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 6318134aab76..c336d9bb9105 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -30,20 +30,8 @@
> > > >    #define VIRTIO_BLK_INLINE_SG_CNT	2
> > > >    #endif
> > > > -static int virtblk_queue_count_set(const char *val,
> > > > -		const struct kernel_param *kp)
> > > > -{
> > > > -	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > -}
> > > > -
> > > > -static const struct kernel_param_ops queue_count_ops = {
> > > > -	.set = virtblk_queue_count_set,
> > > > -	.get = param_get_uint,
> > > > -};
> > > > -
> > > >    static unsigned int num_request_queues;
> > > > -module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> > > > -		0644);
> > > > +module_param(num_request_queues, uint, 0644);
> > > Not the best solution.
> > > 
> > > You can set the param to 1024 but in practice nr_cpu_ids can be 32 for
> > > example.
> > Well your patch does make it possible to know what nr_cpu_ids is.
> > But does it matter? The actual number of queues is still capped
> > by the num_queues of the device. And I'm concerned that some
> > userspace comes to depend on reading back nr_cpu_ids
> > from there, which will cement this as part of ABI instead of
> > being an implementation detail.
> > Exposing the actual number of queues in sysfs might make more sense ...
> > 
> > Generally you suggested embedded as a use-case, and I don't really
> > see lots of embedded userspace poking at this parameter in sysfs.
> > 
> > What I'd like to see, and attempted to achieve here:
> > - avoid code duplication
> > - consistency: some way to specify the parameter but still make it have the default value
> > 
> > Better suggestions are welcome.
> 
> Just change return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> 
> to
> 
> return param_set_uint_minmax(val, kp, *0*, nr_cpu_ids);
> 
> The real amount can be exposed by common sysfs.
> 
> We'll extend virtio_driver to have a new callback to return this value. If
> callback doesn't exist - return -1 (unknown value).

That doesn't avoid code duplication - the limit of nr_cpu_ids
is applied twice.

> > 
> > > >    MODULE_PARM_DESC(num_request_queues,
> > > >    		 "Limit the number of request queues to use for blk device. "
> > > >    		 "0 for no limit. "

