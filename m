Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B53C433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiFAGFL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349743AbiFAGE6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:04:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086226BFF4
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ehhboq+xQ4RPKni1YgZVFfguyy2dmTUCMxTrdoJ9i0w=; b=X2FYbKrGZlRPNYWuTxv/uqy/ye
        dlXHM9+xNNqX2YhWZTuYy38oDp6JXPDdhf0dBSs1PibW4MayM/bMloEbDdhv1XpmPpKdxJR2gaS2l
        N5rR+pcBRDHQZsSEUro5klbEmighTCvBvmI0NRizaai9UPtUWRPrVApwKyJn/VdQFMewYZrie6xxH
        e84loN4isrT5Llqb2v2EqHFO1SDYCnjgkY04sbV41NqkowWzkUtC/rc9aQ1LkZQPg65zntbKcXNVJ
        ZJDJAKKVPQ+yMUszSSQviaM1zAlDKiIU6id9ndo5PwGE///afMhPIHRirNT2f8zYL0z9x0FQVT1Iy
        T/yyC2Tw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwHTN-00E3XW-HC; Wed, 01 Jun 2022 06:04:49 +0000
Date:   Tue, 31 May 2022 23:04:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        david@fromorbit.com
Subject: Re: bioset_exit poison from dm_destroy
Message-ID: <YpcBgY9MMgumEjTL@infradead.org>
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpZlOCMept7wFjOw@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 31, 2022 at 02:58:00PM -0400, Mike Snitzer wrote:
> Yes, we need the above to fix the crash.  Does it also make sense to
> add this?

Can we just stop treating bio_sets so sloppily and make the callers
handle their lifetime properly?  No one should have to use
bioset_initialized (or double free bio_sets).

