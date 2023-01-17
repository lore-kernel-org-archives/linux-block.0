Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305ACC6379F
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 08:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjAQIHt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 03:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbjAQIHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 03:07:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AA09EE7;
        Tue, 17 Jan 2023 00:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DYOxo4AwptpdxIatE54xv61B77
        xR5GOMI0cEq5AtqK37i/ddlx5shAYu386z/7uvgzxKxuadQDvai/Iv5sx1TlG1yOD4jy1Yut6KJc2
        3Dg70P15yEs3yJReSMl8wHy4GfDVGYziqAnxZeqHh6+Rj0K4ICx4Jiwiwse0QL9I0zQ249icBQCrR
        Ep9E/F2KJx/cPugQQZg9i6+sJAu2oYKd24eT0AaRFCj3e0UuHkW3RcjscyKxi91UzdLXyfEhz5IRr
        sWGQAoBtpYRUe6qQH0hm3XyJMhrecujqYx5oMlzMqnPyzrRMe5BD2+qS08LU5ixlSH/s/KbWjX1Sb
        7v4/XqTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHh0R-00DHDb-Ci; Tue, 17 Jan 2023 08:07:43 +0000
Date:   Tue, 17 Jan 2023 00:07:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/34] bio: Fix bio_flagged() so that gcc can better
 optimise it
Message-ID: <Y8ZXT5UaLClDLsUr@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391056756.2311931.356007731815807265.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391056756.2311931.356007731815807265.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

