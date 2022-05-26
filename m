Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9097BC433F5
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 18:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbiEZS4C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 May 2022 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348651AbiEZS4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 May 2022 14:56:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A88CC8BE8;
        Thu, 26 May 2022 11:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64F44B821B3;
        Thu, 26 May 2022 18:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D1AC385A9;
        Thu, 26 May 2022 18:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653591354;
        bh=pczY83jsu1LEWRKrejBiOJS4kT5ZWIAp6rMQk8DXniA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ui1hASmYzUHFvysEjg8TGIOalX5Zh0B0AFDIP60gh2Ep64gZH8/KzEQhLw5ja8Ihe
         O3TsMInNK+B+/x+W/HCdEE5UpJRI+lQrfGNKXQ8QcmG/vc3GX0jV47ELcZS5U34SPi
         h+8EiBGLs8NGHcsAiP06WdsSbktWrsWGemMIRoC+myML6PXCBe/jEDk6yWlyx45MaT
         a20INR1nsxqxfo3ojMLeljfA9ivnTtmGIdycsdFEtuH5rWUyBCVXbfZKy8Btjawx8v
         TrUCKLV4HfIt538qXRGnJJeGh35PgjaJDQWBBrBDcW25DPyQc2w1FK2fxM0QockMKm
         On40kuSfUGkpQ==
Date:   Thu, 26 May 2022 12:55:50 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com
Subject: Re: [PATCHv4 8/9] block: relax direct io memory alignment
Message-ID: <Yo/NNiGbnHw/G9Lc@kbusch-mbp.dhcp.thefacebook.com>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-9-kbusch@fb.com>
 <Yo8sZWNNTKM2Kwqm@sol.localdomain>
 <Yo+FtQ8GlHtMT3pT@kbusch-mbp.dhcp.thefacebook.com>
 <Yo/DYI17KWgXJNyB@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo/DYI17KWgXJNyB@sol.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 26, 2022 at 11:13:52AM -0700, Eric Biggers wrote:
> On Thu, May 26, 2022 at 07:50:45AM -0600, Keith Busch wrote:
> > On Thu, May 26, 2022 at 12:29:41AM -0700, Eric Biggers wrote:
> > > On Wed, May 25, 2022 at 06:06:12PM -0700, Keith Busch wrote:
> > > > +	/*
> > > > +	 * Each segment in the iov is required to be a block size multiple.
> > > 
> > > Where is this enforced?
> > 
> > Right below the comment. If it isn't a block size multiple, then ALIGN_DOWN
> > will eventually result in 0 and -EFAULT is returned. 
> 
> That's interesting, I would have expected it to be checked in
> blkdev_dio_aligned().

That would require a change to the iov_iter_alignment API, or a new function
entirely.
 
> EFAULT isn't the correct error code for this case; it should be EINVAL as is
> normally the case for bad alignment.  See the man pages for read and write.

The EFAULT was just to get the do-while loop to break out. The callers in this
patch still return EINVAL when it sees the iov_iter hasn't advanced to the end.

But there are some cases where the EFAULT would be returned to the user. Let me
see how difficult it would be catch it early in blkdev_dio_aligned().
