Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89493C43214
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 19:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6726D613D0
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 19:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhHWTpy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhHWTpx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 15:45:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B3C061575
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DK5jppBszQEmNCvJUFA6RInsT6PiDuCoZnMDXnYRr+A=; b=sxTwr/SLfoP8I0vbBHTu1LxHRC
        Rnqxuo9sZskE6wydaD3y339LUSZCvLfevm2v6omXPr1IbMgPgPj3mIB6VhxB1uud/LApULK4PAlQX
        9Wq8KALy7cxF5WRHXSHhhpU2RqdSiIlBxUV/LBVOagICbUUl9aWDu1HCx1tili6+InhMSgHRdXX4r
        79EO55V7TXeoYWLxF5wo19sjkrjfHA5Q3FRsYWAeUaaw6Y2K1+e7A96QMktwJLgnwp97JprZcsqND
        wMZ8vW6J5iN4/p1EHdWO1acXDZGXSeTVl1sbG3BQ3q6ACAYJbsRHj6uUtbhwnFjuwABcc+Wzz+fcf
        BUN8qpeA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIFsP-000TYW-Ra; Mon, 23 Aug 2021 19:44:57 +0000
Date:   Mon, 23 Aug 2021 12:44:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
Subject: Re: add error handling to add_disk / device_add_disk
Message-ID: <YSP6uZOYQ6kX+B+3@bombadil.infradead.org>
References: <20210818144542.19305-1-hch@lst.de>
 <21685c1f-5fde-cb85-3bd7-4396c6042e11@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21685c1f-5fde-cb85-3bd7-4396c6042e11@kernel.dk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 23, 2021 at 12:57:41PM -0600, Jens Axboe wrote:
> On 8/18/21 8:45 AM, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series does some refactoring and then adds support to return errors
> > from add_disk (rebasing a patch from Luis).  I think that alone is a huge
> > improvement as it leaves a disk for which add_disk failed in a defined
> > status, but the real improvement will be actually handling the errors in
> > the drivers.  This series contains two trivial conversions.  Luis has
> > a tree with conversions for all drivers in the tree, which will be fed
> > incrementally once this goes in.  Hopefully we can convert all the
> > commonly used drivers in this merge window.
> 
> Applied, thanks.

Do you have a branch published which has this by any chance? I checked
but can't see anything obvious.

  Luis
