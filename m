Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062FEC77B7F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbjELP42 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbjELP42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9550B40F7
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683906936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLa5Ytb7cb+okn92pAHPyxyxinKAdhQDfykU4pJW4/g=;
        b=KeO5WfktKrDKINNa9puaZ1C3BLaDhQlAfotxTi6nl4zXtl+W5bzfGtBFfMmPF9PKv7Ssbf
        qi4L5Sugca8Tfqr/e25xtRgEUiHGARg4IPZeSvjPdrRZXb72A+ESjuTulkYaWFTDTi6Ioo
        HIDWb97c9RywPy38+XH9PfBWbOdAATU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606--5sh_lCeOgK6dFZQJZdtLw-1; Fri, 12 May 2023 11:55:35 -0400
X-MC-Unique: -5sh_lCeOgK6dFZQJZdtLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F38BD867941;
        Fri, 12 May 2023 15:55:34 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C682C15BA0;
        Fri, 12 May 2023 15:55:30 +0000 (UTC)
Date:   Fri, 12 May 2023 23:55:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Message-ID: <ZF5hbgvCyyVWRZPJ@ovpn-8-16.pek2.redhat.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
 <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
 <b745f17b-088c-a72c-00f2-3c0a13cdead5@kernel.dk>
 <ZF5co5g2XLIw82DK@ovpn-8-16.pek2.redhat.com>
 <ca934bc6-651a-6c96-0598-105cd4a0b500@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca934bc6-651a-6c96-0598-105cd4a0b500@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 09:43:32AM -0600, Jens Axboe wrote:
> On 5/12/23 9:34?AM, Ming Lei wrote:
> > On Fri, May 12, 2023 at 09:25:18AM -0600, Jens Axboe wrote:
> >> On 5/12/23 9:19?AM, Ming Lei wrote:
> >>> On Fri, May 12, 2023 at 09:08:54AM -0600, Jens Axboe wrote:
> >>>> On 5/12/23 9:03?AM, Ming Lei wrote:
> >>>>> Passthrough(pt) request shouldn't be queued to scheduler, especially some
> >>>>> schedulers(such as bfq) supposes that req->bio is always available and
> >>>>> blk-cgroup can be retrieved via bio.
> >>>>>
> >>>>> Sometimes pt request could be part of error handling, so it is better to always
> >>>>> queue it into hctx->dispatch directly.
> >>>>>
> >>>>> Fix this issue by queuing pt request from plug list to hctx->dispatch
> >>>>> directly.
> >>>>
> >>>> Why not just add the check to the BFQ insertion? That would be a lot
> >>>> more trivial and would not be poluting the core with this stuff.
> >>>
> >>> pt request is supposed to be issued to device directly, and we never
> >>> queue it to scheduler before 1c2d2fff6dc0 ("block: wire-up support for
> >>> passthrough plugging").
> >>>
> >>> some pt request might be part of error handling, and adding it to
> >>> scheduler could cause io hang.
> >>
> >> I'm not suggesting adding it to the scheduler, just having the bypass
> >> "add to dispatch" in a different spot.
> > 
> > Originally it is added to dispatch in blk_execute_rq_nowait() for each
> > request, but now we support plug for pt request, that is why I add the
> > bypass in blk_mq_dispatch_plug_list(), and just grab lock for each batch
> > given now blk_execute_rq_nowait() is fast path for nvme uring pt io feature.
> 
> We really have two types of passthrough - normal kind of IO, and
> potential error recovery etc IO. The former can plug just fine, and I
> don't think we should treat it differently. Might make more sense to
> just bypass plugging for error handling type of IO, or pt that doesn't
> transfer any data to avoid having a NULL bio inserted into the
> scheduler.

So far, I guess we can't distinguish the two types.

The simplest change could be the previous one[1] by not plugging request
of !rq->bio, but pt request with user IO still can be added to
scheduler, so the question is if pt request with user IO should be
queued to scheduler?

[1] https://lore.kernel.org/linux-block/CAGS2=Yob_Ud9A-aTu5hQt8+kW4cyrLX12hNJTrRkJYigFT-AmA@mail.gmail.com/T/#m8ac66a4294707cf1ba301ef2bd2a70f9a0e2c8cb

Thanks, 
Ming

