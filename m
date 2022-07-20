Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843AAC43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 06:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiGTGSQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 02:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbiGTGSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 02:18:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622474E623
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 23:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dUiIiMcRNV0/EisTLoCzK1N0eHx3Feg8TOv1fCz87j4=; b=iJ8NpjoMP9ePJb4J7tdv2wKFqb
        Nvv66qSj9hGA3hbIe7CDfv3lGkXGz1mExkfiRCsLgL7D+fJzvp+KL81UvqF+WNSiyF79zyZfIMdPb
        DsqEdWwQtdQ9x8fqdIh5grqB0vDcUC7D2mYKa33VDcwpvB8njYjFu6NTOjITxV0psJZWLlNO+PBY8
        gUqT27qz3rIA4WzvAtOjyGXgfuiqHIvE1bAfIRkWdU7jISbHDqUxm1SphcgZPrSsO/BeSl4LduUse
        a/Ldc+JEYAgiD1P2vlDEIBUj6QE2I7j+LRikHsF6QdAASw4QzO6BdrKZZk0EI+GrOyDCCzSbANfhV
        NmnjyVmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE326-00176O-LJ; Wed, 20 Jul 2022 06:18:06 +0000
Date:   Tue, 19 Jul 2022 23:18:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
Message-ID: <YteeHq8TJBncRvZu@infradead.org>
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 10, 2022 at 12:41:33PM +0300, Sagi Grimberg wrote:
> 
> > Hello
> > 
> > I reproduced this issue on the linux-block/for-next, pls help check
> > it, feel free to let me know if you need info/test, thanks.
> 
> 
> These reports are making me tired... Should we just remove
> MEM_RECLAIM from all nvme/nvmet workqueues are be done with
> it?
> 
> The only downside is that nvme reset/error-recovery will
> also be susceptible for low-memory situation...

We can't just do that.  We need to sort out the dependency chains
properly.
