Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85366C433E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 03:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F26C2068F
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 03:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkJdHVdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIBDMG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBDMF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 23:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599016324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/QfutMcgWekwpe4pu+oNZP7k0y3xKzy+5HKqKn9ZCts=;
        b=HkJdHVdHjZ0BdCUU0wDVIhDK0G2QIDGLkWt5/hGMRsHKIYeSDGRiQVYAjU2PHKS8ly7ANI
        +TZB89TAoJsy9C23BbGvJC116wBqxZmqE6Uxdqb7/bTDDhUKqSnJmippSNvfSlVs9gAFN3
        0UIBsThxgpQ6O1UzupvLKNdigg+YVYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-JeeFu27BNAeNGFin7_HiNQ-1; Tue, 01 Sep 2020 23:12:00 -0400
X-MC-Unique: JeeFu27BNAeNGFin7_HiNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDFB5427C0;
        Wed,  2 Sep 2020 03:11:57 +0000 (UTC)
Received: from T590 (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C28A5757DF;
        Wed,  2 Sep 2020 03:11:49 +0000 (UTC)
Date:   Wed, 2 Sep 2020 11:11:44 +0800
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
Message-ID: <20200902031144.GC317674@T590>
References: <20200825141734.115879-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825141734.115879-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 25, 2020 at 10:17:32PM +0800, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> and prepares for replacing srcu with percpu_ref.
> 
> The 2nd patch replaces srcu with percpu_ref.
> 
> V2:
> 	- add .mq_quiesce_lock
> 	- add comment on patch 2 wrt. handling hctx_lock() failure
> 	- trivial patch style change
> 
> 
> Ming Lei (2):
>   blk-mq: serialize queue quiesce and unquiesce by mutex
>   blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
> 
>  block/blk-core.c       |   2 +
>  block/blk-mq-sysfs.c   |   2 -
>  block/blk-mq.c         | 125 +++++++++++++++++++++++------------------
>  block/blk-sysfs.c      |   6 +-
>  include/linux/blk-mq.h |   7 ---
>  include/linux/blkdev.h |   6 ++
>  6 files changed, 82 insertions(+), 66 deletions(-)
> 
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: Chao Leng <lengchao@huawei.com>
> Cc: Christoph Hellwig <hch@lst.de>

Hello Guys,

Is there any objections on the two patches? If not, I'd suggest to move
on.

Thanks,
Ming

