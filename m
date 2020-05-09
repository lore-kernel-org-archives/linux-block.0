Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF194C28CBC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999D620722
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjR627R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgEID43 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 23:56:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43615 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbgEID42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 23:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588996587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8HUBPK9PAWz5vQwuWVxBM1qHVuYNuZJuX/G4G7+lzU=;
        b=cjR627R1oLCt3aIA6lSGHPgn/9hqnpiSFnAjFAti//qbwXirvVunAAST8GAQxg+cWY72ja
        k7tCOyYyI9ewHhlGFmeKFYnWEZTDRdKkas/9DW4MYgaKpgAOCpJerBh7aiRkQGumuhJCCE
        CBR3S5++MryLY0lORZKBszaQDIOg1A8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-AN7wLf3DOESsIP8-dPfStg-1; Fri, 08 May 2020 23:56:23 -0400
X-MC-Unique: AN7wLf3DOESsIP8-dPfStg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B61C1835B41;
        Sat,  9 May 2020 03:56:21 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E5E65EE0E;
        Sat,  9 May 2020 03:56:14 +0000 (UTC)
Date:   Sat, 9 May 2020 11:56:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V10 06/11] blk-mq: prepare for draining IO when hctx's
 all CPUs are offline
Message-ID: <20200509035609.GF1392681@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-7-ming.lei@redhat.com>
 <756074a0-ea4b-5dcf-9348-e5b4f4414248@acm.org>
 <20200509020926.GB1392681@T590>
 <d59e0c74-981d-6ed4-e80d-09b0cd4c17db@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59e0c74-981d-6ed4-e80d-09b0cd4c17db@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 08:11:55PM -0700, Bart Van Assche wrote:
> On 2020-05-08 19:09, Ming Lei wrote:
> > On Fri, May 08, 2020 at 04:26:17PM -0700, Bart Van Assche wrote:
> >> On 2020-05-04 19:09, Ming Lei wrote:
> >>> @@ -391,6 +393,7 @@ struct blk_mq_ops {
> >>>  enum {
> >>>  	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
> >>>  	BLK_MQ_F_TAG_SHARED	= 1 << 1,
> >>> +	BLK_MQ_F_NO_MANAGED_IRQ	= 1 << 2,
> >>>  	BLK_MQ_F_BLOCKING	= 1 << 5,
> >>>  	BLK_MQ_F_NO_SCHED	= 1 << 6,
> >>>  	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
> >>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> >>> index 77d70b633531..24b3a77810b6 100644
> >>> --- a/include/linux/cpuhotplug.h
> >>> +++ b/include/linux/cpuhotplug.h
> >>> @@ -152,6 +152,7 @@ enum cpuhp_state {
> >>>  	CPUHP_AP_SMPBOOT_THREADS,
> >>>  	CPUHP_AP_X86_VDSO_VMA_ONLINE,
> >>>  	CPUHP_AP_IRQ_AFFINITY_ONLINE,
> >>> +	CPUHP_AP_BLK_MQ_ONLINE,
> >>>  	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
> >>>  	CPUHP_AP_X86_INTEL_EPB_ONLINE,
> >>>  	CPUHP_AP_PERF_ONLINE,
> >>
> >> Wouldn't BLK_MQ_F_NO_IRQ be a better name than BLK_MQ_F_NO_MANAGED_IRQ?
> > 
> > No, what this patchset tries to do is to address request timeout or hang
> > issue in case that managed irq is applied in blk-mq driver.
> 
> What is a managed IRQ? The following query did not produce a useful answer:
> 
> $ git grep -nHi managed.irq

[ming@T590 linux]$ git grep -n MANAGED ./kernel/irq
kernel/irq/chip.c:188:  IRQ_STARTUP_MANAGED,
kernel/irq/chip.c:226:  return IRQ_STARTUP_MANAGED;
kernel/irq/chip.c:271:          case IRQ_STARTUP_MANAGED:
kernel/irq/cpuhotplug.c:179:    if (!housekeeping_enabled(HK_FLAG_MANAGED_IRQ))
kernel/irq/cpuhotplug.c:182:    hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
kernel/irq/debugfs.c:114:       BIT_MASK_DESCR(IRQD_AFFINITY_MANAGED),
kernel/irq/debugfs.c:115:       BIT_MASK_DESCR(IRQD_MANAGED_SHUTDOWN),
kernel/irq/internals.h:215:     __irqd_to_state(d) |= IRQD_MANAGED_SHUTDOWN;
kernel/irq/internals.h:220:     __irqd_to_state(d) &= ~IRQD_MANAGED_SHUTDOWN;
kernel/irq/irqdesc.c:487:                               flags = IRQD_AFFINITY_MANAGED |
kernel/irq/irqdesc.c:488:                                       IRQD_MANAGED_SHUTDOWN;
kernel/irq/manage.c:170: * AFFINITY_MANAGED flag.
kernel/irq/manage.c:241:            housekeeping_enabled(HK_FLAG_MANAGED_IRQ)) {
kernel/irq/manage.c:247:                hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);

The exact name should be AFFINITY_MANAGED, however the name of managed
irq has been used in commit log and isolation cpus code for a bit long.

OK, I will add comment on BLK_MQ_F_NO_MANAGED_IRQ a bit in next version.

Thanks, 
Ming

