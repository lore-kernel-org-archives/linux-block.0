Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF406C433EF
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 05:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiEXFQG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 01:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiEXFQF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 01:16:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287D431D
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 22:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xspr9q8wrCQ7j9SHJRfFWrr/gJIyMTnBbmdu+lbI3DE=; b=npe8XcGtbFzrIey6KxjzcJM/lN
        2KAayELHKWfk/kP5dk7mlufKZauN2T9sXvYPJVqW03nsWK53Pae+CC7GbyoPGyd7iZID629SJn0V3
        iTNvEzDwVtRD3xPIoy9A4FG2Ac0xeVGoz/yuetq+NmBACg1jgDLQB1E7op2H74jPshfEnY92L78lo
        KBWdiXcP0ijER4u6Z6ItKvPsV8u6AYWHzl0xqUJ2fAxbd2EGBlt3mBa103BHJ+dNPEdYC3MT1k2dX
        wjLA9WDG8xJlje54DFm/0vFmdY52Wet7sTTivbSwXV4+7s7JDYmoxt6FnaRu8m1w2fhmq7WnjAUfg
        B0beg3Fw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntMti-006q39-Aj; Tue, 24 May 2022 05:15:58 +0000
Date:   Mon, 23 May 2022 22:15:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [GIT PULL] io_uring passthrough support
Message-ID: <YoxqDtk71JuyydDv@infradead.org>
References: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
 <CAHk-=whfi3FE3O7KrziqPbyGvAmNFas3xxLz2O+ttzBkCOQmfw@mail.gmail.com>
 <caa5e85c-2bfe-b9e3-1e32-c11f78e6ad29@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa5e85c-2bfe-b9e3-1e32-c11f78e6ad29@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 23, 2022 at 02:19:38PM -0600, Jens Axboe wrote:
> We can obviously dump this as it isn't integral to anything, and
> honestly now that the NVMe is wired up, there's no great need to have a
> separate test for it. But it doesn't really hurt and there are already
> regression tests for it.

Yes, please dump it.  It is not actually useful and is just more
code around for no good reason.
