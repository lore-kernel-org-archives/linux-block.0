Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CB1C3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 08:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjAQIDp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 03:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjAQIDR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 03:03:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68BD1CF79;
        Tue, 17 Jan 2023 00:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ImMonPOJVw/dYCSkrp3IZmiFG/n4u2EYylTpYZP7DbE=; b=05LtBhCxUnylrmWhFCOC7Rf8B9
        MLFVp4s06Xm9u+afLbNqlH368Dm3O1JpSZa4KRSlna323o4+TNq+JRxmgiFnExArVozJR3H+RAuNP
        UorLmzr2Z/iGK9selpSdQ+ecHwiZceUmR1k6bxQHeG3bDTA1LJP2+JbQv0hFe/01jfrWtR5iQTjcW
        6u3pFGjXxgt/QdLSZYXlzdmsl9cP4ueuT1UAVRB+rd+9/xFzEsmnpoEAfeg7VyvFLcga0rREJ2v7f
        NzDmAU62sYOzIvbL5vxPpDuT4tT3akE9J29oE4sJlKOmE91WoE5orE6x2jjjRpTSP4Twzg5oK5ZXA
        xhDF1bjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHgw2-00DGhp-1x; Tue, 17 Jan 2023 08:03:10 +0000
Date:   Tue, 17 Jan 2023 00:03:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/34] mm, block: Make BIO_PAGE_REFFED/PINNED the same
 as FOLL_GET/PIN numerically
Message-ID: <Y8ZWPiDqhGDgBT3l@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391055339.2311931.11902422289425837725.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391055339.2311931.11902422289425837725.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 16, 2023 at 11:09:13PM +0000, David Howells wrote:
> Make BIO_PAGE_REFFED the same as FOLL_GET and BIO_PAGE_PINNED the same as
> FOLL_PIN numerically so that the BIO_* flags can be passed directly to
> page_put_unpin().

Umm, no.  No matching entangling of flags, please.
