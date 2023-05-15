Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6705DC77B75
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 09:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbjEOJbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbjEOJag (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 05:30:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE8710DD
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 02:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=kDNnbFmA9B2JuKE2nu5OtWbN+n
        y8NGjfEDrgRWSVs6ZuZV3/pxxrt8D9AjHfFn0pUhaQ8OyLw4ZvF7/GsbUqg1Mo06F/UlWgUXD3foo
        iwRvXC/ArXH6X8VBD0sZQkVs5QIPItbynzA4WbmMSPvYfsK7eT2w14SgPF3gC3oGsI5LdGchD1veY
        h9pjlurLGPs8WJtAhfAmJ6KDi/wbXzMUves4b+Vgwax2QPX9c0AWuTxa+GM59XZBpe8vm/JY1zr9s
        oOPLWB7oA/Pvgbgjm0shC6oa0F0C5DdXKZA1Dz3tn6CQeTM+jkh/4n58mxClUnGPXI8rvSkn6vxty
        BoziSxKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pyUX8-001YNI-0E;
        Mon, 15 May 2023 09:30:22 +0000
Date:   Mon, 15 May 2023 02:30:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Deny writable memory mapping if block is read-only
Message-ID: <ZGH7rgU9UwnAp0On@infradead.org>
References: <20230510074223.991297-1-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510074223.991297-1-loic.poulain@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
