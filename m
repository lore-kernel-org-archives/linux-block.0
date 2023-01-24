Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24D5C25B4E
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 18:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjAXS4m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjAXS4i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 13:56:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922684A1D3;
        Tue, 24 Jan 2023 10:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=USehrrCmHIYmAtAVp+Hq6ESll3k6vzjUJXTQ0yO2A10=; b=4QVsxtF+2S1GZWQ7FNHOwtWMEr
        lqhsMFruas0dbXqRkR+Gqr7pVTId+cLj4d+5GQRvFFFOw46RV+MBgUb4e8y548WHAeOBvIY2WWmRS
        JDnqKqKewBp5lbUqY1+kHe6VKu5CfWHEi7DcGJETLHauVnsRc+R1ZFe8Ro0lCrN5pgUD+aG6ONewd
        HEU4paWA+BuSzoCG0mWyKlWfUFiRUcjjxRaRN9nVAXqaKlOqwnbBAwcJS6HQd5iefxeiqCMseE/lE
        e0LOog3ScSjbIA6K5IUjFlAyfjHgyxAl1BaeTZLW41q3dWxPKtqafjR/iLjmRbZheDydIbXKHd9YL
        GuPpUP/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKOSS-004zkL-60; Tue, 24 Jan 2023 18:55:48 +0000
Date:   Tue, 24 Jan 2023 10:55:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 07/10] block: Switch to pinning pages.
Message-ID: <Y9AptAPBys9Nt3RV@infradead.org>
References: <Y9AOYXpU1cRAHfQz@infradead.org>
 <Y8/xApRVtqK7IlYT@infradead.org>
 <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-8-dhowells@redhat.com>
 <874829.1674571671@warthog.procyon.org.uk>
 <875433.1674572633@warthog.procyon.org.uk>
 <Y9AK+yW7mZ2SNMcj@infradead.org>
 <1291658.1674585437@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1291658.1674585437@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 24, 2023 at 06:37:17PM +0000, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > +	WARN_ON_ONCE(bio_flagged(bio, BIO_PAGE_REFFED));
> 
> It's still set by fs/direct-io.c.

But that should never end up in bio_release_page, only
bio_release_pages.

