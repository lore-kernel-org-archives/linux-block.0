Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E44C433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 19:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJETKZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiJETKY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 15:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA0F1FCFD
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 12:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E27A617A8
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 19:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CE9C433D6;
        Wed,  5 Oct 2022 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664997021;
        bh=2sZjgBoMDyCv8ipVnlJBS5iwQiCAwcY2OkXAy98n6/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twqAJ/vHP3x0xFPLsLqmi5Vf+HcFQh8D+dRmg5gPjYwX84F3R5x65+OkPQ2v/vl2l
         L/0Oh/vOtPvFjkok0b1fk5STyNIRb9Ni/SWMGC1EOlSZP9P3cj0vQ7EGQ9g/coymsT
         nk500ue0fVCHYc+WP2rmVaxCTVR3xF/71XIxSpG0uQWOmgh6uX/YCwDs0xZ1Lkyyno
         2DE4YuLhEt8ma91EO6eymS3t23tdn8vLBKdCYSXm0IRLiMz/kNGKMrZLQ86Xnxmggg
         0qEZp84ru8jNx6C2n5qe6nBwiZOw066eoiFf3xIkT9l6ISysinBia22opGjmDjdKAZ
         ecGsvY3uVYLYw==
Date:   Wed, 5 Oct 2022 13:10:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Supporting segment sizes smaller than the page size
Message-ID: <Yz3WmusgrbomYqTk@kbusch-mbp.dhcp.thefacebook.com>
References: <3a32f6fd-af4a-3a81-67ad-7dc542bb6a3c@acm.org>
 <Yz24Ghonv2xmplz/@kbusch-mbp.dhcp.thefacebook.com>
 <6fd41ef7-a281-cf1b-1f1c-987679abfb24@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fd41ef7-a281-cf1b-1f1c-987679abfb24@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 05, 2022 at 11:23:32AM -0700, Bart Van Assche wrote:
> On 10/5/22 10:00, Keith Busch wrote:
> > If the hardware's DMA segment is smaller than a page, why doesn't the driver
> > just split a kernel's larger segment into whatever representation the hardware
> > wants? We do that in nvme, at least.
> 
> Hi Keith,
> 
> That's an interesting question. Your question made me realize that the
> bio_map_kern() changes I proposed can be dropped if the code for counting
> the number of segments is modified to support small segments.
> 
> My answer to your question is twofold:
> * Splitting segments in a driver is easy to do if that doesn't cause the
> number of segments limit to be exceeded (queue_limits.max_segments). It is
> the responsibility of the block layer to split bios that exceed the maximum
> number of segments into multiple bios - this is something that cannot be
> done in a block driver. This is why I think that a (small number of) block
> layer changes are needed.

I believe all bio's that bio_split() yields are supposed to be usable as-is
with the driver that created the queue limits. If the driver needs to split
further from there, I feel like that means the limits may need adjusting.

It sounds like max_hw_sectors is inconsistent with max_segments. Shouldn't this
work if max_hw_sectors was set to 'max_segments * logical_block_size'?

> * The blk_rq_map_sg() function really needs to be modified to support
> segments smaller than the page size.

That's surprising. We use that in nvme where merges and splits to 4k segments
are required, but it works with larger page sizes.
