Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0CDC433EF
	for <linux-block@archiver.kernel.org>; Wed,  8 Dec 2021 12:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhLHM4k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhLHM4k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Dec 2021 07:56:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF42C061746
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 04:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ndwi3X4GBmotrLQ61fzAGl+hHcE4ZqvK9ei6WuQ1B0s=; b=4U/fHZdlTbKgMrSE+63Tk3dFlO
        fVhiibBlTVN5DZdPbC6ETDdcik5bPXT5YvpZla33DrlhkJ4wJjN16LzmySUXUKkyJC8t9GshmM39i
        hlS+ypiiJGJxLiYA41OTWOmTziGNS7V3wvzhKnrHZkcCJ1O4wnGbUBrfuhRaIY3EG0Lyl7u+nBbM2
        3gQL4b+JnPnxj/M5/+OW8Zx+tgX5/63PimN9LatEGp7SbdbCEgG4Kd5Fo/tGO3lYfccnyJ2Dzk1gV
        kWueklMAQ9+aKpjnFj0jtRizxjzG7wdmFn+UHhIa0QxiSRALL92IjL3x0hnhOzR5vAaXKJ+bcqbVK
        Y+24F6Hw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muwRU-00Cbjn-Sy; Wed, 08 Dec 2021 12:53:04 +0000
Date:   Wed, 8 Dec 2021 04:53:04 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "dwagner@suse.de" <dwagner@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: replace module removal with patient module
 removal
Message-ID: <YbCqsDQxzk0Q0hSl@bombadil.infradead.org>
References: <20211116172926.587062-1-mcgrof@kernel.org>
 <bdef0665-255d-3de8-ceac-d5ca638b1484@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdef0665-255d-3de8-ceac-d5ca638b1484@nvidia.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 18, 2021 at 01:38:49AM +0000, Chaitanya Kulkarni wrote:
> On 11/16/21 09:29, Luis Chamberlain wrote:
> > A long time ago, in a galaxy far, far away...
> > 
> > I ran into some odd scsi_debug false positives with fstests. This
> > prompted me to look into them given these false positives prevents
> > me from moving forward with establishing a test baseline with high
> > number of cycles. That is, this stupid issue was prevening creating
> > high confidence in testing.
> > 
> > I reported it [0] and exchanged some ideas with Doug. However, in
> > the end, despite efforts to help things with scsi_debug there were
> > still issues lingering which seemed to defy our expectations upstream.
> > One of the last hanging fruit issues is and always has been that
> > userspace expectations for proper module removal has been broken,
> > so in the end I have demonstrated this is a generic issue [1].
> > 
> > Long ago a WAIT option for module removal was added... that was then
> > removed as it was deemed not needed as folks couldn't figure out when
> > these races happened. The races are actually pretty easy to trigger, it
> > was just never properly documented. A simpe blkdev_open() will easily
> > bump a module refcnt, and these days many thing scan do that sort of
> > thing.
> > 
> > The proper solution is to implement then a patient module removal
> > on kmod and patches have been sent for that and those patches are
> > under review. In the meantime we need a work around to open code a
> > similar solution for users of old versions of kmod. I sent an open
> > coded solution for fstests about since August 19th and has been used
> > there for a few months now. Now that that stuff is merged and tested
> > in fstests with more exposure, its time to match parity on blktests.
> > 
> > I've tested blktests with this for things which I can run virtually
> > for a while now. More wider testig is welcomed.
> > 
> > [0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=214015
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> >
> 
> Thanks for having this work done and explaining the importance of it.
> 
> Give me couple of days, I'll provide you a feedback after I finish my
> testing of your patch.

How did testing go?

  Luis
