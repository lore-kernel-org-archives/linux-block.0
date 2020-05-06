Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE40C28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 08:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A57206D5
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 08:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbWJdJfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgEFIHs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 04:07:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24892 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728359AbgEFIHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 May 2020 04:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588752466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cEv75xYqaruWEy1BsVgLEC0hoCPdTykXTM5FDUk2afs=;
        b=BbWJdJfhAXnUwGHYncllF2jqXL0BVuO3Iv8ejxoVQ0EXp0d7qO0wnRvJuO50w/n/SB46B/
        FaKoyhKcJMI8vbxqeZA7RHfFxrVanoQTlke5oQvDhuFIzoJAi1ATANLe8W/zIQS5e5rfrc
        9n9bSmJSF58l722lHut5p7oqOoO7AnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-0Ybdh4WiMHyZ3COYkW_94A-1; Wed, 06 May 2020 04:07:42 -0400
X-MC-Unique: 0Ybdh4WiMHyZ3COYkW_94A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C80A107ACCA;
        Wed,  6 May 2020 08:07:40 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A23363F9D;
        Wed,  6 May 2020 08:07:31 +0000 (UTC)
Date:   Wed, 6 May 2020 16:07:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200506080727.GB1177270@T590>
References: <20200429094616.GB700644@T590>
 <20200429122757.GA30247@willie-the-truck>
 <20200429134327.GC700644@T590>
 <20200429173400.GC30247@willie-the-truck>
 <20200430003945.GA719313@T590>
 <20200430110429.GI19932@willie-the-truck>
 <20200430140254.GA996887@T590>
 <20200505154618.GA3644@lst.de>
 <20200506012425.GA1177270@T590>
 <20200506072802.GC7021@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506072802.GC7021@willie-the-truck>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 06, 2020 at 08:28:03AM +0100, Will Deacon wrote:
> On Wed, May 06, 2020 at 09:24:25AM +0800, Ming Lei wrote:
> > On Tue, May 05, 2020 at 05:46:18PM +0200, Christoph Hellwig wrote:
> > > On Thu, Apr 30, 2020 at 10:02:54PM +0800, Ming Lei wrote:
> > > > BLK_MQ_S_INACTIVE is only set when the last cpu of this hctx is becoming
> > > > offline, and blk_mq_hctx_notify_offline() is called from cpu hotplug
> > > > handler. So if there is any request of this hctx submitted from somewhere,
> > > > it has to this last cpu. That is done by blk-mq's queue mapping.
> > > > 
> > > > In case of direct issue, basically blk_mq_get_driver_tag() is run after
> > > > the request is allocated, that is why I mentioned the chance of
> > > > migration is very small.
> > > 
> > > "very small" does not cut it, it has to be zero.  And it seems the
> > > new version still has this hack.
> > 
> > But smp_mb() is used for ordering the WRITE and READ, so it is correct.
> > 
> > barrier() is enough when process migration doesn't happen.
> 
> Without numbers I would just make the smp_mb() unconditional. Your
> questionable optimisation trades that for a load of the CPU ID and a
> conditional branch, which isn't obviously faster to me. It's also very

The CPU ID is just percpu READ, and unlikely() has been used for
optimizing the conditional branch. And smp_mb() could cause CPU stall, I
guess, so it should be much slower than reading CPU ID.

Let's see the attached microbench[1], the result shows that smp_mb() is
10+ times slower than smp_processor_id() with one conditional branch.

[    1.239951] test_foo: smp_mb 738701907 smp_id 62904315 result 0 overflow 5120

The micronbench is run on simple 8cores KVM guest, and cpu is
'Model name:          Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz'.

Result is pretty stable in my 5 runs of VM boot.

> difficult to explain to people and relies on a bunch of implicit behaviour
> (e.g. racing only with CPU-affine hotplug notifier).

It can be documented easily.

> 
> If it turns out that the smp_mb() is worthwhile,  then I'd suggest improving
> the comment, perhaps to include the litmus test I cooked previously.

I have added big comment on this usage in V10 already.



[1] miscrobench

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 956106b01810..548eec11f922 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3836,8 +3836,47 @@ unsigned int blk_mq_rq_cpu(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_rq_cpu);
 
+static unsigned long test_smp_mb(unsigned long cnt)
+{
+	unsigned long start = local_clock();
+
+	while (cnt--)
+		smp_mb();
+
+	return local_clock() - start;
+}
+
+static unsigned long test_smp_id(unsigned long cnt, short *result, int *overflow)
+{
+	unsigned long start = local_clock();
+
+	while (cnt--) {
+		short cpu = smp_processor_id();
+		*result += cpu;
+		if (unlikely(*result == 0))
+			(*overflow)++;
+	}
+	return local_clock() - start;
+}
+
+static void test_foo(void)
+{
+	const unsigned long cnt = 10 << 24;
+	short result = 0;
+	int overflow = 0;
+	unsigned long v1, v2;
+
+	v1 = test_smp_mb(cnt);
+	v2 = test_smp_id(cnt, &result, &overflow);
+
+	printk("%s: smp_mb %lu smp_id %lu result %d overflow %d\n",
+			__func__, v1, v2, (int)result, overflow);
+}
+
 static int __init blk_mq_init(void)
 {
+	test_foo();
+
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
 	cpuhp_setup_state_multi(CPUHP_AP_BLK_MQ_ONLINE, "block/mq:online",


Thanks,
Ming

