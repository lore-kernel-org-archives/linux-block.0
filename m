Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B44C54E94
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 16:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjAXQI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 11:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAXQI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 11:08:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F871ABFC;
        Tue, 24 Jan 2023 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K4NU9wcupdtWQP0YOY7P46L6ZB9Eexqvu5/l/MLMqxg=; b=ST/y7Kvs8CckR9yjtuonVagOEV
        vKqSmbz6dUCSGolaW0Kl+h3cqiEdAMPYAN7qhYcsF1LR69u50i2+RGfQ9yFUyDL34+APbndFQbBoJ
        ggQS1cqotwUmKv1dn5tMYU+AfZJJcZoj2vaCyLBXgKP5nAKkExcpJA/I1Lhjmfc/uRXCaj47/g2j7
        W4T41XA86Mo/ezSG/k3i8NmyXcHQeYraNaFbErQAMS8nL97eZg/L91/+P7Q+hf+rYQpYcqH1vNy3/
        Ey17rHjxppphfuQ1ev1uo+pRQN/xOlW22t09V6RiqDQ4U3QQ4PvQd/DTvV6NYPF2UxbI6Yx79U5Br
        UQlRxTdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKLqO-005B0l-Iz; Tue, 24 Jan 2023 16:08:20 +0000
Date:   Tue, 24 Jan 2023 16:08:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: What would happen if the block device driver/firmware found some
 block of a bio is corrupted?
Message-ID: <Y9ACdOeBRHOxe5TA@casper.infradead.org>
References: <5be2cd86-e535-a4ae-b989-887bf9c2c36d@gmx.com>
 <Y89iSQJEpMFBSd2G@kbusch-mbp.dhcp.thefacebook.com>
 <08def3ca-ccbd-88c7-acda-f155c1359c3b@gmx.com>
 <Y897ZrBFdfLcHFma@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y897ZrBFdfLcHFma@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 23, 2023 at 10:32:06PM -0800, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 01:38:41PM +0800, Qu Wenruo wrote:
> > The retry for file read is indeed triggered inside VFS, not fs/block/dm
> > layer itself.
> 
> Well, it's really MM code.  If ->readahead fails, we eventually fall
> back to a single-page ->radpage.  That might still be more than one
> sector in some cases, but at least nicely narrows down the range.

I had code to split a large folio into single-page folios at one point,
but I don't believe that ever got merged.  At least, I can't find any
trace of it in filemap.c or iomap/buffered_io.c.  So I think we just
retry the ->read_folio() call each time.
