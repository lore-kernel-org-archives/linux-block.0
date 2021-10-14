Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26025C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F0A6109F
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 16:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhJNQId (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhJNQId (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 12:08:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDDEC061755
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EZDHMZjr9dwMYerrCv25nFe5sMwH7xY3Tht931Ok2ws=; b=sSlzqd1k+u2UWvYBwryuKmoAO0
        E3JJPVVL8SJdC3AHGXdBoTFYm5sgl68xnQuWfa0Lnb9T6UnzCEMBtrVnWzjCeBeomnN6I8eAHDDR6
        TKUVG2nnWA/8LgbnB6AsOV7bRU9XSD5SoSrBB8BSNhXlIcWjdDUzQm9MEaOBKWgvzLHn2IYjNmkph
        jADeBwk9JUH0P8w7mt2LsC90saqOIBzFu69jizfQ+2PNG8v5GZd/sDfXW68HIaog8W1lwM1pPOWE3
        mTWKndDFboPTTL9n8QXvpZ2hhbMzn1Re6XgNhuK/dxdKMprpL9br/n+Vu7pjg6yqpidM11g8U1gO4
        xaOrcVqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb3FT-003ms8-Sf; Thu, 14 Oct 2021 16:06:27 +0000
Date:   Thu, 14 Oct 2021 09:06:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/9] block: define io_batch structure
Message-ID: <YWhVg94mX3RqV9Iz@infradead.org>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-2-axboe@kernel.dk>
 <YWfEALs4P+bGQtY9@infradead.org>
 <1db96336-fad5-b2bc-98c8-33336790e785@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db96336-fad5-b2bc-98c8-33336790e785@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 14, 2021 at 09:50:10AM -0600, Jens Axboe wrote:
> On 10/13/21 11:45 PM, Christoph Hellwig wrote:
> > On Wed, Oct 13, 2021 at 10:54:08AM -0600, Jens Axboe wrote:
> >> This adds the io_batch structure, and a helper for defining one on the
> >> stack. It's meant to be used for collecting requests for completion,
> >> with a completion handler defined to be called at the end.
> > 
> > Isn't the name a little misleading given that it is all about
> > completions?
> 
> It is for completions, but I'd rather just keep it short for now.

I'd go for something like io_comp_batch or something like that at least.

> > Also I wonder if this should be merged with the next patch as that's
> > sortof a logical unit.
> 
> Actually was like that before, I can fold them again.

I'm fine either way.  Merged just seems a little more logical.
