Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F00BC07E9B
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 00:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7909F610F7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 00:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhGTXbn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 19:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhGTXbn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 19:31:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97BA36101B;
        Wed, 21 Jul 2021 00:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626826339;
        bh=E65jLqKjRMg5Qkn2BhBuKgQbm8+Mo4vJ7cckyConMrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBguU6Ty/PN6IkRXHSBTi4XYh+X8QVVMD+fjGhgtbhCI5v/+LFaBwUNLGJmABMBlx
         dAjP9CclOrrJWP/+ZcleVIZUrHBzPys/XfvbFOYXx6hx90c8QXDuzfM4/+lYuqv+01
         lIzktlI9vcvimUPaU3FMizlT60kkagDCIU6xy3Zu5aDXEK3OBIoyPYrBPsv8FH3QMV
         gPCJFhbE58hWo4Hv9QDicgoFudVJ1NHgx0QpxZp6/BXPGSSB4/pe5YnZOh8dzv5zHk
         U9Zu/m0DKjFbajve8zzo+w/hSEs8YOW0haTyzOaNykWNzGpWxkuSb0qZfrGqTympdt
         vIaNLmBsJsr5Q==
Date:   Tue, 20 Jul 2021 17:12:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 16/17] iomap: Convert iomap_add_to_ioend to take a
 folio
Message-ID: <20210721001219.GR22357@magnolia>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-17-willy@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 07:40:00PM +0100, Matthew Wilcox (Oracle) wrote:
> We still iterate one block at a time, but now we call compound_head()
> less often.  Rename file_offset to pos to fit the rest of the file.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Everything in this patch looks ok to me, though I gather there will be
further changes to bio_add_folio, so I'll leave this off for now.

I /am/ beginning to wonder, though -- seeing as Christoph and Matthew
both have very large patchsets changing things in fs/iomap/, how would
you like those landed?  Christoph's iterator refactoring looks like it
could be ready to go for 5.15.  Matthew's folio series looks like a
mostly straightforward conversion for iomap, except that it has 91
patches as a hard dependency.

Since most of the iomap changes for 5.15 aren't directly related to
folios, I think I prefer iomap-for-next to be based directly off -rcX
like usual, though I don't know where that leaves the iomap folio
conversion.  I suppose one could add them to a branch that itself is a
result of the folio and iomap branches, or leave them off for 5.16?

Other ideas?

--D
