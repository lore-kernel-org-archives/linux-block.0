Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC68C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 21:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A1460E05
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 21:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhJYVM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230076AbhJYVMZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 17:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635196202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jiCj1Dd83x3citihACVoPC1hMPCA+Vsk0IBZb4n1UuI=;
        b=Wif2wuwEPBfRwRvzDtBGoLTfyikVlrgPFBx5G2+WpskD6kZ7VxzlrHe8vQipxUKxcCG6Xa
        ODOo0H1+05mZ8wBg9tAMVN60lJBjtAg5kNJW4wbhSBGAWFvf8PAUvWIBrmv7hth9CYWyAQ
        v+YHWyAjyYW34oUdusSvpXy+B7IuYX4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-RIOwCIk8P7Gwrmss1CkxYg-1; Mon, 25 Oct 2021 17:10:01 -0400
X-MC-Unique: RIOwCIk8P7Gwrmss1CkxYg-1
Received: by mail-wm1-f71.google.com with SMTP id d73-20020a1c1d4c000000b0032ca7ec21a4so164624wmd.1
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 14:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jiCj1Dd83x3citihACVoPC1hMPCA+Vsk0IBZb4n1UuI=;
        b=2a2MG5rI+3W+MzZKSKEKG1/FDQ0CiVWJ5SAQ6jBAQz1FHcKPtY5Uj9hbwxFMS57dJP
         EKQbS0VXiB310QJhWGs0WCO6C6f4RjxzwbKpTr46K9A06Vdy2itSsq6obaK6NTtysAC2
         rhHNFDWV2Owq2Q55FYxh0xRWhq9KH5b/SCny7LsUYC+ckK2lwrWWKxDjVZ1Qe83l7SCI
         pT506WPT2x8zbYGLhWUvP/b9cMzz6qEP1QKPByUPODvNbruQsPYbQphNbjERlrunjwp2
         8/17w4XNChxZLVVpSmEw/jFkBmFN+7YkPKR6VpFHYwjS4+kFLF3QXZRKEzGhdLbXBuya
         wyIQ==
X-Gm-Message-State: AOAM533wlgNA1Xu185qXaVJcntpM+YRG6IEziJVunJ+MezpI+hQHYVyk
        to/d1G2OFvYxGgNXjr49OrrNBHSmFtRR0GJnOWzMhfKmIjUTkABjJ+qxFrnlXMH/mJ1Nkuj03jk
        yU9vFJzCK9LCoiM2d6Aw/nz8=
X-Received: by 2002:a1c:a1c2:: with SMTP id k185mr10408892wme.113.1635196199932;
        Mon, 25 Oct 2021 14:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynvPh5e4Ewz12tJb9reo5vEF9DMt6k3ovDZHl4BXPt99sYAyEpdp3ALKCkNCUdugMBbNou4Q==
X-Received: by 2002:a1c:a1c2:: with SMTP id k185mr10408870wme.113.1635196199725;
        Mon, 25 Oct 2021 14:09:59 -0700 (PDT)
Received: from redhat.com ([2.55.12.86])
        by smtp.gmail.com with ESMTPSA id u10sm13879565wrm.34.2021.10.25.14.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:09:58 -0700 (PDT)
Date:   Mon, 25 Oct 2021 17:09:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: allow 0 as num_request_queues
Message-ID: <20211025170516-mutt-send-email-mst@kernel.org>
References: <20211024135412.1516393-1-mst@redhat.com>
 <855eb993-074b-24b9-a184-d479bd0b342b@nvidia.com>
 <20211024105841-mutt-send-email-mst@kernel.org>
 <a2060fc7-cc4d-c4d4-e7fe-e4a1e544104f@nvidia.com>
 <20211024114746-mutt-send-email-mst@kernel.org>
 <ad3d2af0-08ef-f878-c6cb-9ceaa42166d3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3d2af0-08ef-f878-c6cb-9ceaa42166d3@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 01:30:19AM +0300, Max Gurtovoy wrote:
