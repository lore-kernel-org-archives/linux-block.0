Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE725C05027
	for <linux-block@archiver.kernel.org>; Mon, 23 Jan 2023 18:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjAWSXb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjAWSXU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 13:23:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02057ECB;
        Mon, 23 Jan 2023 10:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jro1OgFz3nHA/h/jH055ueuWyG/LLRpqBegBXd/gDX0=; b=4owDX6j7uUmpCc2baVXyymap5u
        xXRT/cYeGTbCI/kr7jZ5gkCQSLDA2IAZXa5QELG+PzbsqEPUBzN0o1kuKZ+Ja5/h/QJfnb63Enuql
        LHm8UZA8p8uoPPYFzHUwO2xwU6yU2w1+Ezb8p3P9nmEsfg8f1g0ywoEktFtyabXEaBvPmH8VNmGBj
        Batzxj1r05Cm34cb4HBoFoOhnKzt8TLoepKhiBcGzsXLwQMzBE1WQHEQ5vGWYdraQPilNeY+Cdj5P
        pW7zPNJGjzDrJDdy4sbLeRKxDi9zMmDOSGJMgZT/7A9LK86aS/D9LDDtgmUyiiTTyBYqdAZA1r8ff
        oDGiMJ5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK1TF-0010F1-Uu; Mon, 23 Jan 2023 18:23:05 +0000
Date:   Mon, 23 Jan 2023 10:23:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 06/10] block: Rename BIO_NO_PAGE_REF to
 BIO_PAGE_REFFED and invert the meaning
Message-ID: <Y87QiZySXU49o8/w@infradead.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123173007.325544-7-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think the subject is incorrect.  It's not really renamed but
inverted.
