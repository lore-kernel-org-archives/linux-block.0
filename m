Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75359C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhKWQ7W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhKWQ7W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:59:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F86C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TjLGOibeEoXhWdeXOSOSeW7ydv/vjvvrnmdVXnHgV0g=; b=xszgmiDDdFLJsLIohviBWDnBzi
        j+gjuvVLIL7EpvdTV7+cP+8RV5fRfdB1sRFzpdoGWb8SIvmpwDZb8D/v/jtgnsbFZe2g2b6K/5JTw
        apbg8CHX3gVT5gc5NGfIwLZ0kIRFdzOtB1x6+p+K11QuEy+RgnM3GWvW2xuHOFbASFxTBLpXoeM5M
        ePcQ4POK77JXoLifrc6rStJjW1zgdO3nIZti9/Ba4Q1tqv5CzZrx7he09SPat3II7Hsj++Qlt2Xwt
        EtCnxuew6v5+Ivq2Tbbso/Nty0uLat2GeddoDGGN5q8w+iD6R+R70MTHm4cNLFuGL1aK675VJMrbo
        1ThHpLQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpZ5a-0030C0-1z; Tue, 23 Nov 2021 16:56:14 +0000
Date:   Tue, 23 Nov 2021 08:56:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: move io_context creation into where it's
 needed
Message-ID: <YZ0dLq2pSZNUEMZR@infradead.org>
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-2-axboe@kernel.dk>
 <YZ0ZUJGilOzhF2k5@infradead.org>
 <56538fd1-ca28-386b-36ba-493399af1803@kernel.dk>
 <a2b73453-c38c-c951-58cf-b8b3ee3fefb7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b73453-c38c-c951-58cf-b8b3ee3fefb7@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 23, 2021 at 09:53:58AM -0700, Jens Axboe wrote:
> Actually may not be that trivial - if a thread is cloned with CLONE_IO,
> then it shares the io_context, and hence also the io priority. That will
> auto-propagate if one linked task changes it, and putting it in the
> task_struct would break that.
> 
> So I don't think we can do that - which is a shame, as it would be a
> nice cleanup.

Indeed.  We should still be able to move the call to
create_task_io_context into blk_mq_sched_assign_ioc
