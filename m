Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B023C433E3
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C4A2075B
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgfqdASz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHXKlS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:41:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43052 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727798AbgHXKlR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 06:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598265672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XWQlAwsjClgQ9cN28ym8AEnjIMo1h/gbOJX/J2aH6bc=;
        b=HgfqdASzJws/XC2pRwEwdq9qBH2aRtig+oR8P2qAgOryUzkcCyeecYaxpW4fxOIhXDVX0D
        ApDE/Pq/8Lp+JOMdOPWzjK8raixBdGiP4N7ZvTCk//oC5UgDe4OA57X8BqLluYfuU/ctPy
        Gkp8oDZK59t5ZtSJ1FCLOHSkp26CrS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-C0VTt1blMYejbLWjfgb8ZA-1; Mon, 24 Aug 2020 06:41:08 -0400
X-MC-Unique: C0VTt1blMYejbLWjfgb8ZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C7F164087;
        Mon, 24 Aug 2020 10:41:07 +0000 (UTC)
Received: from T590 (ovpn-12-133.pek2.redhat.com [10.72.12.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A80A15D9EF;
        Mon, 24 Aug 2020 10:40:57 +0000 (UTC)
Date:   Mon, 24 Aug 2020 18:40:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Message-ID: <20200824104052.GA3210443@T590>
References: <20200820030248.2809559-1-ming.lei@redhat.com>
 <856f6108-2227-67e8-e913-fdef296a2d26@grimberg.me>
 <20200822133954.GC3189453@T590>
 <619a8d4f-267f-5e21-09bd-16b45af69480@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619a8d4f-267f-5e21-09bd-16b45af69480@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 24, 2020 at 01:19:56AM -0700, Sagi Grimberg wrote:
> 
> > > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > > index bb5636cc17b9..5fa8bc1bb7a8 100644
> > > > --- a/include/linux/blkdev.h
> > > > +++ b/include/linux/blkdev.h
> > > > @@ -572,6 +572,10 @@ struct request_queue {
> > > >    	struct list_head	tag_set_list;
> > > >    	struct bio_set		bio_split;
> > > > +	/* only used for BLK_MQ_F_BLOCKING */
> > > > +	struct percpu_ref	dispatch_counter;
> > > 
> > > Can this be moved to be next to the q_usage_counter? they
> > > will be taken together for blocking drivers...
> > 
> > I don't think it is a good idea, at least hctx->srcu is put at the end
> > of hctx, do you want to move it at beginning of hctx?
> 
> I'd think it'd be an improvement, yes.

Please see the reason why it is put back of hctx in
073196787727("blk-mq: Reduce blk_mq_hw_ctx size").

> 
> > .q_usage_counter should have been put in the 1st cacheline of
> > request queue. If it is moved to the 1st cacheline of request queue,
> > we shouldn't put 'dispatch_counter' there, because it may hurt other
> > non-blocking drivers.
> 
> q_usage_counter currently there, and the two will always be taken
> together, and there are several other stuff that we can remove from
> that cacheline without hurting performance for anything.
> 
> And when q_usage_counter is moved to the first cacheline, then I'd
> expect that the dispatch_counter also moves to the front (maybe not
> the first if it is on the expense of other hot members, but definitely
> it should be treated as a hot member).
> 
> Anyways, I think that for now we should place them together.

Then it may hurt non-blocking.

Each hctx has only one run-work, if the hctx is blocked, no other request
may be queued to hctx any more. That is basically sync run queue, so I
am not sure good enough perf can be expected on blocking.

So it may not be worth of putting the added .dispatch_counter together
with .q_usage_counter.

> 
> > > Also maybe a better name is needed here since it's just
> > > for blocking hctxs.
> > > 
> > > > +	wait_queue_head_t	mq_quiesce_wq;
> > > > +
> > > >    	struct dentry		*debugfs_dir;
> > > >    #ifdef CONFIG_BLK_DEBUG_FS
> > > > 
> > > 
> > > What I think is needed here is at a minimum test quiesce/unquiesce loops
> > > during I/O. code auditing is not enough, there may be driver assumptions
> > > broken with this change (although I hope there shouldn't be).
> > 
> > We have elevator switch / updating nr_request stress test, and both relies
> > on quiesce/unquiesce, and I did run such test with this patch.
> 
> You have a blktest for this? If not, I strongly suggest that one is
> added to validate the change also moving forward.

There are lots of blktest tests doing that, such as block/005,
block/016, block/021, ...


Thanks, 
Ming

