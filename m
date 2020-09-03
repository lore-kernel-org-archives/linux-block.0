Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64422C433E7
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 00:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27115206EB
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 00:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAm7Sj9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgICAgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 20:36:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42216 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbgICAgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Sep 2020 20:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599093364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7emPPVo9ZQH8EVB0PNKJWzJRb6TItTFt+XRNcQ2lfVg=;
        b=SAm7Sj9HqC+Ti7kuQDEdccflumdA64loecdMQstnAfoDPpqksM5g6g26Qej0nmG1qPVMCN
        SlYPCAY0l0cxWjFutGc6nSSimf0MT/dwha8owT8oRGw94GjLDRfWob85M9gNepjprhM+TF
        HSyXBia9zSY9FjAB4SHkeG3+o31vZoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-eyX8z8d5Muy5I4p7un5bVQ-1; Wed, 02 Sep 2020 20:36:00 -0400
X-MC-Unique: eyX8z8d5Muy5I4p7un5bVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5C351074642;
        Thu,  3 Sep 2020 00:35:58 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 571E95D9CC;
        Thu,  3 Sep 2020 00:35:49 +0000 (UTC)
Date:   Thu, 3 Sep 2020 08:35:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/2] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200903003545.GA638071@T590>
References: <20200825141734.115879-1-ming.lei@redhat.com>
 <20200902031144.GC317674@T590>
 <aef6938d-3762-22bc-50c8-877ee0aa5700@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef6938d-3762-22bc-50c8-877ee0aa5700@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 02, 2020 at 11:52:59AM -0600, Jens Axboe wrote:
> On 9/1/20 9:11 PM, Ming Lei wrote:
> > On Tue, Aug 25, 2020 at 10:17:32PM +0800, Ming Lei wrote:
> >> Hi Jens,
> >>
> >> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> >> and prepares for replacing srcu with percpu_ref.
> >>
> >> The 2nd patch replaces srcu with percpu_ref.
> >>
> >> V2:
> >> 	- add .mq_quiesce_lock
> >> 	- add comment on patch 2 wrt. handling hctx_lock() failure
> >> 	- trivial patch style change
> >>
> >>
> >> Ming Lei (2):
> >>   blk-mq: serialize queue quiesce and unquiesce by mutex
> >>   blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
> >>
> >>  block/blk-core.c       |   2 +
> >>  block/blk-mq-sysfs.c   |   2 -
> >>  block/blk-mq.c         | 125 +++++++++++++++++++++++------------------
> >>  block/blk-sysfs.c      |   6 +-
> >>  include/linux/blk-mq.h |   7 ---
> >>  include/linux/blkdev.h |   6 ++
> >>  6 files changed, 82 insertions(+), 66 deletions(-)
> >>
> >> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> >> Cc: Paul E. McKenney <paulmck@kernel.org>
> >> Cc: Josh Triplett <josh@joshtriplett.org>
> >> Cc: Sagi Grimberg <sagi@grimberg.me>
> >> Cc: Bart Van Assche <bvanassche@acm.org>
> >> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> >> Cc: Chao Leng <lengchao@huawei.com>
> >> Cc: Christoph Hellwig <hch@lst.de>
> > 
> > Hello Guys,
> > 
> > Is there any objections on the two patches? If not, I'd suggest to move> on.
> 
> Seems like the nested case is one that should either be handled, or at
> least detected.

Yeah, the 1st patch adds mutex for handling nested case correctly and efficiently.

Thanks,
Ming

