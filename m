Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A5C38A2A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 02:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6978218AC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 02:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzLZ9WV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgEICJn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 22:09:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39782 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727828AbgEICJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 22:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588990181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HhKVXjP33V/M/mii7Fv/MRNhRKD2KQ5vhRoAtzMjA8w=;
        b=BzLZ9WV/87XjnReR9qaeeEdQnWrWwVWXrvtN0ffATDpngQvGNxXchfZyn9en01juoASTz5
        j9wo1wCEbZzFD0fPdqGaZ1BDYSNivwqTsf6zPSW/1+qCTjzkJxcWlgILw/8JP4UAxplStT
        z8mpOzAUDHaBy+2N7c+ixEMybXneZO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-X2rcIK5ROT6nsMWxVziQJw-1; Fri, 08 May 2020 22:09:39 -0400
X-MC-Unique: X2rcIK5ROT6nsMWxVziQJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 687651800D42;
        Sat,  9 May 2020 02:09:38 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BB7D25262;
        Sat,  9 May 2020 02:09:31 +0000 (UTC)
Date:   Sat, 9 May 2020 10:09:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V10 06/11] blk-mq: prepare for draining IO when hctx's
 all CPUs are offline
Message-ID: <20200509020926.GB1392681@T590>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-7-ming.lei@redhat.com>
 <756074a0-ea4b-5dcf-9348-e5b4f4414248@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <756074a0-ea4b-5dcf-9348-e5b4f4414248@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 04:26:17PM -0700, Bart Van Assche wrote:
> On 2020-05-04 19:09, Ming Lei wrote:
> > @@ -391,6 +393,7 @@ struct blk_mq_ops {
> >  enum {
> >  	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
> >  	BLK_MQ_F_TAG_SHARED	= 1 << 1,
> > +	BLK_MQ_F_NO_MANAGED_IRQ	= 1 << 2,
> >  	BLK_MQ_F_BLOCKING	= 1 << 5,
> >  	BLK_MQ_F_NO_SCHED	= 1 << 6,
> >  	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 77d70b633531..24b3a77810b6 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -152,6 +152,7 @@ enum cpuhp_state {
> >  	CPUHP_AP_SMPBOOT_THREADS,
> >  	CPUHP_AP_X86_VDSO_VMA_ONLINE,
> >  	CPUHP_AP_IRQ_AFFINITY_ONLINE,
> > +	CPUHP_AP_BLK_MQ_ONLINE,
> >  	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
> >  	CPUHP_AP_X86_INTEL_EPB_ONLINE,
> >  	CPUHP_AP_PERF_ONLINE,
> 
> Wouldn't BLK_MQ_F_NO_IRQ be a better name than BLK_MQ_F_NO_MANAGED_IRQ?

No, what this patchset tries to do is to address request timeout or hang
issue in case that managed irq is applied in blk-mq driver.

> 
> Please add comments that explain what BLK_MQ_F_NO_MANAGED_IRQ and
> CPUHP_AP_BLK_MQ_ONLINE mean.

I believe both are self-document:

- BLK_MQ_F_NO_MANAGED_IRQ
No managened irq is applied on the driver

- CPUHP_AP_BLK_MQ_ONLINE
It is a standard naming of cpuhp state, which means the startup and
teardown callbacks are called when the passed CPU is still online.


Thanks,
Ming

