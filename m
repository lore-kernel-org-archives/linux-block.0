Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A4FC433DF
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 04:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E099B204EC
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 04:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f90HLmxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEYEKK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 00:10:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23116 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725849AbgEYEKK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 00:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590379808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1KWB65Zd6HysINvlTNtvzqIZE9+EW9wQ3SY6GXwcmNY=;
        b=f90HLmxXL9Yzxt0RpRFSNHbf22a8h3tvTl/x+L+cCvXclxCfBz7/U01g4ZqwgUGFGh62SG
        DTIgz708bBj816+6ox/o7M/ZIgmxGVu8yLfKY6FCPgNEVh1XIMgk/4BBT+mSkqWD+B0a1l
        adVuJSC1yCXUIWZOnUkGmlv6OvP3ULs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-ozmA6KkgM_20Xt9D9-afjA-1; Mon, 25 May 2020 00:10:05 -0400
X-MC-Unique: ozmA6KkgM_20Xt9D9-afjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 160801855A02;
        Mon, 25 May 2020 04:10:04 +0000 (UTC)
Received: from T590 (ovpn-13-214.pek2.redhat.com [10.72.13.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FB475D9DC;
        Mon, 25 May 2020 04:09:57 +0000 (UTC)
Date:   Mon, 25 May 2020 12:09:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
Message-ID: <20200525040952.GB791214@T590>
References: <20200520170635.2094101-1-hch@lst.de>
 <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org>
 <20200521025744.GC735749@T590>
 <9249e1cc-b6f2-010e-78d2-ead5a1b93464@acm.org>
 <20200521043305.GA741019@T590>
 <7accb5b2-6c7d-0e0d-56df-d06e8d9ac5af@acm.org>
 <20200522023923.GC755458@T590>
 <26169cd9-49b8-b949-aaa3-9745e821c86c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26169cd9-49b8-b949-aaa3-9745e821c86c@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 23, 2020 at 08:19:58AM -0700, Bart Van Assche wrote:
> On 2020-05-21 19:39, Ming Lei wrote:
> > You may argue that two hw queue may share single managed interrupt, that
> > is possible if driver plays the trick. But if driver plays the trick in
> > this way, it is driver's responsibility to guarantee that the managed
> > irq won't be shutdown if either of the two hctxs are active, such as,
> > making sure that hctx->cpumask + hctx->cpumask <= this managed interrupt's affinity.
> > It is definitely one strange enough case, and this patch doesn't
> > suppose to cover this strange case. But, this patch won't break this
> > case. Also just be curious, do you have such in-tree case? and are you
> > sure the driver uses managed interrupt?
> 
> I'm concerned about the block drivers that use RDMA (NVMeOF, SRP, iSER,
> ...). The functions that accept an interrupt vector argument
> (comp_vector), namely ib_alloc_cq() and ib_create_cq(), can be used in

PCI_IRQ_AFFINITY isn't used in RDMA driver, so RDMA NIC uses non-managed
irq.

> such a way that completion interrupts are handled on another CPU than
> those in hctx->cpumask.

As I explained, this patchset doesn't rely on that interrupts have to
be fired on hctx->cpumask, and it only changes the submission io path,
which is blk-mq's generic code path which doesn't depend on any driver's
specific behavior.

Please let us know if your concerns are addressed.



Thanks,
Ming

