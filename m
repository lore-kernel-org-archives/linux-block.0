Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2013C38142
	for <linux-block@archiver.kernel.org>; Thu, 19 Jan 2023 05:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjASFtB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Jan 2023 00:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjASFr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2023 00:47:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914B5F39A;
        Wed, 18 Jan 2023 21:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bcCfF3JddQQaRi+Qwg225cXK+1VpaiGqs0+QIbuzZ0c=; b=L3xU3Vc/a+2biSox8fhwVVFsIr
        BJH9nIFV2M7nRY5LR1Nus9ulB6QFrduk70R5xgZBr0uMBxFRzDxPAIibWqN21u/6jDd3411cuLgmI
        NLbcwIDejFhcKmo2NXn2qDM3ROWInJFet94W5TbEWKdR5VlNafBtaa/IizCABlBtQEDBCsKy6Fkwb
        aITRoFCNMIUtm1vCc+wFisWVOIwtFWWaU05Iv9oOr3TMJURxjpvJ+2CFBQZ5Lfd6C+J5LMbjpj/ds
        Eusn7t5nlB+bTVwmjv1Gtp5gSXwAnQP5RDV4cmgMtQ9GZ5irDu6iZ5b6DKIjnioDTOYIVIcaUQfTB
        OU8CneOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pINm8-003hJ2-RG; Thu, 19 Jan 2023 05:47:48 +0000
Date:   Wed, 18 Jan 2023 21:47:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 03/34] iov_iter: Pass I/O direction into
 iov_iter_get_pages*()
Message-ID: <Y8jZhKTSYm36hw8T@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391050409.2311931.7103784292954267373.stgit@warthog.procyon.org.uk>
 <Y8ZU1Jjx5VSetvOn@infradead.org>
 <Y8h62KsnI8g/xaRz@ZenIV>
 <Y8iLsPlSLy5YVffX@ZenIV>
 <Y8imx/UQB/W/yONu@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8imx/UQB/W/yONu@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 19, 2023 at 02:11:19AM +0000, Al Viro wrote:
> PS: Documentation/driver-api/pci/p2pdma.rst seems to imply that those
> pages should not be possible to mmap, so either that needs to be
> updated, or... how the hell could we run into those in g-u-p,
> anyway?  Really confused...

Yes, that needs an update.  That limitation was from before the
mmap support was added.
