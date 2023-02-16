Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043CFC64EC4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 16:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBPQF6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 11:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBPQF5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 11:05:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F9C7EDC;
        Thu, 16 Feb 2023 08:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O2D5nW5XF0g0jK/l4mhY8Kd11zhtKlQjQHYsfFEYi8k=; b=BOszm+o5h2IqKAPTgvineJhAea
        5njh1E0Wi0DPv4RIPkbCEDECyFoJBLGQWhijTRvsq50RLhmsJ9q7Twk3vFILGej0Ezc3tm6UEqPmm
        5uc//W1Nob31knAR/L3gPhS0ABnv4ndc5CCmhWOuY4XAK5wF0UdNLCqrS0yHG8X+4g4Fx03H+rXs5
        F7Wq5FesPMOEKUmPwDlUyNlum6zuDsNCdj8lOoQwFUNCylo7TDtrtNLpy0hqqd8RnDx1Myi/LKfPC
        mKSrKrFABuuPoLUHRPbQejDPLQ+8fhqOqRwJxhkigsGvROFDgomcNaTrvGjIxmc++1q9JeOOHdsWg
        GN0bdBQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSgle-00B3OK-Ee; Thu, 16 Feb 2023 16:05:54 +0000
Date:   Thu, 16 Feb 2023 08:05:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/4] brd: return 0/-error from brd_insert_page()
Message-ID: <Y+5UYrUgp9lg8zRD@infradead.org>
References: <20230216151918.319585-1-axboe@kernel.dk>
 <20230216151918.319585-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216151918.319585-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> Cc: stable@vger.kernel.org # 5.10+

But why is this a stable candidate?
