Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE04C352BE
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 06:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D14220787
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 06:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmZPzQWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408111AbgDPGe5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:34:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60994 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408088AbgDPGey (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 02:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587018892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nCd3WtsGaX/OvVWiMxmVzNhR7/RYCqVcgsji7FHaInc=;
        b=AmZPzQWeTZCiG7pttWXhMI2sKSMMve2zwOdHuUKRGwoMSQvvkAQuMhV7pLB8dj+rLsRZ58
        lBr9hOY9X7sTnhRMuLPVywRgiJH5t1nX5nIeNPpZK0FQfBtkEtbcdHyZGCmmiAmz76OUkt
        8bw+1TBY9Pl6DqU/REZrQJr77cA/xDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-fUDLkM2QNBqVmJ_SYclSCw-1; Thu, 16 Apr 2020 02:34:47 -0400
X-MC-Unique: fUDLkM2QNBqVmJ_SYclSCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0CE51005513;
        Thu, 16 Apr 2020 06:34:44 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47CA7A0997;
        Thu, 16 Apr 2020 06:34:32 +0000 (UTC)
Date:   Thu, 16 Apr 2020 14:34:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 4/5] mm/swapfile: refcount block and queue before using
 blkcg_schedule_throttle()
Message-ID: <20200416063428.GE2723777@T590>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-5-mcgrof@kernel.org>
 <20200416062222.GC2723777@T590>
 <20200416062532.GN11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416062532.GN11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 16, 2020 at 06:25:32AM +0000, Luis Chamberlain wrote:
> On Thu, Apr 16, 2020 at 02:22:22PM +0800, Ming Lei wrote:
> > On Tue, Apr 14, 2020 at 04:19:01AM +0000, Luis Chamberlain wrote:
> > > block devices are refcounted so to ensure once its final user goes away it
> > > can be cleaned up by the lower layers properly. The block device's
> > > request_queue structure is also refcounted, however, if the last
> > > blk_put_queue() is called under atomic context the block layer has
> > > to defer removal.
> > > 
> > > By refcounting the block device during the use of blkcg_schedule_throttle(),
> > > we ensure ensure two things:
> > > 
> > > 1) the block device remains available during the call
> > > 2) we ensure avoid having to deal with the fact we're using the
> > >    request_queue structure in atomic context, since the last
> > >    blk_put_queue() will be called upon disk_release(), *after*
> > >    our own bdput().
> > > 
> > > This means this code path is *not* going to remove the request_queue
> > > structure, as we are ensuring some later upper layer disk_release()
> > > will be the one to release the request_queue structure for us.
> > > 
> > > Cc: Bart Van Assche <bvanassche@acm.org>
> > > Cc: Omar Sandoval <osandov@fb.com>
> > > Cc: Hannes Reinecke <hare@suse.com>
> > > Cc: Nicolai Stange <nstange@suse.de>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: yu kuai <yukuai3@huawei.com>
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  mm/swapfile.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 6659ab563448..9285ff6030ca 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -3753,6 +3753,7 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
> > >  void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
> > >  				  gfp_t gfp_mask)
> > >  {
> > > +	struct block_device *bdev;
> > >  	struct swap_info_struct *si, *next;
> > >  	if (!(gfp_mask & __GFP_IO) || !memcg)
> > >  		return;
> > > @@ -3771,8 +3772,17 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
> > >  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
> > >  				  avail_lists[node]) {
> > >  		if (si->bdev) {
> > > -			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
> > > -						true);
> > > +			bdev = bdgrab(si->bdev);
> > 
> > When swapon, the block_device has been opened in claim_swapfile(),
> > so no need to worry about the queue being gone here.
> 
> Thanks, so why bdev_get_queue() before?

bdev_get_queue() returns the request queue associated with the
the block device, and it is just that blkcg_schedule_throttle() needs
it.

Maybe I misunderstood your question, if yes, please explain it in
a bit detail.

Thanks,
Ming

