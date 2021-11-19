Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2BBC433EF
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 08:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFB6615E3
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 08:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhKSILA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233159AbhKSIK7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 03:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637309277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ipnE/EI0GvCqJ5PVyC0OVTD4Ij9X5Qe/Shm20MG1/ss=;
        b=EHtIVBnviGtpUztl4k9GrnmXz3C/V+vgZ83AdOgvp26OZkTuJEK9xkuYoVai2thNV98BWq
        ZRsNdVU9eSbrwE1DIvNgj/FdmRZADh1Nt2ysI8HJLAOBuBCQKGuGbg9+V0TGco8SmcVthd
        XjDYBw5Evvzs4oivb7h8yd/hKHeqLNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-268-QdXGj-sAOQSDsJwrLABK7Q-1; Fri, 19 Nov 2021 03:07:53 -0500
X-MC-Unique: QdXGj-sAOQSDsJwrLABK7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97DB4102CB2A;
        Fri, 19 Nov 2021 08:07:52 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73FC9604CC;
        Fri, 19 Nov 2021 08:07:35 +0000 (UTC)
Date:   Fri, 19 Nov 2021 16:07:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] blk-mq: don't insert FUA request with data into
 scheduler queue
Message-ID: <YZdbQiaQPPvbXSkR@T590>
References: <20211118153041.2163228-1-ming.lei@redhat.com>
 <20211119060857.GA15001@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119060857.GA15001@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 19, 2021 at 07:08:58AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 18, 2021 at 11:30:41PM +0800, Ming Lei wrote:
> > We never insert flush request into scheduler queue before.
> > 
> > Recently commit d92ca9d8348f ("blk-mq: don't handle non-flush requests in
> > blk_insert_flush") tries to handle FUA data request as normal request.
> > This way has caused warning[1] in mq-deadline dd_exit_sched() or io hang in
> > case of kyber since RQF_ELVPRIV isn't set for flush request, then
> > ->finish_request won't be called.
> > 
> > Fix the issue by inserting FUA data request with blk_mq_request_bypass_insert()
> > when the device supports FUA, just like what we did before.
> 
> How we did end up with REQ_ELV set for this request?

We set REQ_ELV for any request if q->elevator isn't NULL, see
__blk_mq_alloc_requests(), and REQ_ELV is just for replacing the check on
q->elevator. If we clear REQ_ELV for flush rq, other problem may be caused,
such as blk_mq_rq_ctx_init() may be confused.

Also flush request is always inserted to hctx->dispatch directly, either
before commit d92ca9d8348f or being queued via requeue in current code.



Thanks,
Ming

