Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA43C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 01:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B62D60F94
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 01:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhHDBZ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 21:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232195AbhHDBZ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Aug 2021 21:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628040345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6zK/CzShiDYR1dHS5Ugjkc4jSmRoTgaCmqH5wmcLlA8=;
        b=XAsgvpytPr6ecRKNgvgX+Xof5Jgv5KabbUNacen4qNPLOhzedDdGXx0SNtLSV4GkNC0uQ/
        PgFUdh9kxEqoHFmeo5juTwod+6IJoaoF4Sv6W2Zjxt4FLRG/9aZtg9B43cj0TA8lilHjP2
        icjmfzJxPIHevYbgSV5l4P122WAQ8YM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-KVHwB65EMsuqIpYC4VDdPg-1; Tue, 03 Aug 2021 21:25:42 -0400
X-MC-Unique: KVHwB65EMsuqIpYC4VDdPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E2E8107ACF5;
        Wed,  4 Aug 2021 01:25:41 +0000 (UTC)
Received: from T590 (ovpn-13-3.pek2.redhat.com [10.72.13.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BDB819CBA;
        Wed,  4 Aug 2021 01:25:31 +0000 (UTC)
Date:   Wed, 4 Aug 2021 09:25:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
Subject: Re: [PATCH] blk-iocost: fix lockdep warning on blkcg->lock
Message-ID: <YQnskyUwX+3icYyU@T590>
References: <20210803070608.1766400-1-ming.lei@redhat.com>
 <d5b57c0b-4b2a-8ab6-e446-3353f0805fac@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b57c0b-4b2a-8ab6-e446-3353f0805fac@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 03, 2021 at 07:02:28AM -0600, Jens Axboe wrote:
> On 8/3/21 1:06 AM, Ming Lei wrote:
> > blkcg->lock depends on q->queue_lock which may depend on another driver
> > lock required in irq context, one example is dm-thin:
> > 
> > 	Chain exists of:
> > 	  &pool->lock#3 --> &q->queue_lock --> &blkcg->lock
> > 
> > 	 Possible interrupt unsafe locking scenario:
> > 
> > 	       CPU0                    CPU1
> > 	       ----                    ----
> > 	  lock(&blkcg->lock);
> > 	                               local_irq_disable();
> > 	                               lock(&pool->lock#3);
> > 	                               lock(&q->queue_lock);
> > 	  <Interrupt>
> > 	    lock(&pool->lock#3);
> > 
> > Fix the issue by using spin_lock_irq(&blkcg->lock) in ioc_weight_write().
> 
> This looks fine to me for blk-iocost, but block/blk-cgroup.c:blkg_create()
> also looks like it gets the IRQ state of the same lock wrong?

blkg_create() is called with irq disabled in all three callers: 
blkg_lookup_create(), blkg_conf_prep() and blkcg_init_queue().

-- 
Ming

