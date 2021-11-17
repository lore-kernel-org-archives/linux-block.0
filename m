Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAABC433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 10:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA53C61C4F
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 10:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhKQKzX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhKQKzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 05:55:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78302C061570;
        Wed, 17 Nov 2021 02:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fLNan28KuZ9EJvg2BjEwlDNpfZewvOrzk7TxFeqwN3I=; b=RYOtYI4+PyglrkUee4c3cxmAEp
        xOR50wQiHpByV+OSOfUDe6HulLOudiUWfLATZ3too5/bzjhQe4a+CFZ/V9XvANqGjym4IeJCpWCS2
        3fS1wMJQiQAQl+MJvK0hPyRNYOjBL8CZwNglGpAEG7REqxBnJOLx++5F/Za1SxcMulDyWUTcjFsgM
        TIO3atdO/inYd2mFK0W8yd1ogMWjhquWjGRgbluuqWGQSGuGX/5KfqD7r8pmIwpH4iMJKM6kMl9eA
        p22j7Cg1vtopJ+dEMIJsTtLlVGMEYH4EUryrdfsfB5js0BGBFtnsyEDNvPQDpmQWgM1b0F6jsZPfG
        GkXunNzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnIY9-004V01-4J; Wed, 17 Nov 2021 10:52:21 +0000
Date:   Wed, 17 Nov 2021 02:52:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] FAT: use blkdev_issue_flush() instead of
 congestion_wait()
Message-ID: <YZTe5Vl+ZiAHOK8y@infradead.org>
References: <163712349419.13692.2859038330142282757@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163712349419.13692.2859038330142282757@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 17, 2021 at 03:31:34PM +1100, NeilBrown wrote:
> 
> congestion_wait() in this context is just a sleep - block devices do not
> in general support congestion signalling any more.
> 
> The goal here is to wait for any recently written data to get to
> storage.  This can be achieved using blkdev_issue_flush().

This goes back to commit ae78bf9c4f5fde3c67e2829505f195d7347ce3e4
and looking at that this seems to be correct.  It might be worth to
reference that commit, though.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
