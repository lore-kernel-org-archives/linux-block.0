Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0938CC433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 17:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJERAS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 13:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJERAQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 13:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF65A248F7
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 10:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 676CB613B3
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 17:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4287CC433D6;
        Wed,  5 Oct 2022 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664989213;
        bh=ZU+Vi7GwQHkAhx4h3CNHVKarZ535ozOv0/0B5tys4NU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErEAbLZrTERT4YwJb0cinJKjMzcL0EfpBpCjFiNdGwp/956Y3/x3ISViYWo5BdaSq
         sO8dVDT8dmQjV//JQUaa3CfawaRySV8wc5peUNnfg20+LNmgFynUUQ888xu+Whkn5X
         bSjBl0955Yom0d8+fWLqxGkllPiZ0xNFgSbZ43e3DKvN7qb7VZZlyOVvg174TSxAxC
         m1PwfJ1VG8lqFRf41q9QPAUjNvHCzjftmErbUcyvJRHg00+hnj2+sknOW3Uy4mKqZO
         TpkeAG0YThzi2IucZQyE2+fdpt7hMECM9msBR9ErUWi0PLdgsOFdeeBVdnpSyXbkWT
         9jith3XD3nFEA==
Date:   Wed, 5 Oct 2022 11:00:10 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Supporting segment sizes smaller than the page size
Message-ID: <Yz24Ghonv2xmplz/@kbusch-mbp.dhcp.thefacebook.com>
References: <3a32f6fd-af4a-3a81-67ad-7dc542bb6a3c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a32f6fd-af4a-3a81-67ad-7dc542bb6a3c@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 04:28:32PM -0700, Bart Van Assche wrote:
> Hi Jens, Christoph and Ming,
> 
> As we know the Linux kernel block layer does not support DMA segment sizes
> that are smaller than the page size. From block/blk-settings.c:
> 
> void blk_queue_max_segment_size(struct request_queue *q,
>                                 unsigned int max_size)
> {
> 	if (max_size < PAGE_SIZE) {
> 		max_size = PAGE_SIZE;
> 		printk(KERN_INFO "%s: set to minimum %d\n",
> 		       __func__, max_size);
> 	}
> 
> 	/* see blk_queue_virt_boundary() for the explanation */
> 	WARN_ON_ONCE(q->limits.virt_boundary_mask);
> 
> 	q->limits.max_segment_size = max_size;
> }
> 
> I have been asked to add support for DMA segment sizes that are smaller than
> the page size to support a UFS controller with a maximum DMA segment size of
> 4 KiB and a page size > 4 KiB (my understanding of the JEDEC UFS host
> controller specification is that UFS host controllers should support a
> maximum DMA segment size of 256 KiB). Does anyone want to comment on this
> before I start working on a patch series?

If the hardware's DMA segment is smaller than a page, why doesn't the driver
just split a kernel's larger segment into whatever representation the hardware
wants? We do that in nvme, at least.
