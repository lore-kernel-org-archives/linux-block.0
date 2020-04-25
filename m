Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC1EC2BA1A
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD802076C
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bq1kKl0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgDYDRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:17:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51618 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgDYDRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 23:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587784663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p2GwUfe++I0eVMrsh3t3iQsj9RbLdOgPVtRvijPrIrI=;
        b=bq1kKl0KC9CPPXO5AallTkq2u1dre9wBAF4n2US8otbrhibCjo+mUbSR/KxhIyoHY6buwU
        00NIXEyXPL0YWTSNXnrQuCTrmL/SWrhxaJZEXg9GkrNkmssSSadTM6fE0PnvjvNOw2Wp2O
        bdKnbnaBvgfm6/XcsEon113YYUHHxb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-pXcdD6N1MWmmZi_Db8ozNw-1; Fri, 24 Apr 2020 23:17:38 -0400
X-MC-Unique: pXcdD6N1MWmmZi_Db8ozNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7DC8107ACCA;
        Sat, 25 Apr 2020 03:17:36 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CD2C6084A;
        Sat, 25 Apr 2020 03:17:29 +0000 (UTC)
Date:   Sat, 25 Apr 2020 11:17:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200425031723.GC477579@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
 <20200424103851.GD28156@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424103851.GD28156@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 12:38:51PM +0200, Christoph Hellwig wrote:
> On Fri, Apr 24, 2020 at 06:23:47PM +0800, Ming Lei wrote:
> > Before one CPU becomes offline, check if it is the last online CPU of hctx.
> > If yes, mark this hctx as inactive, meantime wait for completion of all
> > in-flight IOs originated from this hctx. Meantime check if this hctx has
> > become inactive in blk_mq_get_driver_tag(), if yes, release the
> > allocated tag.
> > 
> > This way guarantees that there isn't any inflight IO before shutdowning
> > the managed IRQ line when all CPUs of this IRQ line is offline.
> 
> Can you take a look at all my comments on the previous version here
> (splitting blk_mq_get_driver_tag for direct_issue vs not, what is

I am not sure if it helps by adding two helper, given only two
parameters are needed, and the new parameter is just a constant.

> the point of barrier(), smp_mb__before_atomic and
> smp_mb__after_atomic), as none seems to be addressed and I also didn't
> see a reply.

I believe it has been documented:

+   /*
+    * Add one memory barrier in case that direct issue IO process is
+    * migrated to other CPU which may not belong to this hctx, so we can
+    * order driver tag assignment and checking BLK_MQ_S_INACTIVE.
+    * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
+    * and driver tag assignment are run on the same CPU in case that
+    * BLK_MQ_S_INACTIVE is set.
+    */

OK, I can add more:

In case of not direct issue, __blk_mq_delay_run_hw_queue() guarantees
that dispatch is done on CPUs of this hctx.

In case of direct issue, the direct issue IO process may be migrated to
other CPU which doesn't belong to hctx->cpumask even though the chance
is quite small, but still possible.

This patch sets hctx as inactive in the last CPU of hctx, so barrier()
is enough for not direct issue. Otherwise, one smp_mb() is added for
ordering tag assignment(include setting rq) and checking S_INACTIVE in
blk_mq_get_driver_tag().



Thanks,
Ming

