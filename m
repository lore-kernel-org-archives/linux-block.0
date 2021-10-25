Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EBAC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA8060FBF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJYHhj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJYHhj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 03:37:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A5AC061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SENqFjwACjDkB8OfHQ0kO5RJ0V4JvG/xwE/5AZKxwCg=; b=NjQArtXyh5erQZwBe7bQMR4B15
        wqlQjgBY2SWGF51OcXHnsVQ8NULEZ5FPyVtuX9VUL4H956O2veAlBJm1/r/Hx03DXM6Oi5+kTV/w0
        QIhXdBvr9cVVyEeCYBer2W+QhYWO8urnQza/+p3mNWUy084bTpjBqjqoJcyA7lkLJRn2MJMD1VWkd
        DYhuso+zqW8XDjDeOFiNzVSpstPmzTNWUugQxkxNUjjCttMnNY0jPOqPWUsJ98Q5iDe9TIYixrKVb
        jxb4mYHI4dBJa6QmoljCwhdbCfetJaxtcjdnR8mWwi7bYZ6ErzIatqDRctbLQNscj/bU+C8JQEWRb
        04o17s2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meuVp-00Fe9P-Bl; Mon, 25 Oct 2021 07:35:17 +0000
Date:   Mon, 25 Oct 2021 00:35:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/5] block: kill unused polling bits in
 __blkdev_direct_IO()
Message-ID: <YXZeNUVx3cJW/lV+@infradead.org>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <2e63549f6bce3442c27997fae83082f1c9f4e6c3.1635006010.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e63549f6bce3442c27997fae83082f1c9f4e6c3.1635006010.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 23, 2021 at 05:21:35PM +0100, Pavel Begunkov wrote:
> With addition of __blkdev_direct_IO_async(), __blkdev_direct_IO() now
> serves only multio-bio I/O, which we don't poll. Now we can remove
> anything related to I/O polling from it.

Looks good, but please also remove the entire non-multi bio support
while you're at it.
