Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917B6C433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Dec 2021 17:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhLMRRf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Dec 2021 12:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhLMRRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 12:17:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA75C061574
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 09:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+05p/7Mp0OvvYyO57rKM1rLjqwHmQpPLD/fIlXdK2/U=; b=QLKi+rAog4IB5aWea1KjT1TVoS
        4b4y8Lxi1tzwjgaFFfaske38Wxv5x9thFtK1uzxcjFkR7Z4Td0UV/4vsMdB7yWgUzKoSxcEeWsm32
        XiBVnsdND0oXDLlbwdTl4JX9VkAqeHVWPWQnuoTFx8u/tPjNxMy/jGL83oy8cHAVheRgJc8Gac0lx
        I0y/m6Xp3ak8Jt0SBdoXORy4ayUL3EMIOZE2XoIt/Fz98mtZ63XFq71cljkdWXpl3NHJiru4Ekz1A
        Xj5MtRKS3pJOO8fW80RBFBg9R1sJpjOe08v0YpP1/+ouyfSbUepzMkaPCa/IXC2Y7Za4QUrfK3jld
        fTkTP6+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwoxB-00Aojv-Rn; Mon, 13 Dec 2021 17:17:33 +0000
Date:   Mon, 13 Dec 2021 09:17:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] bdev: Improve lookup_bdev documentation
Message-ID: <YbeALdQs/oPvCVq7@infradead.org>
References: <20211213171113.3097631-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213171113.3097631-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 13, 2021 at 05:11:13PM +0000, Matthew Wilcox (Oracle) wrote:
> Add a Context section and rewrite the rest to be clearer.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
