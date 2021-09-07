Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE90C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 135EE610FE
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbhIGO7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344370AbhIGO7F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:59:05 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7795C061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fuif7JbnNK1Im4ayFWY+qGIYKCVtfN/pxj7HbrXwbNs=; b=K5fRr1kmoGgy9dnmd411O5nlqB
        /+m8L8sBgdZ3RHsLzC9iw8ifZvB0OZeSXaHcA8I1EMG5mCv0ZjrSvym28VqoBTlNX+48KCDtkPoh8
        BmlBEm6yGJoplGCep+JgfhvnoSGIqQK8RbKbk3mxmkULkA97Sqo1gVamRfj3nZW692PJb1Ig5iIGw
        MsL3tdZlZi3oHBryJe3iHVPUcQ+Von3aT4woPYeKn4DISJFPUK4X+8yKcnnIyA16i2OODsDDsRwEO
        15snQtkBl1ScHAm5x/xzdIeSSWJZcU8ilA3VbEp9/QVfRqvGwEOqjIX/S7UIpP5Aw8eapR2YH0RU5
        sBI4fOjA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNcXq-003wlV-Li; Tue, 07 Sep 2021 14:57:54 +0000
Date:   Tue, 7 Sep 2021 07:57:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: make __register_blkdev() return an error
Message-ID: <YTd98oss0WgCwVzY@bombadil.infradead.org>
References: <20210904013932.3182778-1-mcgrof@kernel.org>
 <20210904013932.3182778-2-mcgrof@kernel.org>
 <9b9e8bfd-a2a6-4b78-413b-7c6c7eb83e05@I-love.SAKURA.ne.jp>
 <YTUIV0mSJHfgtMov@bombadil.infradead.org>
 <d5c7f0e6-8ded-581c-cb10-00e785a7f7b3@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5c7f0e6-8ded-581c-cb10-00e785a7f7b3@i-love.sakura.ne.jp>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 06, 2021 at 02:59:38PM +0900, Tetsuo Handa wrote:
> On 2021/09/06 3:11, Luis Chamberlain wrote:
> > On Sat, Sep 04, 2021 at 11:49:06AM +0900, Tetsuo Handa wrote:
> >> On 2021/09/04 10:39, Luis Chamberlain wrote:
> >>> diff --git a/fs/block_dev.c b/fs/block_dev.c
> >>> index 45df6cbccf12..81a4738910a8 100644
> >>> --- a/fs/block_dev.c
> >>> +++ b/fs/block_dev.c
> >>> @@ -1144,10 +1144,13 @@ struct block_device *blkdev_get_no_open(dev_t dev)
> >>>  {
> >>>  	struct block_device *bdev;
> >>>  	struct inode *inode;
> >>> +	int ret;
> >>>  
> >>>  	inode = ilookup(blockdev_superblock, dev);
> >>>  	if (!inode) {
> >>> -		blk_request_module(dev);
> >>> +		ret = blk_request_module(dev);
> >>> +		if (ret)
> >>> +			return NULL;
> >>
> >> Since e.g. loop_add() from loop_probe() returns -EEXIST when /dev/loop$num already
> >> exists (e.g. raced with ioctl(LOOP_CTL_ADD)), isn't unconditionally failing an over-failing?
> > 
> > It's not clear to me how. What do we loose by capturing the failure on
> > blk_request_module()?
> > 
> 
> We loose ability to handle concurrent request.
> If blk_request_module() does not ignore -EEXIST error, only the first
> open() request would succeed because loop_add() returns 0 and all
> other concurrent requests would fail because loop_add() returns
> -EEXIST.

Yes I see that now thanks!

> Actually, blk_request_module() failures should be ignored, for
> subsequent ilookup() will fail if blk_request_module() failed to
> create the requested block device.

Then how about this:

Since we would like to use __must_check for add_disk() we proceed with
the change to capture the errors and propagate them and we just document on
fs/block_dev.c's use of blk_request_module() about the above issue and
how we prefer the errror that ilookup() would return.

  Luis
