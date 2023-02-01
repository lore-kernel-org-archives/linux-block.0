Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85573C38142
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 04:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjBAEam (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 23:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBAEal (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 23:30:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8DA196A0
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 20:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675225793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xiTFOTIA3n8Ir24XC9W+xENnHSE7PauDs8XZ2S0Dn3c=;
        b=B3SHdGqE47lGmJc1nfZQdgg/dOVTkCtSAspLDb8lGijcJbjD2ybCzGQiY6D+uV6nTLs+xs
        YXtKLvlgZ6dzRxEybgYCphwaariv6yKJ53DZdzXwg6TU1YJE6lQZHarvX3n7gUMyL79Kdv
        7xg9Ud+0KUim+2kKk1auyut1G6n67sg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-F0B4Y5IbPTi4_Cyx08xJIw-1; Tue, 31 Jan 2023 23:29:51 -0500
X-MC-Unique: F0B4Y5IbPTi4_Cyx08xJIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6B4C3828898;
        Wed,  1 Feb 2023 04:29:50 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45699C15BAE;
        Wed,  1 Feb 2023 04:29:46 +0000 (UTC)
Date:   Wed, 1 Feb 2023 12:29:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Revert "let blkcg_gq grab request queue's refcnt"
Message-ID: <Y9nqtcbKYAyE/lB7@T590>
References: <20230130232257.972224-1-bvanassche@acm.org>
 <Y9h0WMOqNau4s0c0@T590>
 <102b71d2-ee00-c317-fd63-3f3d006505d4@acm.org>
 <Y9nGsMEiecgnQDfE@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9nGsMEiecgnQDfE@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 01, 2023 at 09:56:00AM +0800, Ming Lei wrote:
> On Tue, Jan 31, 2023 at 09:31:36AM -0800, Bart Van Assche wrote:
> > On 1/30/23 17:52, Ming Lei wrote:
> > > Hi Bart,
> > > 
> > > On Mon, Jan 30, 2023 at 03:22:57PM -0800, Bart Van Assche wrote:
> > > > Since commit 0a9a25ca7843 ("block: let blkcg_gq grab request queue's
> > > > refcnt") for many request queues the reference count drops to 1 when
> > > > the request queue is destroyed instead of to 0. In other words, the
> > > > request queue is leaked. Fix this by reverting that commit.
> > > 
> > > When/where you observe that the reference count drops to 1 instead of 0?
> > > 
> > > Do you have kmem leak log?
> > > 
> > > Probably, the last drop is in blkg_free_workfn().
> > 
> > Hi Ming,
> > 
> > The reference count leak was discovered while I was testing my patch series
> > that adds support for sub-page limits (https://lore.kernel.org/linux-block/20230130212656.876311-1-bvanassche@acm.org/T/#t).
> > The second patch in that series adds a counter that tracks the number of
> > queues that need support for limits below the page size
> > (sub_page_limit_queues). I noticed that without this patch that counter
> > increases but never decreases. With this patch applied, that counter drops
> > back to zero after having run a test that needs support for sub-page limits.
> 
> I can reproduce the issue by scsi_debug now, but blkg_release() isn't called,
> so looks like one blkcg_gq lifetime issue since blkcg_exit_disk() is really
> run.

The problem is caused by 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()").

This commit will hold blkg instance until blkcg_rstat_flush() is called,
and which may be delayed to css_release_work_fn().

Thanks,
Ming

