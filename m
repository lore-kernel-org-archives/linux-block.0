Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C98C433E9
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 12:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8DF64FF6
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 12:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhCKMMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhCKMMU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 07:12:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE70C061574;
        Thu, 11 Mar 2021 04:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6IphLa1vu9FDakL2WFdy6Jm1OLQgn4zG0/i0w9PLD8k=; b=loC0e72rjvitWO02FLCEm9fdYE
        +k4hUIMBzqlZU8+TpxMlq0XaVD3sxDeG8lEZp9Efe8KEzyw+Jfyy5IpebqbzHSuzfO91pbD15Xvkx
        AIVPf4na8YtJWJoFNe8/C0mJPy2OPG52YdWm2SOn1FHiVNiep97fFgaMMys6PxZQpO5DqCNL47Dfx
        tVC2+g0teLOak55bxoUigTp6wQwReLEEuFYkakhw15sQ3/JUSFxulVIioAz44POdHocFU0AFiSeyo
        EzKEw3y4zUbBWqOwvoa5P6dgKe7gyNTqQg8z/dirPLjZDQoPAL0/V63ifiWt7iagaUkBNQ3vJgKtZ
        YvgXcDhg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKKAC-007HtW-TD; Thu, 11 Mar 2021 12:11:43 +0000
Date:   Thu, 11 Mar 2021 12:11:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: rename BIO_MAX_PAGES to BIO_MAX_VECS
Message-ID: <20210311121136.GT3479805@casper.infradead.org>
References: <20210311110137.1132391-1-hch@lst.de>
 <20210311110137.1132391-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311110137.1132391-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 11, 2021 at 12:01:37PM +0100, Christoph Hellwig wrote:
> Ever since the addition of multipage bio_vecs BIO_MAX_PAGES has been
> horribly confusingly misnamed.  Rename it to BIO_MAX_VECS to stop
> confusing users of the bio API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

