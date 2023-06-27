Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7873EB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 04:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjF0Ew2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 00:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjF0Ew1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 00:52:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715EEB
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 21:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6O5aZH84/m5xVkH95XFrUU1joKsS1fopIiKxGrqYe70=; b=Kmo0XYWSOr4spvVxLTITC9b5E+
        Ny+szPGKgjGdGkqlI+CJpTXpO5rN1oCZFzz2vggrF3lhw/D/rlj+WZwYTATNH6FNZpukuOeKFb5AC
        0Vv4vt9XXNTS3uDya8TzNOhjRxJnw768kczKAw6U7kb+bOg8duBAK52xw2wKb97zQVZ2kxEh2zq6p
        WaAeUqqE0pEYf7UN2tG86EikBMBL0uacljVgluhkj2YcAeSaZwjl6v04p7OGAuOQAq4FBm5dnXQDd
        5Ktbmm+iVTXr3FFnGtXYRlyvC9AE+6+8pe/YvwPxDwBLQpBApp8g4V21TXCP6v2STbbrkj7iDcKzB
        WproB2sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE0gi-00Bm6i-1F;
        Tue, 27 Jun 2023 04:52:24 +0000
Date:   Mon, 26 Jun 2023 21:52:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Marc Smith <msmith626@gmail.com>
Subject: Re: [PATCH] block: flush the disk cache on BLKFLSBUF
Message-ID: <ZJprCPEYfqIpqClP@infradead.org>
References: <1a33ace-57f9-9ef9-b967-d6617ca33089@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a33ace-57f9-9ef9-b967-d6617ca33089@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 26, 2023 at 10:25:28PM +0200, Mikulas Patocka wrote:
> The BLKFLSBUF ioctl doesn't send the flush bio to the block device, thus
> flushed data may be lurking in the disk cache and they may not be really
> flushed to the stable storage.
> 
> This patch adds the call to blkdev_issue_flush to blkdev_flushbuf.

Umm, why?  This is an ioctl no one should be using, and we certainly
should not add new functionality to it.  Can you explain what you're
trying to do here?

