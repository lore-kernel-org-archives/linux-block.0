Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27386 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932423AbdBPRrh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 12:47:37 -0500
Date: Thu, 16 Feb 2017 10:37:55 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] opal: Use empty structure when not defined
Message-ID: <20170216173755.GA3204@sbauer-Z170X-UD5>
References: <1487204187-4004-1-git-send-email-keith.busch@intel.com>
 <20170216075812.GA7662@infradead.org>
 <84b78f2d-0238-0fa1-e0b3-d46e7d4cb9be@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84b78f2d-0238-0fa1-e0b3-d46e7d4cb9be@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 16, 2017 at 10:18:59AM -0700, Jon Derrick wrote:
> It looks good to me at first glance but I can't apply it. What tree are
> you on?
> 
> On 02/16/2017 12:58 AM, Christoph Hellwig wrote:
> > I'd rather prefer to make the structure separately allocated as
> > discussed before.  Scott, can you test the patch below?  I'm not near
> > my devices I could test on.
> > 

He doesn't have the most recent changes with the uapi IOW fixes. I got it applied
and tested and it works. Going to review it more aggressively now. We had something
very similar in one of the previous patches before we switched off of using a sed_context
struct.

If you do want to apply and test I did the following:
1) Pull Jens' for-next
2) reset fb2a77e4a25ef63ff5b51b3bd53027077b402b0d --hard
3) apply his patch
4) git pull https://kernel.googlesource.com/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
5) resolve the 2 small conflicts in core.c and sed-opal.h
   in sed-opal.h take his init_opal_dev change and the newer sed_ioctl
   in core.c take his change but change arg to be (void __user *) arg);
