Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AFFC38142
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 01:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBAB46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 20:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBAB45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 20:56:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CE04AA51
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 17:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675216571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p23zJ/nLRkW/I4tupUI24HjADJiRVW5RzV+pVKye1Ps=;
        b=iCQ7VDu4U8sVpgBjT+cYL6Q4qqE1q+LbQGNRcWjPcbvhwBgoU2ty3pomRMY/M2VXpPVbgU
        GxYCxYqkosuttwdfpX2XZGudCwo0nDA/oHwJCmFdMymCfvygVrDrxNQEIk7R8PCBIQhZuF
        zW06Cq6KkO81YRFvfiykMZjMqT+Dsl0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-uRcl4JutPSe5GhOzjeFGCw-1; Tue, 31 Jan 2023 20:56:10 -0500
X-MC-Unique: uRcl4JutPSe5GhOzjeFGCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89D1F3C18346;
        Wed,  1 Feb 2023 01:56:09 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03A212026D68;
        Wed,  1 Feb 2023 01:56:05 +0000 (UTC)
Date:   Wed, 1 Feb 2023 09:56:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com
Subject: Re: [PATCH] block: Revert "let blkcg_gq grab request queue's refcnt"
Message-ID: <Y9nGsMEiecgnQDfE@T590>
References: <20230130232257.972224-1-bvanassche@acm.org>
 <Y9h0WMOqNau4s0c0@T590>
 <102b71d2-ee00-c317-fd63-3f3d006505d4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102b71d2-ee00-c317-fd63-3f3d006505d4@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 31, 2023 at 09:31:36AM -0800, Bart Van Assche wrote:
> On 1/30/23 17:52, Ming Lei wrote:
> > Hi Bart,
> > 
> > On Mon, Jan 30, 2023 at 03:22:57PM -0800, Bart Van Assche wrote:
> > > Since commit 0a9a25ca7843 ("block: let blkcg_gq grab request queue's
> > > refcnt") for many request queues the reference count drops to 1 when
> > > the request queue is destroyed instead of to 0. In other words, the
> > > request queue is leaked. Fix this by reverting that commit.
> > 
> > When/where you observe that the reference count drops to 1 instead of 0?
> > 
> > Do you have kmem leak log?
> > 
> > Probably, the last drop is in blkg_free_workfn().
> 
> Hi Ming,
> 
> The reference count leak was discovered while I was testing my patch series
> that adds support for sub-page limits (https://lore.kernel.org/linux-block/20230130212656.876311-1-bvanassche@acm.org/T/#t).
> The second patch in that series adds a counter that tracks the number of
> queues that need support for limits below the page size
> (sub_page_limit_queues). I noticed that without this patch that counter
> increases but never decreases. With this patch applied, that counter drops
> back to zero after having run a test that needs support for sub-page limits.

I can reproduce the issue by scsi_debug now, but blkg_release() isn't called,
so looks like one blkcg_gq lifetime issue since blkcg_exit_disk() is really
run.

Thanks,
Ming

