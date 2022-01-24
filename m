Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52907C433EF
	for <linux-block@archiver.kernel.org>; Mon, 24 Jan 2022 14:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbiAXOFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiAXOFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 09:05:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B484C06173B
        for <linux-block@vger.kernel.org>; Mon, 24 Jan 2022 06:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/pv1I0v1UN8XOkK6hagkrXnYtjhur5ED1XEoPzxjvFo=; b=HNwFDN3LM0+TQB5/xh6XB+RxZf
        Uv8bElwaPSVLRZ1fZphO5QgS75xXDbO15VTUISIBNvgAeNmKn//79EE9XcoZL0DUGK0yiikFDNPMF
        2vXiKfGdVB90QzNy99TCf+b+Xb0anDDBm6QpVYUs583KobK0aSVr4vHi5jlS8TP14qm0yd3zwT9qT
        oGRFCjPbzUFKQC97CRkMNBAaAhgzoXls0oIK0NvcqUjXhsFavqOSB1E4gHkvU5ax2GhVzhUj3BJo4
        LN6c+sgHjVnRwFH/cnA/CH6jfKiel/ri2B5R5l4ouTT8fFRd2JjARwtPAiCtUQtJ4p+4+/m6HaD0z
        HsA3OtlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBzxz-003ZXY-Gv; Mon, 24 Jan 2022 14:05:07 +0000
Date:   Mon, 24 Jan 2022 06:05:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>, Pei Zhang <pezhang@redhat.com>
Subject: Re: [PATCH] block: loop: set discard_granularity as PAGE_SIZE if
 sb->s_blocksize is 0
Message-ID: <Ye6yE2Ephyv+WBYY@infradead.org>
References: <20220124100628.1327718-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124100628.1327718-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 24, 2022 at 06:06:28PM +0800, Ming Lei wrote:
> If backing file's filesystem has implemented ->fallocate(), we think the
> loop device can support discard, then pass sb->s_blocksize as
> discard_granularity. However, some underlying FS, such as overlayfs,
> doesn't set sb->s_blocksize, and causes discard_granularity to be set as
> zero, then the warning in __blkdev_issue_discard() is triggered.
> 
> Fix the issue by setting discard_granularity as PAGE_SIZE in this case
> since PAGE_SIZE is the most common data unit for FS.

sb->s_blocksize really does not mean anything.  kstat.blksize might
be a better choice, even if it someimes errs on the too large side.
