Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47945C28CBC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 04:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B17E208DB
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 04:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKTO1n2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgEIELD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 May 2020 00:11:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48310 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725795AbgEIELD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 May 2020 00:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588997461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CP35BvrMj9JNA4OXfyhcPai8CWUP/sWIy+zjxNOyy/Q=;
        b=PKTO1n2pYXOFZrVsY/TP1Rpk6YR+pl/7mr5n5ykhLQteSXzSiQRuv8zzBHLrbl1tCKfGR2
        hKHEgPCM1I7nSDLhB1CNiVD70buWWeBhUbqdLjuZSb8dozXD1JZHaHXWGfrkw5FmdFpP+t
        qq3KFBflFEb1N6kDpSR5FEf6GYOaaiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-Bj26y5sEPlKFMgongIsc5w-1; Sat, 09 May 2020 00:10:56 -0400
X-MC-Unique: Bj26y5sEPlKFMgongIsc5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A702F1005510;
        Sat,  9 May 2020 04:10:54 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DDDA61981;
        Sat,  9 May 2020 04:10:47 +0000 (UTC)
Date:   Sat, 9 May 2020 12:10:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V10 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200509041042.GG1392681@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-8-ming.lei@redhat.com>
 <dbada06d-fcc4-55df-935e-2a46433f28a1@acm.org>
 <20200509022051.GC1392681@T590>
 <0f578345-5a51-b64a-e150-724cfb18dde4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f578345-5a51-b64a-e150-724cfb18dde4@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 08:24:44PM -0700, Bart Van Assche wrote:
> On 2020-05-08 19:20, Ming Lei wrote:
> > Not sure why you mention queue freezing.
> 
> This patch series introduces a fundamental race between modifying the
> hardware queue state (BLK_MQ_S_INACTIVE) and tag allocation. The only

Basically there are two cases:

1) setting BLK_MQ_S_INACTIVE and driver tag allocation are run on same
CPU, we just need a compiler barrier, that happens most of times

2) setting BLK_MQ_S_INACTIVE and driver tag allocation are run on
different CPUs, then one pair of smp_mb() is applied for avoiding
out of order, that only happens in case of direct issue process migration.

Please take a look at the comment in this patch:

+       /*
+        * In case that direct issue IO process is migrated to other CPU
+        * which may not belong to this hctx, add one memory barrier so we
+        * can order driver tag assignment and checking BLK_MQ_S_INACTIVE.
+        * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
+        * and driver tag assignment are run on the same CPU because
+        * BLK_MQ_S_INACTIVE is only set after the last CPU of this hctx is
+        * becoming offline.
+        *
+        * Process migration might happen after the check on current processor
+        * id, smp_mb() is implied by processor migration, so no need to worry
+        * about it.
+        */

And you may find more discussion about this topic in the following thread:

https://lore.kernel.org/linux-block/20200429134327.GC700644@T590/

> mechanism I know of for enforcing the order in which another thread
> observes writes to different memory locations without inserting a memory
> barrier in the hot path is RCU (see also The RCU-barrier menagerie;
> https://lwn.net/Articles/573497/). The only existing such mechanism in
> the blk-mq core I know of is queue freezing. Hence my comment about
> queue freezing.

You didn't explain how queue freezing is used for this issue.

We are talking about CPU hotplug vs. IO. In short, when one hctx becomes
inactive(all cpus in hctx->cpumask becomes offline), in-flight IO from
this hctx needs to be drained for avoiding io timeout. Also all requests
in scheduler/sw queue from this hctx needs to be handled correctly for
avoiding IO hang.

queue freezing can only be applied on the request queue level, and not
hctx level. When requests can't be completed, wait freezing just hangs
for-ever.



Thanks,
Ming

