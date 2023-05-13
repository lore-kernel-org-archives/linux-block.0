Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35D0C77B7C
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 11:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjEMLQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 07:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjEMLQ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 07:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065930C3
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683976570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w4oHIAntagjYY/VHqqmX6YeWOrSv4b+f5QuOMVnBBrU=;
        b=Ez0AzqK6SkYJHnqOYHXxMMX0TXcHD7LKjqsdKvt44HI5PiI+r8msK8fDpInxTzmFXMPAAE
        dK2d31sF367JAh+7FD/bFIgBJw1Cjp2k0yQ8JVbyfxntcgHen6b3HA0SeK4y+dgdAK+BLw
        jLPJV/kptxa5GlwVYLNGtI23lnBMJb4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-MXFPCJS4NLq1XQXc7MvWIA-1; Sat, 13 May 2023 07:16:07 -0400
X-MC-Unique: MXFPCJS4NLq1XQXc7MvWIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 195FA85A588;
        Sat, 13 May 2023 11:16:07 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C377940C2076;
        Sat, 13 May 2023 11:16:02 +0000 (UTC)
Date:   Sat, 13 May 2023 19:15:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Message-ID: <ZF9xbZ3pwqEEcCRE@ovpn-8-17.pek2.redhat.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
 <ZF6ff2l7SKiCrTt0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF6ff2l7SKiCrTt0@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 01:20:15PM -0700, Christoph Hellwig wrote:
> On Fri, May 12, 2023 at 09:08:54AM -0600, Jens Axboe wrote:
> > On 5/12/23 9:03?AM, Ming Lei wrote:
> > > Passthrough(pt) request shouldn't be queued to scheduler, especially some
> > > schedulers(such as bfq) supposes that req->bio is always available and
> > > blk-cgroup can be retrieved via bio.
> > > 
> > > Sometimes pt request could be part of error handling, so it is better to always
> > > queue it into hctx->dispatch directly.
> > > 
> > > Fix this issue by queuing pt request from plug list to hctx->dispatch
> > > directly.
> > 
> > Why not just add the check to the BFQ insertion? That would be a lot
> > more trivial and would not be poluting the core with this stuff.
> 
> Because we really need to keep the passthrough code separate.  The
> fact that a passthrough request can leak into common code in various
> places is really a bit of a problem.  We have most of these nicely
> separate with two exceptions:
> 
>  - the plug list
>  - the requeue list
> 
> The higher level and the more obvious we special case the passthrough
> request there, the better for debuggability and maintainability.

Agree, and there could be more things involved:

1) pt request shares same tags, so scheduler tags is used for allocating pt
request

2) RQF_ELV is set for pt request, and e->type->ops.requeue_request()/
e->type->ops.completed_request() still might be called for pt request.

Probably long-term one dedicated request queue(BLK_MQ_F_TAG_QUEUE_SHARED/
BLK_MQ_F_NO_SCHED) could be used for handling passthrough only if the device
exposes pt interface. Then I guess core code may be cleaned a bit and
becomes easier to improve both two paths, but plug handling still have
to cover both.


thanks,
Ming

