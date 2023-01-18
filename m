Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88FC004D4
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 05:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjARFg4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 00:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjARFgz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 00:36:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900453FA2
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 21:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jicmO+qLhR/0pAflbFW7LyICltiXGSLxbHJZPHPT8yo=; b=lgqC0xvR72GAufuVCani4lz1/E
        zlt6B/fO5lFVIsTIcNhU2Jdnkrk23RzWhuCf6FoCW8NL2fA9GdmlZnrNuMZy+o6v9U+dxnlGJUKES
        UQHlL8vVdiGpjDp9maEp0RnNLVGCDojzzx41oDm/+oNrVMrU3BiQZlYFdnEBJJ8bW9yV5um2chE7U
        6nGYfU0YnNcOWu8J28BgcD4dvoMUDTZlLSZS/g/f1ncSusgXMUkBswUi5+LeDnsOt534EQmy95pwZ
        nBFAVcKm+k+MjUwdDRc4MGOU4ljtTiwcl+u9Oktat54u15Sy7I6FLMtp0N45CcdtA8zAgOCt0qpKL
        bT+3dAzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI17y-00Gzhg-UX; Wed, 18 Jan 2023 05:36:50 +0000
Date:   Tue, 17 Jan 2023 21:36:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH for-next] block: fix hctx checks for batch allocation
Message-ID: <Y8eFcnOGd1xgemXY@infradead.org>
References: <80d4511011d7d4751b4cf6375c4e38f237d935e3.1673955390.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d4511011d7d4751b4cf6375c4e38f237d935e3.1673955390.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 17, 2023 at 11:42:15AM +0000, Pavel Begunkov wrote:
> It might be a good idea to always use HCTX_TYPE_DEFAULT, so the cache
> always can accomodate combined write with read reqs.

I suspect we'll just need a separate cache for each HCTX_TYPE.
