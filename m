Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C44C77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjELPf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjELPf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC74198
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683905711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ET7hnyRcbg5iW7a6uNqoUY1vArw9P1EwPaP7kXV9CtM=;
        b=Vr/AiQCCRxUs0UQ/sRTtwPaA0i344UQkl5T8IuC3J2JZ33YO/dv7Zlfai6S9jqoj0m6a6Q
        8vnLFWxVYsanPCLJuLhsWGhte+OsZ6LOz6JBsYYC98w+ozrItHVTw5Ac81nV+HDHcZEvB7
        GWqxdkYAOHVA5eqIM6phBKinAZzQ8Tw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-JTEOYHAsMteuV8z8oY3_KQ-1; Fri, 12 May 2023 11:35:08 -0400
X-MC-Unique: JTEOYHAsMteuV8z8oY3_KQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E46783813F3F;
        Fri, 12 May 2023 15:35:07 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E28C15BA0;
        Fri, 12 May 2023 15:35:03 +0000 (UTC)
Date:   Fri, 12 May 2023 23:34:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Message-ID: <ZF5co5g2XLIw82DK@ovpn-8-16.pek2.redhat.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
 <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
 <b745f17b-088c-a72c-00f2-3c0a13cdead5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b745f17b-088c-a72c-00f2-3c0a13cdead5@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 09:25:18AM -0600, Jens Axboe wrote:
> On 5/12/23 9:19 AM, Ming Lei wrote:
> > On Fri, May 12, 2023 at 09:08:54AM -0600, Jens Axboe wrote:
> >> On 5/12/23 9:03?AM, Ming Lei wrote:
> >>> Passthrough(pt) request shouldn't be queued to scheduler, especially some
> >>> schedulers(such as bfq) supposes that req->bio is always available and
> >>> blk-cgroup can be retrieved via bio.
> >>>
> >>> Sometimes pt request could be part of error handling, so it is better to always
> >>> queue it into hctx->dispatch directly.
> >>>
> >>> Fix this issue by queuing pt request from plug list to hctx->dispatch
> >>> directly.
> >>
> >> Why not just add the check to the BFQ insertion? That would be a lot
> >> more trivial and would not be poluting the core with this stuff.
> > 
> > pt request is supposed to be issued to device directly, and we never
> > queue it to scheduler before 1c2d2fff6dc0 ("block: wire-up support for
> > passthrough plugging").
> > 
> > some pt request might be part of error handling, and adding it to
> > scheduler could cause io hang.
> 
> I'm not suggesting adding it to the scheduler, just having the bypass
> "add to dispatch" in a different spot.

Originally it is added to dispatch in blk_execute_rq_nowait() for each
request, but now we support plug for pt request, that is why I add the
bypass in blk_mq_dispatch_plug_list(), and just grab lock for each batch
given now blk_execute_rq_nowait() is fast path for nvme uring pt io feature.

> 
> Let me take a look at it... Do we have a reproducer for this issue?

Guang Wu and Yu Kuai should have, and I didn't succeed in reproducing
it by setting bfq & io.bfq.weight cgroup in my test VM.


Thanks, 
Ming

