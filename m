Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BCFC433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2ACC2053B
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590158844;
	bh=v+KpTGidsBSFyEC7zIsCAolTvEEnnWVNa9A/Q56N6Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eGWuV2MPOqnDW7m3X4ZGbJJivoe+RgXV0MW01lIofUpHJFwqSMlomkO+xPSJcB/4W
	 pZWa1nI1VgcjC8X1ATFAeVrP1hAM4flhKC8VNCqNV1wzCDUPp4fHcPizZDGjzetPsF
	 ++T7oS/rxExKRcxTavxSMpzCCLs8ewtiGF9Sd4EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgEVOrY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 10:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbgEVOrX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 10:47:23 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41C7204EF;
        Fri, 22 May 2020 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158843;
        bh=v+KpTGidsBSFyEC7zIsCAolTvEEnnWVNa9A/Q56N6Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zgf7eEynl4LQWxDQ5lOUoxUy9x9I48Ketf2rITSbgSRNcXvYiHA62Ygh97t2aNSho
         Q9c9HnuX6S9zJa68X9fV1ZyQxMO7GULpJ0U6HHRC6xySSBgRBBBIqLlmFZ7UWOK7yG
         Y9bgBDILNFvpGwlimD6OGQbJyOoYc/NGTpWAqYWg=
Date:   Fri, 22 May 2020 07:47:20 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
Message-ID: <20200522144720.GC3423299@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200520170635.2094101-1-hch@lst.de>
 <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org>
 <20200521025744.GC735749@T590>
 <9249e1cc-b6f2-010e-78d2-ead5a1b93464@acm.org>
 <20200521043305.GA741019@T590>
 <7accb5b2-6c7d-0e0d-56df-d06e8d9ac5af@acm.org>
 <20200522023923.GC755458@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522023923.GC755458@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 22, 2020 at 10:39:23AM +0800, Ming Lei wrote:
> On Thu, May 21, 2020 at 12:15:52PM -0700, Bart Van Assche wrote:
> > On 2020-05-20 21:33, Ming Lei wrote:
> > > No.
> > > 
> > > If vector 3 is for covering hw queue 12 ~ 15, the vector shouldn't be
> > > shutdown when cpu 14 is offline.
> > >> Also I am pretty sure that we don't do this way with managed IRQ. And
> > > non-managed IRQ will be migrated to other online cpus during cpu offline,
> > > so not an issue at all. See migrate_one_irq().
> > 
> > Thanks for the pointer to migrate_one_irq().
> > 
> > However, I'm not convinced the above statement is correct. My
> > understanding is that the block driver knows which interrupt vector has
> > been associated with which hardware queue but the blk-mq core not. It
> > seems to me that patch 6/6 of this series is based on the following
> > assumptions:
> > (a) That the interrupt that is associated with a hardware queue is
> >     processed by one of the CPU's in hctx->cpumask.
> > (b) That hardware queues do not share interrupt vectors.
> > 
> > I don't think that either assumption is correct.
> 
> What the patch tries to do is just:
> 
> - when the last cpu of hctx->cpumask is going to become offline, mark
> this hctx as inactive, then drain any inflight IO requests originated
> from this hctx
> 
> The correctness is that once we stops to produce request, we can drain
> any in-flight requests before shutdown the last cpu of hctx. Then finally
> this hctx becomes quiesced completely. Do you think this way is wrong?
> If yes, please prove it.

I don't think this applies to what Bart is saying, but there is a
pathological case where things break down: if a driver uses managed
irq's, but doesn't use the same affinity for the hctx's, an offline cpu
may have been the only one providing irq handling for an online hctx.

I feel like that should be a driver bug if it were to set itself up that
way, but I don't find anything enforces that.
