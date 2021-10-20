Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1290C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD206117A
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJTGdN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJTGdM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:33:12 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AF5C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sQmcNbPaSEtlczGtiJ1JrcOEr6pM57w4mMSkrGdJlt8=; b=cKi98iAgHplF/JvKaYwitjH/En
        MFn0jyFDVHQ3Xx2vlSs6qKhwrqtULalxdcgprzBDPVaDwYG9WINvLEqwCZb3oh2HxkUt3qz12jsSj
        KAZ5VN3UiZp8j5LW4mzChf2UQCswFxdclzf7u4ikALQwS+quQ4Lb17oRkoyhogEf+13kNa0PeIR9a
        5L5LkmeC4QeYnzjin6Vw3u/roNppT9UVy3Dh0lgCBuCH5Vrn9qLo6yfiu18tvnqBsZXGnH7T2gsRF
        nYXmY1tfqwOMcMb0LJkGfH5Iu1EdT/bItqb95lQ3L2ZePxTQQ4Ls/i+/3tJ9LdLkpJ9k4xlEGKmSj
        LuY6hbiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md57q-003Tqv-Ry; Wed, 20 Oct 2021 06:30:58 +0000
Date:   Tue, 19 Oct 2021 23:30:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 10/16] block: optimise blkdev_bio_end_io()
Message-ID: <YW+3onhtNw8BzZFN@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <8e6003932f65ecd9ada5d6296c6eb9d1b946a1eb.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e6003932f65ecd9ada5d6296c6eb9d1b946a1eb.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:19PM +0100, Pavel Begunkov wrote:
> Save dio->flags in a variable, so it doesn't reload it a bunch of times.
> Also use cached in a var iocb for the same reason.

Same question again, does this really make a difference?  We really
shouldn't have to try to work around the compiler like this (even if
this relatively harmless in the end).
