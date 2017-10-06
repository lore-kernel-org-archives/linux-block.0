Return-Path: <devtimhansen@gmail.com>
Return-Path: <devtimhansen@gmail.com>
Date: Fri, 6 Oct 2017 18:30:13 -0400
From: Tim Hansen <devtimhansen@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexander.levin@one.verizon.com
Subject: Re: [PATCH] block/bio: Remove null checks before mempool_destroy in
 bioset_free
Message-ID: <20171006223013.GB30627@debian>
References: <20171006184513.GA78611@debian>
 <c40daeba-d490-3190-efa6-a534da96d1db@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c40daeba-d490-3190-efa6-a534da96d1db@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 06, 2017 at 01:05:01PM -0600, Jens Axboe wrote:
> On 10/06/2017 12:45 PM, Tim Hansen wrote:
> > This patch removes redundant checks for null values on bio_pool and bvec_pool.
> > 
> > Found using make coccicheck M=block/ on linux-net tree on the next-20170929 tag.
> > 
> > Related to patch 9987695 that removed similar checks in bio-integrity. 
> 
> Applied, but ditto on the line length. Additionally, I killed that reference
> to "patch 9987695", I don't know what that means? What does that refer to?
> 
> -- 
> Jens Axboe
> 

The patch number I referenced is what is used on patchwork.com to
reference a patch under review.  I'll leave that out in the next message.
What is the proper manner of referencing another patch thats still in 
review?  
