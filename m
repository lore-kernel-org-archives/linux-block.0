Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0371C54EAA
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 19:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjAXTAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjAXTAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 14:00:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F024B4AD;
        Tue, 24 Jan 2023 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=fTKrUGmo2xI76Ulk1fO6voz5sz
        eEGFkip66Lx9z7P3mwJFubsvITYNyFty+6QLTASmuE7wu0dfpnoajUG8LNVxkasVpsDq/BvmvZNgJ
        fQyDyRgDBDbF7ix2r9OsWOemSiRqfQ1T+eDYz7EDhzJno83ADOb7PAR20+UE8OX1MMtfOXshp4CY7
        3FwoB/DPCX1zp0AdQM2OrVlhwox0rS9x+KeFzT+/xAcw78PaJG1j7nXw3ffaYv0CKjuMbrpsVlVLd
        VUHxPOaOp2Jn8poKyGvdeKMh3/YOenKl6xtTuGtHPEMc28gvz5rK2wrt8bZkUD8leVVKTtD1+ZBHd
        WrhREpHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKOX8-004zxq-Vl; Tue, 24 Jan 2023 19:00:38 +0000
Date:   Tue, 24 Jan 2023 11:00:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v9 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y9Aq1skiAoNRMnt6@infradead.org>
References: <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124170108.1070389-3-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
