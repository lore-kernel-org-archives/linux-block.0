Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC2C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75CC60F8F
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhJRIos (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhJRIor (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 04:44:47 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE99C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=aMZ5QFHGDye6zS7ef4zLlCk22f
        C2xG5cYFMkK4AfY+B2nfMw1Egtz2YC2NwEkSuTF7HD3JyZvuM98birFvtK3QRnmmiN8yVkjZk4J/u
        mBborJYCJqyE3uFEaBdCmwmqSl4RYh6DGH8mR4MulKLbpFLxinUiTeEdGqWKVWCc1cwwvk6UuaSgJ
        HjcAsqOLvtqHaxsm4tl39oVOICmxU4JKk4gzy3n24VIa3AocNIHGeS1qNFz3Nzzx6E5m0lEizxMSy
        MShEiZshu7+MI3CuO00mOCv8V0dZIGZ4S7KQYXLKjE7VVfbXb0pqhoA0Kxhc02Wb/F4hw8gD4k0a5
        dGhJw80g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOE8-00EgBh-1r; Mon, 18 Oct 2021 08:42:36 +0000
Date:   Mon, 18 Oct 2021 01:42:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 02/14] block: don't bother iter advancing a fully done bio
Message-ID: <YW0zfMRELFGXWwwi@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
