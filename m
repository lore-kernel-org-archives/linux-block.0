Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C232C7EE2C
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjEZOIJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243826AbjEZOII (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 10:08:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC9D1B1;
        Fri, 26 May 2023 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nSls6WusMV9eQbjvX1nCjw7apPoMaxbxishaTjsFxOM=; b=bBJBufxAR9x9jTqNFgBH/fC/sr
        1c55op1s+UENnoiFSRVxyiyVZ3ztMKHPzMHZ373cklRIEeNrqd5YKKmqqq1Qs8OFJU/1s245F8Evu
        1tKlPkf6HE6HBq2XiDoJvM7eSDPRyGzF5FK9EoZl8FDCoYqcBYvQRZKFK0DgIBe9B3Cn730Jht7Rn
        6+CAD9b90GWr+oF7vwsE0lk00kDGYsNxWl/GmW3RD67uA+Ovi9R8lada5SNzsPFT80COFYSo0vLDA
        nPvzqSsJVG+YLEEzNw+n3nIRzF9eef2gUtPjzUNwO0ZGPvae152HbnGsb1D217t5kl0fw/MvTK6vQ
        rgTEuG4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2Y6j-002rlh-Bv; Fri, 26 May 2023 14:07:53 +0000
Date:   Fri, 26 May 2023 15:07:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@kvack.org
Subject: Re: [PATCH] zonefs: Call zonefs_io_error() on any error from
 filemap_splice_read()
Message-ID: <ZHC9OUYAozDe1K/D@casper.infradead.org>
References: <3788353.1685003937@warthog.procyon.org.uk>
 <ZG99DRyH461VAoUX@casper.infradead.org>
 <9d1a3d1a-b726-5144-4911-de6b77d9bf02@kernel.org>
 <8b803ab8-f8ee-259f-8d30-1d14d34dc1e4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b803ab8-f8ee-259f-8d30-1d14d34dc1e4@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 26, 2023 at 08:46:44AM +0900, Damien Le Moal wrote:
> iomap_read_folio() or iomap_finish_folio_read() -> folio_set_error(), which sets
> PG_error. Then filemap_read_folio() will see !folio_test_uptodate(folio) and end
> up returning -EIO. So if there was an IO and it failed, we always get EIO,
> regardless of the actual reason for the IO failure. Right ?

Don't rely on that.  I have plans for returning the correct error.

Really we need a function that knows whether an errno is transient or
reportable.
