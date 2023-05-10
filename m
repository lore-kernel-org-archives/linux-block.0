Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A98C7EE23
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 13:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbjEJNaF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 May 2023 09:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbjEJNaD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2023 09:30:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504AA243;
        Wed, 10 May 2023 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ig/btAIsBVJtBIcmizBBDUlSxVq17P4ydBb2TqMNRjo=; b=yQn4t+7GJgoKCj6/lFmHrQOrfu
        HhgN8UgRjJ+EjxZUPt45zyLX6SGz1wL/GuDRxENVAtmP7QJJ52WG739cfun2bLu43bz/eKe262eEn
        rPFejqY1OJKRw6jB03zlAW8ZVQSF4cwJ2Sbz/XULXIjWtGfPmkF7BcfQDpEfX239ohD7I1t/5uUp+
        3JMn8XVaYQZfoa+TOmUQEWKRor+JPLGqc76hIRsZQCeCAJ9YWk6e+SFYX/86s2QLUjicYh1QdGyCS
        SI0aRNDp8VyRIWE8FkcqmG14UI38kBzcCRSMS9AIjm1qEaHCN3efSthtKOsj07nQpvSv6ZOPeGElr
        5aPPEsjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwjtJ-006Ea4-0v;
        Wed, 10 May 2023 13:30:01 +0000
Date:   Wed, 10 May 2023 06:30:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: mark bdev files as FMODE_NOWAIT if underlying
 device supports it
Message-ID: <ZFucWYxUtBvvRJpR@infradead.org>
References: <20230509151910.183637-1-axboe@kernel.dk>
 <20230509151910.183637-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509151910.183637-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 09, 2023 at 09:19:09AM -0600, Jens Axboe wrote:
> We set this unconditionally, but it really should be dependent on if
> the underlying device is nowait compliant.

Somehow I only see patch 2 of 3 of whatever series this is supposed to
be in my linux-block mbox, something is broken with your patch sending
script.

The change itself looks fine even standalone, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>
