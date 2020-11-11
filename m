Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F3C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE72206CA
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="do7p6NPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgKKIOV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKIOV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:14:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC66C0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 00:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N4z/6/72BXLIk1uBHvx/BUWDDEcIKmXizcdYOcGF2oA=; b=do7p6NPA6pb9ObdMSz7v8ESrHv
        j9UlcFCjsxF3clUE/lGYvQhHBPj3mDyWralsc9SdjPUH0WSaWf+xFx4AsV0SkBLZa2vAXVFPufIPp
        H2f71DvxwqZNb0ELwdmFwErDoF35fkAduV8hecxHO1RdlfI8pvBbPHrJzGItf6A+ocmjdgK4R7AOP
        inK2DWumSgA+5pE/BYnk4La5WtXvAMdjcSOWyvgxV0yPLB00isrijyJbmpLThH8BGjAiIc+cY9rjK
        dvfp1NQSRnxQELYwqbalENPwU5+6BEItDItath0t1JtbFGgGYYrpAoU8zkobQWdNKlWrlsRINA8nP
        xLtku34Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclGl-0006dX-L6; Wed, 11 Nov 2020 08:14:19 +0000
Date:   Wed, 11 Nov 2020 08:14:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 7/9] null_blk: discard zones on reset
Message-ID: <20201111081419.GF23360@infradead.org>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-8-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111051648.635300-8-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 11, 2020 at 02:16:46PM +0900, Damien Le Moal wrote:
> When memory backing is enabled, use null_handle_discard() to free the
> backing memory used by a zone when the zone is being reset.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
