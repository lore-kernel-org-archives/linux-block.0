Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F2C433EF
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 05:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF2B6127C
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 05:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhKEFnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Nov 2021 01:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhKEFnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Nov 2021 01:43:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484EC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 22:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jDsjMMZ/chDIayukiIYjUUPrC4Llh76SzUaEEaohn+A=; b=vmio49edrORYcwZGqC0KOiGxVh
        2oSGss816T7Uz+7E3l4uvEJaWgLXz+KUGISNL1GPomT2sq9UbRKEdI5tvGaugPQE7h9U+0rOLvmSu
        BztA0wgWzTKCzbuq9iw4Rk0gTERoeIClVMVlQak2hEvnxBgCxRyg5lC8fe9qSxvcpDkbTaKDlhXj5
        f3huQnXBDytsMd1sDKFMGxTMTG/Y8y5IaQUbYsQrUBt7F0b2WeRAUZHFaL594ISXqzBqJrPIw1agZ
        hgUg+44eso03rjslYtnOtkuckeG3PUU3LD7A1FhP2kxjL/L06q99uhAjzYfAD4vJ59vyZUwTet+YN
        fSQcZpEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miryT-00Ae5v-CS; Fri, 05 Nov 2021 05:41:13 +0000
Date:   Thu, 4 Nov 2021 22:41:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: use new bdev_nr_bytes() helper for
 blkdev_{read,write}_iter()
Message-ID: <YYTD+fWMjUIflBdd@infradead.org>
References: <a72767cd-3c6d-47f7-80f4-aa025a17b2cb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a72767cd-3c6d-47f7-80f4-aa025a17b2cb@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 03:13:17PM -0600, Jens Axboe wrote:
> We have new helpers for this, use them rather than the slower inode
> size reads. This makes the read/write path consistent with most of
> the rest of block as well.
>     
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
