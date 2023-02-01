Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00EEC636CD
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 15:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjBAP4z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 10:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjBAP4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 10:56:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA2EF82
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 07:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675266955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qc0BDJveJPXl6X5oDvfLSPkEik+A8rE8XapzufeL1Ww=;
        b=M5UEPwbVW10UC8pVDXNmPSJOVyC2GkuL9wiT5hjxf35Htb/f9LlOzIHfXlv4zaC3waahTi
        7+8cd+t6i8K9moOXvAjWVA38pgAKdvobpr8dfhy8422881/BiK89f6o2TFuX+jGtx9Q1Ss
        q96HDsDfLl0IcYSvBCp9M0z66va5agI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-3EIzTeaQOJ2gF2Etd9PqoQ-1; Wed, 01 Feb 2023 10:55:53 -0500
X-MC-Unique: 3EIzTeaQOJ2gF2Etd9PqoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB62B882823;
        Wed,  1 Feb 2023 15:55:49 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5259E112132D;
        Wed,  1 Feb 2023 15:55:44 +0000 (UTC)
Date:   Wed, 1 Feb 2023 23:55:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Revert "let blkcg_gq grab request queue's refcnt"
Message-ID: <Y9qLe6tZikQbps29@T590>
References: <20230130232257.972224-1-bvanassche@acm.org>
 <Y9h0WMOqNau4s0c0@T590>
 <102b71d2-ee00-c317-fd63-3f3d006505d4@acm.org>
 <Y9nGsMEiecgnQDfE@T590>
 <Y9nqtcbKYAyE/lB7@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9nqtcbKYAyE/lB7@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 01, 2023 at 12:29:41PM +0800, Ming Lei wrote:
> On Wed, Feb 01, 2023 at 09:56:00AM +0800, Ming Lei wrote:
> > On Tue, Jan 31, 2023 at 09:31:36AM -0800, Bart Van Assche wrote:
> > > On 1/30/23 17:52, Ming Lei wrote:
> > > > Hi Bart,
> > > > 
> > > > On Mon, Jan 30, 2023 at 03:22:57PM -0800, Bart Van Assche wrote:
> > > > > Since commit 0a9a25ca7843 ("block: let blkcg_gq grab request queue's
> > > > > refcnt") for many request queues the reference count drops to 1 when
> > > > > the request queue is destroyed instead of to 0. In other words, the
> > > > > request queue is leaked. Fix this by reverting that commit.
> > > > 
> > > > When/where you observe that the reference count drops to 1 instead of 0?
> > > > 
> > > > Do you have kmem leak log?
> > > > 
> > > > Probably, the last drop is in blkg_free_workfn().
> > > 
> > > Hi Ming,
> > > 
> > > The reference count leak was discovered while I was testing my patch series
> > > that adds support for sub-page limits (https://lore.kernel.org/linux-block/20230130212656.876311-1-bvanassche@acm.org/T/#t).
> > > The second patch in that series adds a counter that tracks the number of
> > > queues that need support for limits below the page size
> > > (sub_page_limit_queues). I noticed that without this patch that counter
> > > increases but never decreases. With this patch applied, that counter drops
> > > back to zero after having run a test that needs support for sub-page limits.
> > 
> > I can reproduce the issue by scsi_debug now, but blkg_release() isn't called,
> > so looks like one blkcg_gq lifetime issue since blkcg_exit_disk() is really
> > run.
> 
> The problem is caused by 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()").
> 
> This commit will hold blkg instance until blkcg_rstat_flush() is called,
> and which may be delayed to css_release_work_fn().

The following patch can address the blkg leak issue:

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index cb110fc51940..78f855c34746 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2034,6 +2034,10 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
 
+	/* Root-level stats are sourced from system-wide IO stats */
+	if (!cgroup_parent(blkcg->css.cgroup))
+		return;
+
 	cpu = get_cpu();
 	bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
 	flags = u64_stats_update_begin_irqsave(&bis->sync);

Thanks, 
Ming

