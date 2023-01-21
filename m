Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B29C38141
	for <linux-block@archiver.kernel.org>; Sat, 21 Jan 2023 13:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjAUNBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Jan 2023 08:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUNBa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Jan 2023 08:01:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEC623132;
        Sat, 21 Jan 2023 05:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YlB0kyjevk0alEzZ7VHdw8fRbblsbas/G7ZnWLhfR0I=; b=vbo3G0CbyJKakxu3dY8cMdcaYu
        2wqlYcaRc5vQnwt+WljyEznrzEtm+WA8fUrgqXcA3AiuWlnjj82mgXvIoRfEbX0FCydnBAFiN+BBf
        MVtVm3YVRYrrkr5X+E2q5G941cqCYtiIxFxRNWLttfaKbJB1oxTBXwAipzcVl4hUXK77ECp4R2vKI
        xxgDFUrrr+XKzWXazL/5jhBoqUBJAvCQ9QBSeKLmyeIWVjUUHNXaQRk4C3NL7X0rmzRpqmrd0BMrA
        ffD5uBT6vNGOtAKrkQA9EmCGAT6F0OxxtEJUdX6yultP/+dwX9doPqr62L/16Dk/lvTFz+Z3iZL/X
        oQiYVZ1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJDUg-00Ds6m-16; Sat, 21 Jan 2023 13:01:14 +0000
Date:   Sat, 21 Jan 2023 05:01:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/8] iov_iter: Define flags to qualify page extraction.
Message-ID: <Y8viGuz5//4AP7tZ@infradead.org>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120175556.3556978-2-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 20, 2023 at 05:55:49PM +0000, David Howells wrote:
> For now only a flag to allow peer-to-peer DMA is allowed; but in future,
> additional flags will be provided to indicate the I/O direction.

Al still doesn't seem to be sold on the latter part, so maybe just
drop this sentence for now.
