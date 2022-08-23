Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A327C32774
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 18:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiHWSHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiHWSGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Aug 2022 14:06:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD02F007;
        Tue, 23 Aug 2022 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=fQDJPjjtyl8qLfALnz+kAzm6ni
        KVGKJ/KvcWolHDhPovWIMGnDcRmIuUOLLAvkVGtdChO80lLFIUiZN24PtND5pPt1sIvWVHQR6abz2
        PVKtHILlGh93BTUvlQeWspY+VcqJG+ZwBB8Gprgt+DTJEmfLfw85c2X5pNp6YNJZK6zmOnA9HpHhH
        9YFIAa+oRGjGliIJC8sbxGeNlj9FcxOy/stSDWG4KnD5yMU+39PRo39The1czS9URah+SvjZan6g6
        ivLkdJFXfeO50f8UbElP68DJuHoj7Oz6Tx/zl2OS/DioCGJo44yZggCT7EqjstRqX0Yrj2pyrut6N
        fpWxCs5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQWYk-007ELy-Ke; Tue, 23 Aug 2022 16:15:22 +0000
Date:   Tue, 23 Aug 2022 09:15:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] loop: Check for overflow while configuring loop
Message-ID: <YwT9Gu09/D3ITo5y@infradead.org>
References: <20220823160810.181275-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823160810.181275-1-code@siddh.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
