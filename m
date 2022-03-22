Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2D0C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 10:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiCVKZS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiCVKZP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 06:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F28521277F
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647944628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h2SF0iSQFgUmlddp/pafkRXpPNV0Sazq6IX6L9LQLhc=;
        b=dXjxEan/SRvu0QiNuJMRgq6O/9vmFhdARcKxU1IPFMi0JooLd/1nWyIfBtuhZyKboc5O+f
        JOlXn0K69rztEYFOccExYuTN5tNwHYu8sfVipmFckbsRxX9sKZfPfncpHgkfSCGAUPxDbS
        My2U+Cv3QIDT+TLQ4bAOZgP9MF0kspQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-Tds3AznoOIS0_lFcaJDdkw-1; Tue, 22 Mar 2022 06:23:44 -0400
X-MC-Unique: Tds3AznoOIS0_lFcaJDdkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F6653803913;
        Tue, 22 Mar 2022 10:23:44 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3681DC26E9A;
        Tue, 22 Mar 2022 10:23:39 +0000 (UTC)
Date:   Tue, 22 Mar 2022 18:23:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 2/3] block: let blkcg_gq grab request queue's refcnt
Message-ID: <YjmjplwpQpkOlimQ@T590>
References: <20220318130144.1066064-1-ming.lei@redhat.com>
 <20220318130144.1066064-3-ming.lei@redhat.com>
 <20220322093322.GA27283@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322093322.GA27283@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 22, 2022 at 10:33:22AM +0100, Christoph Hellwig wrote:
> On Fri, Mar 18, 2022 at 09:01:43PM +0800, Ming Lei wrote:
> > In the whole lifetime of blkcg_gq instance, ->q will be referred, such
> > as, ->pd_free_fn() is called in blkg_free, and throtl_pd_free() still
> > may touch the request queue via &tg->service_queue.pending_timer which
> > is handled by throtl_pending_timer_fn(), so it is reasonable to grab
> > request queue's refcnt by blkcg_gq instance.
> > 
> > Previously blkcg_exit_queue() is called from blk_release_queue, and it
> > is hard to avoid the use-after-free. But recently commit 1059699f87eb ("block:
> > move blkcg initialization/destroy into disk allocation/release handler")
> > is merged to for-5.18/block, it becomes simple to fix the issue by simply
> > grabbing request queue's refcnt.
> > 
> > Reported-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-cgroup.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index fa063c6c0338..d53b0d69dd73 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -82,6 +82,8 @@ static void blkg_free(struct blkcg_gq *blkg)
> >  		if (blkg->pd[i])
> >  			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
> >  
> > +	if (blkg->q)
> > +		blk_put_queue(blkg->q);
> 
> blkg_free can be called from RCU context, while blk_put_queue must
> not be called from RCU context.  This causes regular splats when running
> xfstests like:

Thanks for the report.

One solution is to delay 'blk_put_queue(blkg->q)' and 'kfree(blkg)'
into one work function by reusing blkg->async_bio_work as release_work.

I will prepare one patch for addressing the issue.

Thanks,
Ming

