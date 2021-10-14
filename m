Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DC5C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 04:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055A460F9E
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 04:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhJNE4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 00:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhJNE4e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 00:56:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5094FC061570;
        Wed, 13 Oct 2021 21:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t2BdXrWywNYOUH0CxxelxpJTB7lMZFSXr5ZhE4N9XIw=; b=IcTIFqr0V0C17XUv9yrfBZgJ0I
        7csUj3uaNlxEezJr867OOoO/ueCzy8Rk3evV3LLB5Tynw36UUIWSbs0yBc5Ld55Vl/4wrdNLq416E
        5L3I8amuZsT1qiXh3Zy6StZKigjiU8h0A1zGo+bVucsFAnEsAPI22QtkUqBEv2WPOTT9zeNXmhuFw
        1pvCwFyWUi7aBR+IPIlQdBa3PJDuKoEIVl4em5a9Yhlg+U1Ih9ZzuJbnLjA4ycNWIaDMrBnQIrXXE
        L+O950fMzxeb43q+YyFBnTF5KrEY0iHb4TuDY54qtW4bafHtjWDMQqmp9CJfGhnxdY8l70vm5ow2T
        DNVWPIHg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1masi1-0082VA-Lr; Thu, 14 Oct 2021 04:51:53 +0000
Date:   Thu, 14 Oct 2021 05:51:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] block: don't hide inode from block_device users
Message-ID: <YWe3QZD+g8MSoCtT@infradead.org>
References: <cover.1634115360.git.asml.silence@gmail.com>
 <2b8c84834a304871d78f91d4ebe153fac2192fd5.1634115360.git.asml.silence@gmail.com>
 <YWb6VgEjEZFexiV0@infradead.org>
 <194577df-0402-6e3c-3534-af289b5494e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194577df-0402-6e3c-3534-af289b5494e0@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 07:44:20PM +0100, Pavel Begunkov wrote:
> Mildly hot in io_uring w/o fixed files, but that's not peak perf,
> but would also be great to get rid of bdev->bd_inode dereference,
> e.g. lots of in fops.c.
> 
> Are you going to just hid the dereference in helpers or kill it
> with some offseting magic?

The only real hot path uses I found is the size (which you and Jens
already seem to have moved to use something out of the inode for the
fast path),  and maybe the blkbits for which we could do the same.

So basically the idea is to not touch the inode in the hot path,
and use accessors helpers in bdev.c that could do the offsetof trick.
