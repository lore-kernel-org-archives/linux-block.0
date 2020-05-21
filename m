Return-Path: <SRS0=t9QE=7D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7236FC433DF
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 04:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376CD207F9
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 04:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1392m1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgEUEdV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 May 2020 00:33:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726282AbgEUEdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 May 2020 00:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590035600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDyGUh7s/5L2muUx6wj15QhxW1gKn4WuKlPuioZ7Nm8=;
        b=J1392m1/67pAb5Cb4HuQ68UnxrtwZTRh1c9hRXrf1ivXDl5VdjUwRES+844UxAo2wVS+KJ
        eNtSGHCkxAKKSOWAcnGW3t78gId+L95GeHHeoBOG4i/IfFCR3ZcmZjXjdZRLzv9TS2YpAj
        mcqReM7wjCXCI67mYq36YbRx3Bydf40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-Qjl8T8oUP8OCf2wndYx5UA-1; Thu, 21 May 2020 00:33:18 -0400
X-MC-Unique: Qjl8T8oUP8OCf2wndYx5UA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF351835B41;
        Thu, 21 May 2020 04:33:16 +0000 (UTC)
Received: from T590 (ovpn-13-123.pek2.redhat.com [10.72.13.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82E4219C4F;
        Thu, 21 May 2020 04:33:10 +0000 (UTC)
Date:   Thu, 21 May 2020 12:33:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
Message-ID: <20200521043305.GA741019@T590>
References: <20200520170635.2094101-1-hch@lst.de>
 <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org>
 <20200521025744.GC735749@T590>
 <9249e1cc-b6f2-010e-78d2-ead5a1b93464@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9249e1cc-b6f2-010e-78d2-ead5a1b93464@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 20, 2020 at 08:50:56PM -0700, Bart Van Assche wrote:
> On 2020-05-20 19:57, Ming Lei wrote:
> > On Wed, May 20, 2020 at 02:46:52PM -0700, Bart Van Assche wrote:
> >> If the CPU to which one of these interrupt vectors has
> >> been assigned is hotplugged, does that mean that four hardware queues
> >> have to be quiesced instead of only one as is done in patch 6/6?
> > 
> > No, one hctx only becomes inactive after each CPU in hctx->cpumask is offline.
> > No matter how interrupt vector is assigned to hctx, requests shouldn't
> > be dispatched to that hctx any more.
> 
> Since I haven't found an answer to my question in your reply I will
> rephrase my question. Suppose that there are 16 CPU cores, 16 hardware
> queues and that hctx->cpumask of each hardware queue i only contains CPU
> i. Suppose that four interrupt vectors (0, 1, 2 and 3) are used to
> report the completions for these hardware queues. Suppose that interrupt
> vector 3 is associated with hardware queues 12, 13, 14 and 15, and also
> that interrupt vector 3 is mapped to CPU core 14. My interpretation of
> patch 6/6 is that it will only quiesce hardware queue 14 but none of the
> other hardware queues associated with the same interrupt vector
> (hardware queues 12, 13 and 15). Isn't that a bug?

No.

If vector 3 is for covering hw queue 12 ~ 15, the vector shouldn't be
shutdown when cpu 14 is offline.

Also I am pretty sure that we don't do this way with managed IRQ. And
non-managed IRQ will be migrated to other online cpus during cpu offline,
so not an issue at all. See migrate_one_irq().


Thanks,
Ming

