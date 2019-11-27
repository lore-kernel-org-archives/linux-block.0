Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFFFC432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 18:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FF520835
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 18:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574878643;
	bh=VWX/yO9DaPITM0/vWZ09RFb6PLBlIB3+UWPycaDaxB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=shSJE+cSUyOTUppWXykL1WyDxOQtu+MUB52AXWbBM3l6eRIz6W4iZp3273naMTOqW
	 AupaEUPOp5/3U+28ZyEaqCzgVzP1rnwqDc+GC2sWR/6ZNpsALNWKr68/CNwoyB2s9w
	 CRYOi8w+Du9IUNoEhSWdKAJdS0cUUXYijWN9wLC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfK0SRW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:17:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfK0SRW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 13:17:22 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48F32070B;
        Wed, 27 Nov 2019 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574878641;
        bh=VWX/yO9DaPITM0/vWZ09RFb6PLBlIB3+UWPycaDaxB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgyOx1vKWxkW0yxbl7C59Wjk3T+MSlcQg8O2p4fz9nW1rcCmaKWxWA4nzv9kO22xU
         KGnwN+CUYiurs5pkZo5sj9FDYvHwVEtC1lWPtfiRAp2f5wrtB0jXqXS9XJLLNLjSAF
         AjRy8KvaDoeDnFOR70IKajHfcLOX60ehHM9QOb0k=
Date:   Wed, 27 Nov 2019 10:17:21 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block_size are
 changed
Message-ID: <20191127181721.GA41818@jaegeuk-macbookpro.roam.corp.google.com>
References: <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
 <4ab43c9d-8b95-7265-2b55-b6d526938b32@acm.org>
 <20191126182907.GA5510@jaegeuk-macbookpro.roam.corp.google.com>
 <73eb7776-6f13-8dce-28ae-270a90dda229@acm.org>
 <20191126223204.GA20652@jaegeuk-macbookpro.roam.corp.google.com>
 <e64f65cc-d86f-54b9-8b4d-fe74860e16ea@acm.org>
 <20191127000407.GC20652@jaegeuk-macbookpro.roam.corp.google.com>
 <3ca36251-57c4-b62c-c029-77b643ddea77@acm.org>
 <20191127010926.GA34613@jaegeuk-macbookpro.roam.corp.google.com>
 <5e322380-0f3a-59ad-9d0d-2e1a4a9b676e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e322380-0f3a-59ad-9d0d-2e1a4a9b676e@acm.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27, Bart Van Assche wrote:
> On 11/26/19 5:09 PM, Jaegeuk Kim wrote:
> > +	if (drop_request)
> > +		blk_set_queue_dying(lo->lo_queue);
> >   	/* I/O need to be drained during transfer transition */
> >   	blk_mq_freeze_queue(lo->lo_queue);
> 
> Since blk_set_queue_dying() calls blk_freeze_queue_start(), I think the
> above code will increase q->mq_freeze_depth by one or by two depending on
> which path is taken. How about changing the above code into the following:
> 
> 	if (drop_request) {
> 		blk_set_queue_dying(lo->lo_queue);
> 		blk_mq_freeze_queue_wait(lo->lo_queue);
> 	} else {
> 		blk_mq_freeze_queue(lo->lo_queue);
> 	}

Done.

> 
> Otherwise this patch looks good to me.
> 
> Thanks,
> 
> Bart.
