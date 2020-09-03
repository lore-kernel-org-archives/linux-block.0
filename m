Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A1FC433E7
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 00:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFE120786
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 00:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6feJDG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgICAmT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 20:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgICAmS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Sep 2020 20:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599093736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iTqc+RdQZa+WyNHBM/AD2mO0MhzirVKyE+vmMu7+glQ=;
        b=h6feJDG+22szPFGpck60qXbhp4E/96rAOirCfGm9iupvQNoPoDCC6PNHLTgwfsp+qmdlVs
        OF5w6Re+zLn7vuZ6ot/IOB1DwGgM2ltWPdf71jE6tSf9LW6CLOLGaovLZQjt4o7QVsxVF/
        Xl8t0Dm+IBto4WDqeQ8qEal2x6Ehg/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-mGpFKBksNeSmCcxu4XUDRw-1; Wed, 02 Sep 2020 20:42:12 -0400
X-MC-Unique: mGpFKBksNeSmCcxu4XUDRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D22C1074644;
        Thu,  3 Sep 2020 00:42:11 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE6D278B20;
        Thu,  3 Sep 2020 00:42:01 +0000 (UTC)
Date:   Thu, 3 Sep 2020 08:41:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/2] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200903004157.GB638071@T590>
References: <20200825141734.115879-1-ming.lei@redhat.com>
 <20200902031144.GC317674@T590>
 <aef6938d-3762-22bc-50c8-877ee0aa5700@kernel.dk>
 <c33d02c1-5806-94a3-86a8-4e7a6addb36a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c33d02c1-5806-94a3-86a8-4e7a6addb36a@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 02, 2020 at 11:20:36AM -0700, Sagi Grimberg wrote:
> 
> > > > Hi Jens,
> > > > 
> > > > The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> > > > and prepares for replacing srcu with percpu_ref.
> > > > 
> > > > The 2nd patch replaces srcu with percpu_ref.
> > > > 
> > > > V2:
> > > > 	- add .mq_quiesce_lock
> > > > 	- add comment on patch 2 wrt. handling hctx_lock() failure
> > > > 	- trivial patch style change
> > > > 
> > > > 
> > > > Ming Lei (2):
> > > >    blk-mq: serialize queue quiesce and unquiesce by mutex
> > > >    blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
> 
> I thought we agreed to have a little more consolidation for blocking and
> !blocking paths (move fallbacks to common paths).

Could you describe the consolidation one more time for the two paths?

BTW, code will become a little messy if we move queue quiesce handling
out of __blk_mq_try_issue_directly(), because we have two conditions to
trigger insert request into scheduler queue:

1) hctx_lock() failure

2) blk_queue_quiesced() or blk_mq_hctx_stopped()

The former doesn't need to unlock hctx, however the latter needs that,
that is why I don't do the change if that is the consolidation you
mentioned.

> 
> > > > 
> > > >   block/blk-core.c       |   2 +
> > > >   block/blk-mq-sysfs.c   |   2 -
> > > >   block/blk-mq.c         | 125 +++++++++++++++++++++++------------------
> > > >   block/blk-sysfs.c      |   6 +-
> > > >   include/linux/blk-mq.h |   7 ---
> > > >   include/linux/blkdev.h |   6 ++
> > > >   6 files changed, 82 insertions(+), 66 deletions(-)
> > > > 
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Sagi Grimberg <sagi@grimberg.me>
> > > > Cc: Bart Van Assche <bvanassche@acm.org>
> > > > Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > > > Cc: Chao Leng <lengchao@huawei.com>
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > 
> > > Hello Guys,
> > > 
> > > Is there any objections on the two patches? If not, I'd suggest to move> on.
> > 
> > Seems like the nested case is one that should either be handled, or at
> > least detected.
> 
> Personally, I'd like to see the async quiesce piece as well here, which
> is the reason why this change was proposed. Don't see a strong urgency
> to move forward with it before that, especially as this could
> potentially affect various non-trivial reset flows.

OK, it shouldn't be easy to add the interface, will do that in next
version.


Thanks, 
Ming

