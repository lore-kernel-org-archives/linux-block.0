Return-Path: <SRS0=FEuC=EL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A480C00A89
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE992151B
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 07:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pD+aJ1++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgKEHyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Nov 2020 02:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKEHyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Nov 2020 02:54:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932C2C0613CF
        for <linux-block@vger.kernel.org>; Wed,  4 Nov 2020 23:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mOhOWDxrQ1uCMUW6Zl0QtcyfSeit42+ZAPakn17q4ng=; b=pD+aJ1++EsMGx16o96Y7zHt5/C
        H4NxV8Uj0cBmLhFo2n9/lZamjmRO8udLakRtmd6g6Iuq/c2/SB89Sv+0kp+OOEiJol/mXaMCP9AwD
        nH7pJSRGsVWlh+p3Mw5PrkSA2EhEVNLyddRgVjq1ndSZBdkVCXtSbFEj5+tC8Oo03R2Qqw+YzIlJf
        BojrQtJFaC4yYmxIn1NosyJRwcwnDbAsgbHbxKRWNegfnnFCuh19xcE+f+wbLlDzvL1XKpqEsfFLr
        q7kNg0mLIBjJapnJCcTjz0mR04ya0Xkhz4Edy/I5ny/ptmIVB09yaOwv68eQmRqEYjYgxM3CozEyT
        GgXCkAQw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaa5q-00057b-9t; Thu, 05 Nov 2020 07:54:02 +0000
Date:   Thu, 5 Nov 2020 07:54:02 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Set mq device as blocking with zoned mode
Message-ID: <20201105075402.GA19304@infradead.org>
References: <20201105065008.401112-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105065008.401112-1-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 05, 2020 at 03:50:08PM +0900, Damien Le Moal wrote:
> Commit aa1c09cb65e2 ("null_blk: Fix locking in zoned mode") changed zone
> locking to using the potentially sleeping wait_on_bit_io() function. A
> zoned null_blk device must thus be marked as blocking to avoid calls to
> queue_rq() from invalid contexts triggering might_sleep() warnings.

That's going to have a fair amount of overhead.  Can't you change the
locking to avoid blocking?
