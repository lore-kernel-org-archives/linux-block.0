Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E0C77B7D
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 10:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjEMK4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 06:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjEMK4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 06:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A7E40C7
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683975337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lqPmpF4FaHFgO71DLnZiCJT9FbARr+TTPg+xL5eLGw4=;
        b=EJWHbtHMdJuxi5AzRcd0RKdu+Zb+xfvvq9sCozseGshpR9JNzy+la0qiagSorgfpVEwhDF
        isXd5WpUUoWc7Tj74bYdNR4L1OAQPeiURg9JHX7g/ikKmO0HH/Kysw1Vvh7EvwXpU0OgVk
        Lrm5nKCtF0dMpRxCoAakEnhLXwunnRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-ITlYdMXGNHW39TSdOyndqw-1; Sat, 13 May 2023 06:55:34 -0400
X-MC-Unique: ITlYdMXGNHW39TSdOyndqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FD4C101A54F;
        Sat, 13 May 2023 10:55:28 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0076740C2076;
        Sat, 13 May 2023 10:55:24 +0000 (UTC)
Date:   Sat, 13 May 2023 18:55:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Message-ID: <ZF9sl7Kh9bUwZXm1@ovpn-8-17.pek2.redhat.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
 <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
 <b745f17b-088c-a72c-00f2-3c0a13cdead5@kernel.dk>
 <ZF5co5g2XLIw82DK@ovpn-8-16.pek2.redhat.com>
 <ca934bc6-651a-6c96-0598-105cd4a0b500@kernel.dk>
 <ZF5hbgvCyyVWRZPJ@ovpn-8-16.pek2.redhat.com>
 <f7618ff1-3122-aa64-50a9-2f48f7dd6359@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7618ff1-3122-aa64-50a9-2f48f7dd6359@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 10:10:55AM -0600, Jens Axboe wrote:
> On 5/12/23 9:55?AM, Ming Lei wrote:
> > On Fri, May 12, 2023 at 09:43:32AM -0600, Jens Axboe wrote:
> >> On 5/12/23 9:34?AM, Ming Lei wrote:
> >>> On Fri, May 12, 2023 at 09:25:18AM -0600, Jens Axboe wrote:
> >>>> On 5/12/23 9:19?AM, Ming Lei wrote:
> >>>>> On Fri, May 12, 2023 at 09:08:54AM -0600, Jens Axboe wrote:
> >>>>>> On 5/12/23 9:03?AM, Ming Lei wrote:
> >>>>>>> Passthrough(pt) request shouldn't be queued to scheduler, especially some
> >>>>>>> schedulers(such as bfq) supposes that req->bio is always available and
> >>>>>>> blk-cgroup can be retrieved via bio.
> >>>>>>>
> >>>>>>> Sometimes pt request could be part of error handling, so it is better to always
> >>>>>>> queue it into hctx->dispatch directly.
> >>>>>>>
> >>>>>>> Fix this issue by queuing pt request from plug list to hctx->dispatch
> >>>>>>> directly.
> >>>>>>
> >>>>>> Why not just add the check to the BFQ insertion? That would be a lot
> >>>>>> more trivial and would not be poluting the core with this stuff.
> >>>>>
> >>>>> pt request is supposed to be issued to device directly, and we never
> >>>>> queue it to scheduler before 1c2d2fff6dc0 ("block: wire-up support for
> >>>>> passthrough plugging").
> >>>>>
> >>>>> some pt request might be part of error handling, and adding it to
> >>>>> scheduler could cause io hang.
> >>>>
> >>>> I'm not suggesting adding it to the scheduler, just having the bypass
> >>>> "add to dispatch" in a different spot.
> >>>
> >>> Originally it is added to dispatch in blk_execute_rq_nowait() for each
> >>> request, but now we support plug for pt request, that is why I add the
> >>> bypass in blk_mq_dispatch_plug_list(), and just grab lock for each batch
> >>> given now blk_execute_rq_nowait() is fast path for nvme uring pt io feature.
> >>
> >> We really have two types of passthrough - normal kind of IO, and
> >> potential error recovery etc IO. The former can plug just fine, and I
> >> don't think we should treat it differently. Might make more sense to
> >> just bypass plugging for error handling type of IO, or pt that doesn't
> >> transfer any data to avoid having a NULL bio inserted into the
> >> scheduler.
> > 
> > So far, I guess we can't distinguish the two types.
> 
> Right, and that seems to be the real problem here. What is true for any
> pt request is that normal sorting by sector doesn't work, but it really
> would be nice to distinguish the two for other reasons. Eg "true" pt
> error handling should definitely just go to the dispatch list, and we
> don't need to apply any batching etc for them. For uring_cmd based
> passthrough, we most certainly should.
> 
> > The simplest change could be the previous one[1] by not plugging request
> > of !rq->bio, but pt request with user IO still can be added to
> > scheduler, so the question is if pt request with user IO should be
> > queued to scheduler?
> 
> I'm fine bypassing the scheduler insertion for that, my main objection
> to your original patch is that it's a bit messy and I was hoping we
> could do a cleaner separation earlier. But I _think_ that'd get us into
> full logic bypass for pt, which again then would not be ideal for
> performance oriented pt.

Yeah, that is the reason why this patch makes pt request batch and
bypass them all, so nvme uring cmd pt io perf won't be hurt.

So I guess now you are fine with this patch? If that is true, I will post V2
with revised comment log, such as, including Christoph's related comment.

Otherwise, any suggestion wrt. early bypass?

- bypass in case of scheduler, but still a bit tricky, why does pt need
  to care elevator? Meantime performance is still affected for any IOs
  sharing the current plug


Thanks, 
Ming

