Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29477C54EAA
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 19:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjAXTDG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjAXTDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 14:03:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332334A1D3;
        Tue, 24 Jan 2023 11:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LgOhR7nM2RGyvF06GHYu3TKpp2IzRogUqRE/RoflDZA=; b=5AbZWSTIYIFIlmjS4gabiKqVUp
        H0tWTmymnDtyCWseMbo4HnBsnGKOaXgEhPkcOWBCURthoedGdYKeb/eWdXVphdETkXIzSfRizVtPV
        qAbHSY/6eN8Yz25hhxyODf8WKKV/5I2M02Jx1VrChd/32FBBh8Gu4FOnz2+uyplH5KXp71rsEEswo
        Rbb+bAHNra5HaVYmBQmOjjgcJyZu7b0+EjUs5SO51pV2UeXB6ZVGRbw+oGgPb2ani4OFK+UDaN0u+
        rrd9HxpPLE3olxLj1ZDLuNY7nzoW819a/ETWOjlhnHUFI0gMKq2bu7c5JyhVQhpaj3lqt6lLXZaCm
        XjRGbFbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKOZN-0050HN-HT; Tue, 24 Jan 2023 19:02:57 +0000
Date:   Tue, 24 Jan 2023 11:02:57 -0800
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
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 6/8] block: Switch to pinning pages.
Message-ID: <Y9ArYfXEix7t3gVI@infradead.org>
References: <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124170108.1070389-7-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 24, 2023 at 05:01:06PM +0000, David Howells wrote:
> Add BIO_PAGE_PINNED to indicate that the pages in a bio are pinned
> (FOLL_PIN) and that the pin will need removing.

The subject is odd when this doesn't actually switch anything,
but just adds the infrastructure to unpin pages.

> +/*
> + * Set the cleanup mode for a bio from an iterator and the extraction flags.
> + */
> +static inline void bio_set_cleanup_mode(struct bio *bio, struct iov_iter *iter)
> +{
> +	if (iov_iter_extract_will_pin(iter))
> +		bio_set_flag(bio, BIO_PAGE_PINNED);
> +}

At this point I'd be tempted to just open code these two lines
instead of adding a helper, but I can live with the helper if you
prefer it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
