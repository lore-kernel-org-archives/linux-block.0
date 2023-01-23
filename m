Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEB4C05027
	for <linux-block@archiver.kernel.org>; Mon, 23 Jan 2023 18:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjAWSYE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjAWSXk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 13:23:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469A35BB2;
        Mon, 23 Jan 2023 10:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ncgYVPzNs3m5z29lFwiY4m84Kxk068u/nABuO+nxW4U=; b=EcTP2w8WPdjpquz1yiSm6nhXxi
        uSY9cWcJzzSLnsaj89dP0bij6Dk76PozBcmI798wQlurk6yGBxnbVTV1pcSvenXpd51ofOlbpHbub
        qRwjd6QyyOsZbPknrqZSRN9NUmsTrcjY3v8bDJYOEcg0LV3OhWRhV1nP4Q02oDZTQuVKv5eIT7UKK
        neS+O/AYnYwgzlxPOQV+qn2QLxz/yI29imQsPptQF0lif0/kmLDJxtQRaJ2aLw0k43miEj+OzhbPc
        ZWh2gf8aGvA7baMnDGvffihNew73I06fEa0tw0ePZ8+hkF5lpDMDDf3mR2CZfYp9jAZlJ2011HXtp
        XLmgH5Ng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK1Ti-0010Jg-A5; Mon, 23 Jan 2023 18:23:34 +0000
Date:   Mon, 23 Jan 2023 10:23:34 -0800
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
Subject: Re: [PATCH v8 07/10] block: Switch to pinning pages.
Message-ID: <Y87Qpn2N2uaOb6VA@infradead.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-8-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123173007.325544-8-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 23, 2023 at 05:30:04PM +0000, David Howells wrote:
> Add BIO_PAGE_PINNED to indicate that the pages in a bio are pinned
> (FOLL_PIN) and that the pin will need removing.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
