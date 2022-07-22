Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E86C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 04:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiGVEqM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 00:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVEqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 00:46:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2344D27B31
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 21:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jInxvd5KGPTK0UzbTxqy4niIXX1piXEaGtA5dJxSNDY=; b=SUwzhrpxE+3FkiKDYRagEblSY0
        ey6RT5fDkZeYhnufxJRurW+DHSLn7+FEgY2DmyXhz4ji68u4CXbP3ysrHpe0g2tvdB2KgmmFnUGAs
        i6zV3+Wwk5BXafFxJ0eC8lPubNepUn9kb2b/BGjsIZekjXy/G/bRxtSmciMxzAOkmFVzHQS7RVvTE
        3SBtEAayJJnVYBwZ/pd1YPqZ3h7mUTV/Aqjpz5GoRI+JWhT1rb5t6+rOxc+uVgQnfbEINViewzYKC
        89SPFlibQCd0Bbmst7ruRkTCwp9tX8oAz6L9vAPeY/uqnrOkoARphDoNcnn7dlqetZo3F8TtyXEVI
        ijxadizQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEkY4-00HXj2-QS; Fri, 22 Jul 2022 04:46:00 +0000
Date:   Thu, 21 Jul 2022 21:46:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
Message-ID: <YtoriAQGW8+p4pFe@infradead.org>
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
 <YteeHq8TJBncRvZu@infradead.org>
 <bd233bf9-d554-89cc-4498-c15a45fe860b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd233bf9-d554-89cc-4498-c15a45fe860b@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 22, 2022 at 01:13:26AM +0300, Sagi Grimberg wrote:
> The problem is that nvme_wq is MEM_RECLAIM, and nvme_tcp_wq is
> for the socket threads, that does not need to be MEM_RECLAIM workqueue.

Why don't we need MEM_RECLAIM for the socket threads?

> But reset/error-recovery that take place on nvme_wq, stop nvme-tcp
> queues, and that must involve flushing queue->io_work in order to
> fence concurrent execution.
> 
> So what is the solution? make nvme_tcp_wq MEM_RECLAIM?

I think so.
