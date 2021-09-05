Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DD5C433EF
	for <linux-block@archiver.kernel.org>; Sun,  5 Sep 2021 18:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955F560232
	for <linux-block@archiver.kernel.org>; Sun,  5 Sep 2021 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhIESMp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Sep 2021 14:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhIESMo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Sep 2021 14:12:44 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217C4C061575
        for <linux-block@vger.kernel.org>; Sun,  5 Sep 2021 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p8aku6deYsnC1Rl2Pv2bYisBKiEg/qHT0F2g7t0ztIE=; b=IxALWL/lWGme5SHk7Br8S8fEQF
        AAJgnKQuiIZhHMzwTU7RNAVfnGocinY5yyJQaFLRGCrr2EY1Ey271csVrD3qHhFeGUH6a9zD6Md4a
        Gi61tUrz5o53q2ITXpN8/y1cmCq4i57rLkWMcrwoq76RHuOODfHyy9E4BQid2d3HotdaRUscghj/5
        NfjFxSDPG1FR/Zcxh67xgKp7RE58tt342EsOFlGOSsa3MdBWcK1y4oGbgC84A12corar/w4cM2k8N
        F5l5C/0jtQBJVR6syoXyyKUaGDZ7mTKTUhCZEKPYVqFfgqQkakuaAx4Lxh7LQ6rIortianwei3QlA
        oSp/SwuA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMwcB-00GDQ7-VP; Sun, 05 Sep 2021 18:11:35 +0000
Date:   Sun, 5 Sep 2021 11:11:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: make __register_blkdev() return an error
Message-ID: <YTUIV0mSJHfgtMov@bombadil.infradead.org>
References: <20210904013932.3182778-1-mcgrof@kernel.org>
 <20210904013932.3182778-2-mcgrof@kernel.org>
 <9b9e8bfd-a2a6-4b78-413b-7c6c7eb83e05@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b9e8bfd-a2a6-4b78-413b-7c6c7eb83e05@I-love.SAKURA.ne.jp>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 04, 2021 at 11:49:06AM +0900, Tetsuo Handa wrote:
> On 2021/09/04 10:39, Luis Chamberlain wrote:
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 45df6cbccf12..81a4738910a8 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -1144,10 +1144,13 @@ struct block_device *blkdev_get_no_open(dev_t dev)
> >  {
> >  	struct block_device *bdev;
> >  	struct inode *inode;
> > +	int ret;
> >  
> >  	inode = ilookup(blockdev_superblock, dev);
> >  	if (!inode) {
> > -		blk_request_module(dev);
> > +		ret = blk_request_module(dev);
> > +		if (ret)
> > +			return NULL;
> 
> Since e.g. loop_add() from loop_probe() returns -EEXIST when /dev/loop$num already
> exists (e.g. raced with ioctl(LOOP_CTL_ADD)), isn't unconditionally failing an over-failing?

It's not clear to me how. What do we loose by capturing the failure on
blk_request_module()?

  Luis
