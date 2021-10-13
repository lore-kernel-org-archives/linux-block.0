Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52417C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC1060FDA
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhJMP3T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhJMP3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:29:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBB3C061570;
        Wed, 13 Oct 2021 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7E+hPiQQERHmVxALs9OGq5/I4NAGwHktosOAiz3bsWE=; b=frB1GlKz/JIvrtbxv67JeTgiBL
        UD236qPs1B5cHQRdecow1PHYsMxV6I90Qt812LFmJanJrpvO5yCimfGJjJAEJfbLQE8PuZYfZsFKV
        H15IQdMcV4ClFdGH9i5SPm0L+6Czy5lYbQL30p2zJF+oSq5N5/BAejVtDsVvPHhPhbLtCMiqtpOG1
        D6qBRib2jCAwvT1ZGqOt6s5rRfodxoZYqQMVfY/BBkRY31tClXO/5qL3GH5G6ouhIcoAES8m/AzGz
        8+NM3yggeygJvL8ztepF1XEuqmbXh+4xpzM9dJPcDzs9C0GNaHGCxo7D9HBSIpqU9gwqOKOLIo4LO
        JRSJXMqw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mag7y-007YNf-Df; Wed, 13 Oct 2021 15:25:24 +0000
Date:   Wed, 13 Oct 2021 16:25:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/3] block: don't hide inode from block_device users
Message-ID: <YWb6VgEjEZFexiV0@infradead.org>
References: <cover.1634115360.git.asml.silence@gmail.com>
 <2b8c84834a304871d78f91d4ebe153fac2192fd5.1634115360.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b8c84834a304871d78f91d4ebe153fac2192fd5.1634115360.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 09:57:12AM +0100, Pavel Begunkov wrote:
> Instead of tricks with struct bdev_inode, just openly place the inode
> inside struct block_device. First, it allows us to inline I_BDEV, which
> is simple but non-inline nature of it impacts performance. Also, make it
> possible to get rid of ->bd_inode pointer and hooping with extra
> indirection, the amount of which became a noticeable problem for the
> block layer.

What fast path outside of bdev.c cares about an inlined I_BDEV?
I have dusted off patches to reduce (and hopefully eventually kill)
accesses to bd_inode outside of bdev.c, so this goes into the wrong
direction.

If needed I'd rather figure out a way to fix any smoking gun without
this change.
