Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987B9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7816C610CF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 17:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhJURtc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhJURt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 13:49:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF08C061225;
        Thu, 21 Oct 2021 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ar6Nln+iCTz4ULZ5bzZwdi/BNywgNiInR3KbeYJPJFk=; b=AEimvyF3sRUECrII1PM+N3udi6
        28GlMX49irZ0MwupJsdmWUAxWVRy4DDOl8pwbTMvpmEi/hh/dz3dlkCTJwH8dJRvOx981O7pIREJc
        MmWq8Hwe+cpNZg9q/zM8Y4dpt3iGgqJ5237scd62OU0D1e9NmnW9r9jp7mDh5G3Xc81+Ebsq4YkmC
        pV5z/FAFKorXY+5BkFlRSDuvAyt/A6W8ZB2n8njjAqfeWmVur7XBaS2IfaZU2bdhr5s8wHP775wLy
        WIJSglVVErcW/ERCpOeVEuK4VGoiTbQn/HalF0ZNtCLrFyQV/nlMbz/1L0kU3ijTCJeaungNq/72p
        YGKa42eg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdc9S-008YZ0-Fj; Thu, 21 Oct 2021 17:46:50 +0000
Date:   Thu, 21 Oct 2021 10:46:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/4] zram: fix two races and one zram leak
Message-ID: <YXGnijd+Ca+bWJZs@bombadil.infradead.org>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
 <YXCMtRVXrGOec6OR@google.com>
 <YXGl4v1cMJtCLg2d@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXGl4v1cMJtCLg2d@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 21, 2021 at 10:39:46AM -0700, Luis Chamberlain wrote:
> On Wed, Oct 20, 2021 at 02:40:05PM -0700, Minchan Kim wrote:
> > On Wed, Oct 20, 2021 at 09:55:44AM +0800, Ming Lei wrote:
> > > Hello,
> > > 
> > > Fixes three issues reported by Luis Chamberlain with one simpler approach:
> > > 
> > > - race between between zram_reset_device() and disksize_store() (1/4)
> > > 
> > > - zram leak during unloading module, which is one race between resetting
> > > and removing device (2/4)
> > > 
> > > - race between zram_remove and disksize_store (3/4)
> > > 
> > > Also replace replace fsync_bdev with sync_blockdev since no one opens
> > > it.(4/4)
> > > 
> > > V2:
> > > 	- take another approach to avoid failing of zram_remove()
> > > 	- add patch to address race between zram_reset_device() and
> > > 	  disksize_store()
> > > 
> > 
> > Thanks for breaking the problems down, Ming.
> > 
> > To me, the whole patchset looks good to me since each patch solves
> > the problem step by step and finally fix.
> > 
> > Luis, do you have any concern of this patchset to solve the cpuhp
> > problem? (Sorry in advance if I miss some concerns if you raised
> > in different thread. I'm totally lost).
> 
> Running tests against this now. Will report back!

So indeed with these patches I end up in the situation where we if
if spawn two ltp zram02.sh runs and cancel then randomly and start
them again:

zram: Can't change algorithm for initialized device

And after that only if you do:

swapoff /dev/zram0

Only then can you restart the tests again.

I had note seen that with my patch fix, but But Ming noted that he
did see that, and I trust him, although I can't reproduce that issue.

And from at lest a testing perspective then:

Tested-by: Luis Chamberlain <mcgrof@kernel.org>

I'll go and do the line-by-line code review now.

  Luis
