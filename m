Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A52AC433DF
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 00:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB9320704
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 00:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrnJsQDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgEZAh3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 20:37:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28448 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729327AbgEZAh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 20:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590453447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2DdwIsGhCExLtQFliGHzw4I7RVszsp9Sz6RzE1cOeco=;
        b=HrnJsQDKqT1StMW/Lr/Mfz5+39JhP3yeTJ9C06r4aMwHcVz0097TBPDVNuBZNOHQV1bN0J
        Gd7AToAO5ALVLj1Q0E182YXzsckx/BLewqlvSGjPovcRdjN0QtlXoyNAoICrJalDUjzDhI
        qsiaLiMVFhgEsZ5KlPKORfCI/oi//+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-cA5BJBngNiKiXehjTRYSfA-1; Mon, 25 May 2020 20:37:25 -0400
X-MC-Unique: cA5BJBngNiKiXehjTRYSfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3DE980183C;
        Tue, 26 May 2020 00:37:23 +0000 (UTC)
Received: from T590 (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4CD819D7C;
        Tue, 26 May 2020 00:37:17 +0000 (UTC)
Date:   Tue, 26 May 2020 08:37:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
Message-ID: <20200526003708.GA862273@T590>
References: <20200520170635.2094101-1-hch@lst.de>
 <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org>
 <20200521025744.GC735749@T590>
 <9249e1cc-b6f2-010e-78d2-ead5a1b93464@acm.org>
 <20200521043305.GA741019@T590>
 <7accb5b2-6c7d-0e0d-56df-d06e8d9ac5af@acm.org>
 <20200522023923.GC755458@T590>
 <26169cd9-49b8-b949-aaa3-9745e821c86c@acm.org>
 <20200525040952.GB791214@T590>
 <a89e6b92-8b43-ec1c-8e6b-7b842608ce5d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a89e6b92-8b43-ec1c-8e6b-7b842608ce5d@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 25, 2020 at 08:32:44AM -0700, Bart Van Assche wrote:
> On 2020-05-24 21:09, Ming Lei wrote:
> > On Sat, May 23, 2020 at 08:19:58AM -0700, Bart Van Assche wrote:
> >> On 2020-05-21 19:39, Ming Lei wrote:
> >>> You may argue that two hw queue may share single managed interrupt, that
> >>> is possible if driver plays the trick. But if driver plays the trick in
> >>> this way, it is driver's responsibility to guarantee that the managed
> >>> irq won't be shutdown if either of the two hctxs are active, such as,
> >>> making sure that hctx->cpumask + hctx->cpumask <= this managed interrupt's affinity.
> >>> It is definitely one strange enough case, and this patch doesn't
> >>> suppose to cover this strange case. But, this patch won't break this
> >>> case. Also just be curious, do you have such in-tree case? and are you
> >>> sure the driver uses managed interrupt?
> >>
> >> I'm concerned about the block drivers that use RDMA (NVMeOF, SRP, iSER,
> >> ...). The functions that accept an interrupt vector argument
> >> (comp_vector), namely ib_alloc_cq() and ib_create_cq(), can be used in
> > 
> > PCI_IRQ_AFFINITY isn't used in RDMA driver, so RDMA NIC uses non-managed
> > irq.
> 
> Something doesn't add up ...
> 
> On a system with eight CPU cores and a ConnectX-3 RDMA adapter (mlx4
> driver; uses request_irq()) I ran the following test:
> * Query the affinity of all mlx4 edge interrupts (mlx4-1@0000:01:00.0 ..
> mlx4-16@0000:01:00.0).
> * Offline CPUs 6 and 7.
> * Query CPU affinity again.
> 
> As one can see below the affinity of the mlx4 interrupts was modified.
> Does this mean that the interrupt core manages more than only interrupts
> registered with PCI_IRQ_AFFINITY?
> 
> All CPU's online:
> 
> 55:04
> 56:80
> 57:40
> 58:40
> 59:20
> 60:10
> 61:08
> 62:02
> 63:02
> 64:01
> 65:20
> 66:20
> 67:10
> 68:10
> 69:40
> 70:08
> 
> CPUs 6 and 7 offline:
> 
> 55:04
> 56:02
> 57:08
> 58:02
> 59:20
> 60:10
> 61:08
> 62:02
> 63:02
> 64:01
> 65:20
> 66:20
> 67:10
> 68:10
> 69:04
> 70:08

It is non-managed interrupt, and their affinity will be changed during
cpu online/offline by irq migration code, I believe I have shared the
function to you before.

The issue to be addressed is for managed interrupt only, which is shutdown
during cpu offline, that is why we have to make sure that there isn't
any in-flight io request. As Keith mentioned, their affinity is assigned
during creation, and won't be changed since its creation.

The suggested approach fixes the issue for managed interrupt, meantime
it is harmless for non-managed interrupt.


Thanks,
Ming

