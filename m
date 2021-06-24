Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D7FC48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 06:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D52613DC
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 06:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhFXGRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 02:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhFXGRt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 02:17:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5376AC061574;
        Wed, 23 Jun 2021 23:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cLzuPmWnT7cLiujhn4thtNqmsI+9nqkAPBiidz+Pv7g=; b=LnNOHZHtKXbwjS5bWMZWiVWL3Z
        AKCrIW0Xtsm+v5LCP0DX3MYeglxC5rgZk4Mr1XS/fx8ucOsAXd23y4YBcSkZZCQx5ap4LZvpvOfrU
        d5RdB6hYOUomIsh4reA72drdYZabPXDblv2uagadZOhcYpeOeaxNDImsuXDIZgc/6X62VXbB0jubU
        mJxnJLPS2dyJJ9USrazptFdP4S4/dJjJji524AlybvVN5Ku5aLKxCGPknQd08G67u6OBrEimTLTbi
        LZrEpPI4ZX7eOdxIUbpelNAT1KWinoRuA9MAD43B7ROOMHCsO+zytEWRCcxYBOUTUvTafnE1m4yR1
        Z/RQ4iuA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwIdI-00GFN6-4h; Thu, 24 Jun 2021 06:14:56 +0000
Date:   Thu, 24 Jun 2021 07:14:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Subject: Re: [RESEND PATCH] loop: fix setting arbitrarily large block size
Message-ID: <YNQizOHDSM0Y2Lz/@infradead.org>
References: <20210622161019.130090-1-chouhan.shreyansh630@gmail.com>
 <20210623050933.140572-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623050933.140572-1-chouhan.shreyansh630@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 23, 2021 at 10:39:33AM +0530, Shreyansh Chouhan wrote:
> REASON FOR RESEND: Fixed spelling of the Reported-by tag.

That goes under a "---" deliminator.

Except for that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
