Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1248C433EF
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 20:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377615AbiATUZq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 15:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiATUZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 15:25:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7959EC061574
        for <linux-block@vger.kernel.org>; Thu, 20 Jan 2022 12:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c40NGbwZ6nvE+y1tnWH+4VVq0VqCrfO9p3GGtrmRYlc=; b=ZC+5h8GxWOjNJrylPM2bsiVuyP
        CYtYFj9I9x+qQ7r337D+Z2WGgzeo8Ww5k9X+kDfPDwG68U9PRT1235y5mpGSFGPW9J+ZacnvaAO35
        J1JjN2m5exPbglrNuaf68qpJM6HkjX1fhSgFi440rOYfeZ/6fAEfOXysCTAuG1m6iANBfKLZFlXjM
        fSuhiUK5/kpPhlK7QCutuLpaNNAabwZudyhAF2LN9tyGDaF2p80vlOOLlmO6LGRihiIgL6b6Ou1lj
        N0xLGXKH1hLJVlcOiW0rF327SQN/bATuUXBDsF8xfdP7J4lYx9xaJ1TfccMno2GBRF8+46S322Egu
        VDDHqeEQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAe04-00D7DV-7I; Thu, 20 Jan 2022 20:25:40 +0000
Date:   Thu, 20 Jan 2022 12:25:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "dwagner@suse.de" <dwagner@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        pankydev8@gmail.com, javier.gonz@samsung.com, joshi.k@samsung.com,
        vincent.fu@samsung.com, a.manzanares@samsung.com,
        e.kyvenko@samsung.com, k.jensen@samsung.com
Subject: Re: [PATCH] blktests: replace module removal with patient module
 removal
Message-ID: <YenFRNuU2sUNxvpx@bombadil.infradead.org>
References: <20211116172926.587062-1-mcgrof@kernel.org>
 <bdef0665-255d-3de8-ceac-d5ca638b1484@nvidia.com>
 <YbCqsDQxzk0Q0hSl@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbCqsDQxzk0Q0hSl@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 08, 2021 at 04:53:04AM -0800, Luis Chamberlain wrote:
> On Thu, Nov 18, 2021 at 01:38:49AM +0000, Chaitanya Kulkarni wrote:
> > On 11/16/21 09:29, Luis Chamberlain wrote:
> > > A long time ago, in a galaxy far, far away...
> > > 
> > > I ran into some odd scsi_debug false positives with fstests. This
> > > prompted me to look into them given these false positives prevents
> > > me from moving forward with establishing a test baseline with high
> > > number of cycles. That is, this stupid issue was prevening creating
> > > high confidence in testing.
> > > 
> > > I reported it [0] and exchanged some ideas with Doug. However, in
> > > the end, despite efforts to help things with scsi_debug there were
> > > still issues lingering which seemed to defy our expectations upstream.
> > > One of the last hanging fruit issues is and always has been that
> > > userspace expectations for proper module removal has been broken,
> > > so in the end I have demonstrated this is a generic issue [1].
> > > 
> > > Long ago a WAIT option for module removal was added... that was then
> > > removed as it was deemed not needed as folks couldn't figure out when
> > > these races happened. The races are actually pretty easy to trigger, it
> > > was just never properly documented. A simpe blkdev_open() will easily
> > > bump a module refcnt, and these days many thing scan do that sort of
> > > thing.
> > > 
> > > The proper solution is to implement then a patient module removal
> > > on kmod and patches have been sent for that and those patches are
> > > under review. In the meantime we need a work around to open code a
> > > similar solution for users of old versions of kmod. I sent an open
> > > coded solution for fstests about since August 19th and has been used
> > > there for a few months now. Now that that stuff is merged and tested
> > > in fstests with more exposure, its time to match parity on blktests.
> > > 
> > > I've tested blktests with this for things which I can run virtually
> > > for a while now. More wider testig is welcomed.
> > > 
> > > [0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=214015
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > >
> > 
> > Thanks for having this work done and explaining the importance of it.
> > 
> > Give me couple of days, I'll provide you a feedback after I finish my
> > testing of your patch.
> 
> How did testing go?

*Friendly poke*

  Luis
