Return-Path: <SRS0=6FHI=5E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B7C4332B
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 10:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF87C20722
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 10:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SRlXPmjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCSK3U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:29:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgCSK3U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 06:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fCY8Gzfxc8NXjz2Gm9F9aq07UE9vKpGpdgnqMBTKINc=; b=SRlXPmjk24Yn8ZQeewN+SsCBYN
        TD6uepDm3xw6YTwA+gyVay8tzP/iG9EdTW5G/R4W7bVuXDAGf7GY71D1orWo6iWjkP9h6VttDYdab
        xSphpUcKRRaRa36jJCCXAujM2TZUzwEHkqpDvqF7msqnCC8rUe8z75nuuDP5y4CgvBz6EqL3ZKhCR
        IUZKdZXzpHOKDHRmQY+mdUqa6iHCwQHe8QHicghkfZFAmWGXNF1Ux2Vos1xRma54/efsvbbelMgDo
        erOpCtavDZaRdo7sq8FEILfWUZIwW6Cjwx005AZR3xew53Y+XNXi22zpMjuMknZm/6yQnTXLLkgq+
        DEyBygHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEsQR-0007rE-DB; Thu, 19 Mar 2020 10:29:19 +0000
Date:   Thu, 19 Mar 2020 03:29:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH V2 2/6] block: use bio_{wouldblock,io}_error in
 direct_make_request
Message-ID: <20200319102919.GB26418@infradead.org>
References: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
 <20200309214138.30770-3-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309214138.30770-3-guoqing.jiang@cloud.ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 09, 2020 at 10:41:34PM +0100, Guoqing Jiang wrote:
> Use the two functions to simplify code.

I'd much rather kill these helpers rather than adding new users.
