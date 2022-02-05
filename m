Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C72C433EF
	for <linux-block@archiver.kernel.org>; Sat,  5 Feb 2022 02:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378993AbiBECdw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 21:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378981AbiBECdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Feb 2022 21:33:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9217C061346
        for <linux-block@vger.kernel.org>; Fri,  4 Feb 2022 18:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+0+OoL26Ayv+ly1T+I4jBBoxGfM4bWwwpHkARxTdN7Q=; b=BEInJHLWnohXin7TqpJzO64xkw
        7/CHx3no9lca0WJdohzLxeqvwUf73U1OeUS6jpISpwUJ1ou2HylvoQIicOnn5LqftA/IyIdTmuQSd
        M8PYDffBPvH5eAbAc6MIZl8Q8mBUofZ4ps8O0EizvwDjkKpaveuKvJHydb+IaiV3Lyl8Zh+0iy6Jf
        wvJ6MXyyET/CVMY5ar5e8TeXBdPSE9+/mcdB1hBnKGU9QG65i+EgbRKRjviSG9A365VXjlO4b9ST9
        OyIjFIMdRauJ4yxbFwhKudnjxuath0vfftMCIgcVqao+C7GaEfV/p818vVQ/tv17Glcc5o4sgSQXz
        L+GGghjw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGAtP-005zGw-AU; Sat, 05 Feb 2022 02:33:43 +0000
Date:   Fri, 4 Feb 2022 18:33:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "dwagner@suse.de" <dwagner@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] blktests: replace module removal with patient module
 removal
Message-ID: <Yf3iA/dDXOBJMXqU@bombadil.infradead.org>
References: <20211116172926.587062-1-mcgrof@kernel.org>
 <48b1d742-888c-ee14-297e-c63ae3bf37ed@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b1d742-888c-ee14-297e-c63ae3bf37ed@nvidia.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 26, 2022 at 05:39:13AM +0000, Chaitanya Kulkarni wrote:
> On 11/16/21 9:29 AM, Luis Chamberlain wrote:
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
> > ---
> 
> 
> This looks good to me, I'd wait Bart (CCd here) to review the
> srp side.
> 
> Looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Bart, *poke*

  Luis
