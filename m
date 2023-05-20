Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836EBC77B7A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 04:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjETEPk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 00:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjETEP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 00:15:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF910FD;
        Fri, 19 May 2023 21:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=T5ffJSDJjBMY450PmCpkjhFuUG
        ppafp76gPq7Iy0s3s+0/qV5vHgj8TlbUIuy1ikGgrnvoQ+XczidH0E9hVnMTOEOTv511Y+ok/Bu/j
        Tem7BbS3lWWPV/4B+g67OSQh4HKRO/CtNwX7zlenyZV5A+71BsHFMQy3hbknzF8aJr5jRtRSy2jGS
        l07f/+FG+HQOKP1Mrq5uOFln/xNoxebnXWjWD+Q83ylC7lCmzk4bG2E99Pp/tsbDif2hl5ffrefOU
        IGG0iIWIlHAXkiNj+lWeyVaxwaTPKOtupQjiGRDE8Bm/UD4yske0NA+WLyk718KctZJiWFJJY/pmI
        o9koiq5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q0Dzs-000dyF-03;
        Sat, 20 May 2023 04:15:12 +0000
Date:   Fri, 19 May 2023 21:15:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v21 30/30] iov_iter: Kill ITER_PIPE
Message-ID: <ZGhJT6UB2FVYBdfU@infradead.org>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-31-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-31-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
