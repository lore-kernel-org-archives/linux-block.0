Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F2FC07E95
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649AE6113B
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhGTGfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhGTGfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 02:35:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D9C061574;
        Tue, 20 Jul 2021 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0JEfZeM7jWTdqkGOwm75oTN+mIvv+BDd9ZtRWA7fAfw=; b=GIWCL83ng7O/GpBekG+qOKxApC
        vrvxhb1gtP+le2Fp3fvzjFkQ4LKBWxoE4z7Q6MYytcj4ZqX2yXZ/RmsdAdcClRMydXdCxI8w5emPo
        cXGE7n7mVun1z6uT2t5f6CZ6CBVUlyR+uoi/3FQeHsU+Zh5E9aCro8tYwaSr37kGpw0zBFW8yrqRa
        ryNyvgso4SguKjwI+PkiDwkHMUzqyDJy+MR1GqkKFSs1WIDntETE1cX2tsUi9S4Mr+0wqlIRoe7Q8
        d9OQD7wbkR52IREfFZ7CwbPHRFeuNOFiUS8hsIinMs1wsdJdbz12QukztLR1vw2ilPk7amduUQjP/
        0sXobfpw==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jyY-007rRp-6y; Tue, 20 Jul 2021 07:15:47 +0000
Date:   Tue, 20 Jul 2021 09:15:33 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 13/17] iomap: Convert iomap_write_begin and
 iomap_write_end to folios
Message-ID: <YPZ4FTK88GrVGtZN@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:57PM +0100, Matthew Wilcox (Oracle) wrote:
> These functions still only work in PAGE_SIZE chunks, but there are
> fewer conversions from head to tail pages as a result of this patch.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
