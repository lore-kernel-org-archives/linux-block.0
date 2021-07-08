Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9588BC07E96
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 07:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7147561CDF
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 07:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhGHHXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 03:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhGHHXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Jul 2021 03:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625728820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltyPqDCYbsNM33joue+vXk4mBVrcYgC8UWiI32gxtUM=;
        b=O4nJ0UfLy2546fZ6Z9e8MM4yy4sC4Q8fY1ZEUcDV6W5Z5g755hKLY+y8f0ObWtqW3Q7jbS
        V0s16pDQFtfByKBzg1OoDxXN81EycfMX6/cIM0cs8xDd9+FNDIEVBf7dPRBR+fXNeKw2Wm
        /D5Ynhj2SxJ6OtlZBLu31iQBkK6tARs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-Nm65yPxYNLydT1zu2CyS4Q-1; Thu, 08 Jul 2021 03:20:18 -0400
X-MC-Unique: Nm65yPxYNLydT1zu2CyS4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90C3A9126D;
        Thu,  8 Jul 2021 07:20:17 +0000 (UTC)
Received: from T590 (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83B3110016FD;
        Thu,  8 Jul 2021 07:20:09 +0000 (UTC)
Date:   Thu, 8 Jul 2021 15:20:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 1/6] loop: clean up blkcg association
Message-ID: <YOanJGsEGiG3BKgh@T590>
References: <20210705102607.127810-1-ming.lei@redhat.com>
 <20210705102607.127810-2-ming.lei@redhat.com>
 <20210706055109.GF17027@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706055109.GF17027@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 07:51:09AM +0200, Christoph Hellwig wrote:
> Did I mention that all this loop blkcg integration is complete and utter
> garbage and should have never been merged?

Sorry, I didn't see your comment on that, and loop blkcg patches have been
merged to linus tree. IMO, this approach fixes real issue wrt. cgroup on
loop.

> 
> 
> >  	struct list_head *cmd_list;
> > +	struct cgroup_subsys_state *blkcg_css = NULL;
> > +#ifdef CONFIG_BLK_CGROUP
> > +	struct request *rq = blk_mq_rq_from_pdu(cmd);
> > +
> > +	if (rq->bio && rq->bio->bi_blkg)
> > +		blkcg_css = &bio_blkcg(rq->bio)->css;
> > +#endif
> 
> This kind of junk has no business in a driver.  The blkcg code
> need to provide a helper for retreiving the blkcg_css from a request,
> including a stub for the the !CONFIG_BLK_CGROUP case.

Fine, it should be cleaner to move the above code into one helper.

> 
> >  		cur_worker = container_of(*node, struct loop_worker, rb_node);
> > -		if (cur_worker->blkcg_css == cmd->blkcg_css) {
> > +		if (cur_worker->blkcg_css == blkcg_css) {
> >  			worker = cur_worker;
> >  			break;
> > -		} else if ((long)cur_worker->blkcg_css < (long)cmd->blkcg_css) {
> > +		} else if ((long)cur_worker->blkcg_css < (long)blkcg_css) {
> 
> No need for an else after a break.  And more importantly no need to cast
> a pointer to compare it to another pointer of the same type.

I believe that change doesn't belong to this patch, also the rbtree is killed
in patch 5/6.

> 
> > +	struct mem_cgroup *old_memcg = NULL;
> > +	struct cgroup_subsys_state *memcg_css = NULL;
> > +
> > +	kthread_associate_blkcg(worker->blkcg_css);
> > +#ifdef CONFIG_MEMCG
> > +	memcg_css = cgroup_get_e_css(worker->blkcg_css->cgroup,
> > +			&memory_cgrp_subsys);
> > +#endif
> > +	if (memcg_css)
> > +		old_memcg = set_active_memcg(
> > +				mem_cgroup_from_css(memcg_css));
> > +
> 
> This kind of crap also has absolutely no business in a block driver
> and the memcg code should provide a proper helper.

Except for loop, cgroup_get_e_css() is only used by cgwb, and this use
case is very special, in which the associated memcg has to be set as active,
so memcg has to be visible here.


Thanks,
Ming

