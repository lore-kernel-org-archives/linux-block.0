Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44068 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbdARWgn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 17:36:43 -0500
Date: Wed, 18 Jan 2017 17:38:57 -0500
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH for-4.10] blk-mq: Remove unused variable
Message-ID: <20170118223856.GD27274@localhost.localdomain>
References: <1484778075-25065-1-git-send-email-keith.busch@intel.com>
 <625adb77-d3cf-0377-99f2-06a8be8c2467@fb.com>
 <4f59ef02-f114-4423-1b28-6f4ff582add4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4f59ef02-f114-4423-1b28-6f4ff582add4@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 18, 2017 at 02:21:48PM -0800, Jens Axboe wrote:
> On 01/18/2017 02:16 PM, Jens Axboe wrote:
> > On 01/18/2017 02:21 PM, Keith Busch wrote:
> >> Signed-off-by: Keith Busch <keith.busch@intel.com>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > 
> > Does it cause a warning anywhere? If not, I'd rather not apply
> > it, since it'll cause a merge conflict for 4.11 (and the problem
> > doesn't exist there).
> 
> Ah screw it, the fact that we have that in 4.10 is an eye sore.
> I'd rather deal with the conflict, I'll apply it for 4.10. Thanks
> Keith.

Okay, thanks. I was just clearing my backlog of emails and this was on
my todo list from a couple weeks ago, but I didn't noticed 4.11 corrected
this in the mq scheduler set.
