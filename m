Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13142C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 03:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjEaD6h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 23:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjEaD6Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 23:58:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6B819A;
        Tue, 30 May 2023 20:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DZmcrb5vNIv36agVjGva8gNY+d
        Bp2tWJDzMNDQR2uJkwhjSJ5H1K9CCsicALXEcOr0wiQhpV1PFhaKGh4K+bQfUaGdX0muTiiXSEyNS
        bZlybfS0yefh2jakuWAUx4rEGDTCUqDWUpmc9sOTdTnVE/zPcX3eC8UUYBF30VJpL81rDjOmtl1Ly
        S/IkRA2GEFl+28dc4HRKw4jTZABJXfWuJg+PEn8U+oyr0zXGdcNakJfQYJsd9Kz9FkgjxWqgEO8Dc
        8vOSOngxwsLq18SN5GkU5ddVpD6cDohHnCQ2Bt6eZu0uwXio5lEZkiJ/LF9glRzW4kh88bze+VCfj
        T20OJhqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4CyO-00FyLX-20;
        Wed, 31 May 2023 03:58:08 +0000
Date:   Tue, 30 May 2023 20:58:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 3/3] block: Use iov_iter_extract_pages() and page
 pinning in direct-io.c
Message-ID: <ZHbF0AhT/9GRXaTk@infradead.org>
References: <20230526214142.958751-1-dhowells@redhat.com>
 <20230526214142.958751-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526214142.958751-4-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
