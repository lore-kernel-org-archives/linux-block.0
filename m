Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D24C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 08:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068CC60FC0
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 08:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJUId2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhJUId2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 04:33:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A4C06161C
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Y7otzKBQ6XpS0fI3q6aG1lOy3outvM/t1M7yWrQk/0=; b=NA7v0C77tbURXa5QLOf6s2hei+
        w10tRZzvoczOl8VDSOpsn9lbHTTLmZfwFinTYYFMaVRI96GekVAPjryoxI9Qtm3JnYRAQ0hdDW7sU
        eZbkxYCvzA3Z4+/A3+F3UbHQ7znFq5RZs8Ux+5mQz0rhWt2ch7v+smjOotFo12Um9HA+2TALgXfHJ
        UXqQeynPRfTx458vGofyzdJ5SQxKc2b1gHQLTBThy03S2sqXUJ+RfoX2XF3856ke2n4CgKTUd0GDL
        b+YPD4W8cZaadS6UQ2MnBWHc0lDPZE8frALLbAg0HqWG3YkKPd68gYtQW2pnK8B051ESV+KwURe6A
        I6KmWzvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdTTk-006qxm-9V; Thu, 21 Oct 2021 08:31:12 +0000
Date:   Thu, 21 Oct 2021 01:31:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] block: convert fops.c magic constants to SHIFT_SECTOR
Message-ID: <YXElUDBwpZgYY+ym@infradead.org>
References: <cover.1634755800.git.asml.silence@gmail.com>
 <068782b9f7e97569fb59a99529b23bb17ea4c5e2.1634755800.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068782b9f7e97569fb59a99529b23bb17ea4c5e2.1634755800.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 08:00:50PM +0100, Pavel Begunkov wrote:
> Don't use shifting by a magic number 9 but replace with a more
> descriptive SHIFT_SECTOR.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although I wonder if two new local variables in blkdev_fallocate
wouldn't be even better..