> 
> On 10/24/2021 6:49 PM, Michael S. Tsirkin wrote:
> > On Sun, Oct 24, 2021 at 06:29:59PM +0300, Max Gurtovoy wrote:
> > > On 10/24/2021 6:11 PM, Michael S. Tsirkin wrote:
> > > > On Sun, Oct 24, 2021 at 05:19:33PM +0300, Max Gurtovoy wrote:
> > > > > On 10/24/2021 4:54 PM, Michael S. Tsirkin wrote:
> > > > > > The default value is 0 meaning "no limit". However if 0
> > > > > > is specified on the command line it is instead silently
> > > > > > converted to 1. Further, the value is already validated
> > > > > > at point of use, there's no point in duplicating code
> > > > > > validating the value when it is set.
> > > > > > 
> > > > > > Simplify the code while making the behaviour more consistent
> > > > > > by using plain module_param.
> > > > > > 
> > > > > > Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
> > > > > > Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > ---
> > > > > >     drivers/block/virtio_blk.c | 14 +-------------
> > > > > >     1 file changed, 1 insertion(+), 13 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > > index 6318134aab76..c336d9bb9105 100644
> > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > @@ -30,20 +30,8 @@
> > > > > >     #define VIRTIO_BLK_INLINE_SG_CNT	2
> > > > > >     #endif
> > > > > > -static int virtblk_queue_count_set(const char *val,
> > > > > > -		const struct kernel_param *kp)
> > > > > > -{
> > > > > > -	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > > > -}
> > > > > > -
> > > > > > -static const struct kernel_param_ops queue_count_ops = {
> > > > > > -	.set = virtblk_queue_count_set,
> > > > > > -	.get = param_get_uint,
> > > > > > -};
> > > > > > -
> > > > > >     static unsigned int num_request_queues;
> > > > > > -module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> > > > > > -		0644);
> > > > > > +module_param(num_request_queues, uint, 0644);
> > > > > Not the best solution.
> > > > > 
> > > > > You can set the param to 1024 but in practice nr_cpu_ids can be 32 for
> > > > > example.
> > > > Well your patch does make it possible to know what nr_cpu_ids is.
> > > > But does it matter? The actual number of queues is still capped
> > > > by the num_queues of the device. And I'm concerned that some
> > > > userspace comes to depend on reading back nr_cpu_ids
> > > > from there, which will cement this as part of ABI instead of
> > > > being an implementation detail.
> > > > Exposing the actual number of queues in sysfs might make more sense ...
> > > > 
> > > > Generally you suggested embedded as a use-case, and I don't really
> > > > see lots of embedded userspace poking at this parameter in sysfs.
> > > > 
> > > > What I'd like to see, and attempted to achieve here:
> > > > - avoid code duplication
> > > > - consistency: some way to specify the parameter but still make it have the default value
> > > > 
> > > > Better suggestions are welcome.
> > > Just change return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > 
> > > to
> > > 
> > > return param_set_uint_minmax(val, kp, *0*, nr_cpu_ids);
> > > 
> > > The real amount can be exposed by common sysfs.
> > > 
> > > We'll extend virtio_driver to have a new callback to return this value. If
> > > callback doesn't exist - return -1 (unknown value).
> > That doesn't avoid code duplication - the limit of nr_cpu_ids
> > is applied twice.
> 
> It's a small logic duplication and not code duplication.
> 
> The param_set_uint_minmax is a new API to make sure that the value is in the
> limit you set it, and it will only called if the user explicitly set the
> module parameter.
> 
> In your case, you allow setting 0 value in the comment for the module
> parameter. And this is the oneline change I suggested above.
> 
> The second check in the code is for the case that the user didn't set the
> module parameter explicitly and we need to make sure we don't set num_queues
> to 0 (the default value).
> 
> So I'm ok with these 2 checks.
> 
> Adding a sysfs entry might be nice as incremental patch.
> 
> Let me know if needed, I'll make sure it will be implemented.

No idea. Frankly I'm not sure I fully get the usecase for this feature
but we have an ack from people who know much more about storage. I don't
really want to have too much tricky code dealing with this cornercase
though, so I'd like this as simple as possible.

If you have a mind to implement the sysfs attribute, go ahead - if
someone acks I'll merge it no problem.


> > 
> > > > > >     MODULE_PARM_DESC(num_request_queues,
> > > > > >     		 "Limit the number of request queues to use for blk device. "
> > > > > >     		 "0 for no limit. "

