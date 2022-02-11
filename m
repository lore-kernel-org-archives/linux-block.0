Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF5C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 07:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbiBKHH4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:07:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245460AbiBKHH4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 02:07:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D06B83
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 23:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d0QZXkLLKojKAc56/Df+ht9YCLX4xZHFMMyfs4XAEfM=; b=0lufZitZyUnoiI16IrAawmYQe3
        EHrJ32l3ieyoBcKoE+YGHWo3mVyyuC+20Q3+75hv5C0c9OulPontUaE1FufcviqtsVOpLn3XDNYpW
        3Kf5zQFRLiRepX35Px2JH7xs+S3snnjmq8l7pXJfZzExxodX7E+veNIo6WIIHUZX+X2GmiEWsBm/S
        LcDsl8O/WgKWeekLw1Mw9Zsstj9fX5Im66TP+b0BbWwlyyg7wCo7C7EEyn4/VV/yIDSGtS5SJGwvR
        lbmnqxp+hFGJqfG1U6XXn33hRcJncdj7hi/8mRzudpjefYBImtsAn2zETWbYELm8Pyap0EMlrMLZa
        SpTohcDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIQ26-0063nd-Pf; Fri, 11 Feb 2022 07:07:54 +0000
Date:   Thu, 10 Feb 2022 23:07:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 14/14] block: add bio_start_io_acct_remapped for the
 benefit of DM
Message-ID: <YgYLShZC1qboLQN4@infradead.org>
References: <20220210223832.99412-1-snitzer@redhat.com>
 <20220210223832.99412-15-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210223832.99412-15-snitzer@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 10, 2022 at 05:38:32PM -0500, Mike Snitzer wrote:
> DM needs the ability to account a clone bio's IO to the original
> block_device. So add @orig_bdev argument to bio_start_io_acct_time.
> Rename bio_start_io_acct_time to bio_start_io_acct_remapped.
> Also, follow bio_end_io_acct and bio_end_io_acct_remapped pattern by
> moving bio_start_io_acct to blkdev.h and have it call
> bio_start_io_acct_remapped.
> 
> Improve DM to no longer need to play games with swizzling a clone
> bio's bi_bdev (in dm_submit_bio_remap) and remove DM's
> clone_and_start_io_acct() interface.

Please split the core block layer part of this out, reorder it before
the current patch 10 and then do the right thing in that patch from the
start.
