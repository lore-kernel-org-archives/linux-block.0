Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F14C433EF
	for <linux-block@archiver.kernel.org>; Sun, 26 Sep 2021 07:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB74A610F7
	for <linux-block@archiver.kernel.org>; Sun, 26 Sep 2021 07:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhIZH4j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Sep 2021 03:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230247AbhIZH4i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Sep 2021 03:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632642902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9hANz/RGCFA4hpD2Oh1lYDFFvIuL0FO/FLIK5m9VJhM=;
        b=STNUDQMtHKttKFLJIhrnh8XWz2cbzl1Px39LqZxaaUvy7OVHtMtapGhiqMTuKs/NFkWxib
        JPsV1DFG58mo15zpTEudjE75S8PpJQ6Q5L5iiFjBT/rl0BJMpjgsATvmi36ajZWP2KzVB7
        ERaqHeDVeJwruH0GxB4r+gjB+nPuv2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-nDND2VKaOm6nadctWLoZXA-1; Sun, 26 Sep 2021 03:54:58 -0400
X-MC-Unique: nDND2VKaOm6nadctWLoZXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C533362FA;
        Sun, 26 Sep 2021 07:54:57 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78F8719741;
        Sun, 26 Sep 2021 07:54:51 +0000 (UTC)
Date:   Sun, 26 Sep 2021 15:55:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Tejun Heo <tj@kernel.org>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH] block: only allocate blkcg->fc_app_id when starting to
 use it
Message-ID: <YVAnW8hQqItBeQAn@T590>
References: <20210924122416.1552721-1-ming.lei@redhat.com>
 <YU33EJ8dLgwPj2/5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU33EJ8dLgwPj2/5@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 24, 2021 at 05:04:32PM +0100, Christoph Hellwig wrote:
> On Fri, Sep 24, 2021 at 08:24:16PM +0800, Ming Lei wrote:
> > So far the feature of BLK_CGROUP_FC_APPID is only used for LPFC, and
> > only when it is setup via sysfs. It is very likely for one system to
> > never use the feature, so allocate the application id buffer in case
> > that someone starts to use it, then we save 129 bytes in each blkcg
> > if no one uses the feature.
> > 
> > Cc: Muneendra Kumar <muneendra.kumar@broadcom.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-cgroup.c         |  3 +++
> >  include/linux/blk-cgroup.h | 15 ++++++++++++---
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index 38b9f7684952..e452adf5f4f6 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -1061,6 +1061,9 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
> >  
> >  	mutex_unlock(&blkcg_pol_mutex);
> >  
> > +#ifdef CONFIG_BLK_CGROUP_FC_APPID
> > +	kfree(blkcg->fc_app_id);
> > +#endif
> >  	kfree(blkcg);
> >  }
> >  
> > diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> > index b4de2010fba5..75094c0a752b 100644
> > --- a/include/linux/blk-cgroup.h
> > +++ b/include/linux/blk-cgroup.h
> > @@ -58,7 +58,7 @@ struct blkcg {
> >  
> >  	struct list_head		all_blkcgs_node;
> >  #ifdef CONFIG_BLK_CGROUP_FC_APPID
> > -	char                            fc_app_id[FC_APPID_LEN];
> > +	char                            *fc_app_id;
> >  #endif
> >  #ifdef CONFIG_CGROUP_WRITEBACK
> >  	struct list_head		cgwb_list;
> > @@ -699,7 +699,16 @@ static inline int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_le
> >  	 * the vmid from the fabric.
> >  	 * Adding the overhead of a lock is not necessary.
> >  	 */
> > -	strlcpy(blkcg->fc_app_id, app_id, app_id_len);
> > +	if (!blkcg->fc_app_id) {
> > +		char *buf = kzalloc(FC_APPID_LEN, GFP_KERNEL);
> > +
> > +		if (cmpxchg(&blkcg->fc_app_id, NULL, buf))
> > +			kfree(buf);
> > +	}
> > +	if (blkcg->fc_app_id)
> > +		strlcpy(blkcg->fc_app_id, app_id, app_id_len);
> > +	else
> > +		ret = -ENOMEM;
> 
> This looks a little cumbersome.  Why not return -ENOMEM using a new
> label directly after the kzalloc?  More importantly there alredy must
> be something synchronizing the strlcpy, so why do we even need the
> cmpxchg?

There isn't such sync for strlcpy, blkcg_set_fc_appid is called from
sysfs attribute write, and cgroup_id is specified on the write buffer,
so cmpxchg is needed. Also the comment in blkcg_set_fc_appid() explained
that:

        /*
         * There is a slight race condition on setting the appid.
         * Worst case an I/O may not find the right id.
         * This is no different from the I/O we let pass while obtaining
         * the vmid from the fabric.
         * Adding the overhead of a lock is not necessary.
         */

> 
> >  static inline char *blkcg_get_fc_appid(struct bio *bio)
> >  {
> > -	if (bio && bio->bi_blkg &&
> > +	if (bio && bio->bi_blkg && bio->bi_blkg->blkcg->fc_app_id &&
> >  		(bio->bi_blkg->blkcg->fc_app_id[0] != '\0'))
> >  		return bio->bi_blkg->blkcg->fc_app_id;
> >  	return NULL;
> 
> And given that we must have some synchronization anyway, why not just
> free the appid when it is set to an empty string rather than adding yet
> another check here in the fast path?

There isn't the sync, so freeing the buffer will cause trouble easily.


Thanks,
Ming

