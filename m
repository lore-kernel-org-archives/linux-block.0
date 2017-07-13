Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35156 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbdGMRXt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2017 13:23:49 -0400
Date: Thu, 13 Jul 2017 19:23:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaohua Li <shli@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        axboe@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 2/2] block: delete bio_uninit
Message-ID: <20170713172347.GC5107@lst.de>
References: <cover.1499881589.git.shli@fb.com> <094050f349fdf7eed4a20335e9a7573d7c8c9b35.1499881589.git.shli@fb.com> <20170713074519.GA13404@lst.de> <20170713165023.vcnumrgvbu4cw6jx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713165023.vcnumrgvbu4cw6jx@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 13, 2017 at 09:50:23AM -0700, Shaohua Li wrote:
> > As said in the last mail I think there is no point in having this call..
> 
> I'm hesitant to do this. bio_associate_blkcg/bio_associate_current can be
> called in any time for a bio, so we not just attach cgroup info to info in bio
> submit (maybe the bio_associate_blkcg/bio_associate_current callers do sumbit
> always, but I didn't audit yet).

bio_associate_current is only called from blk_throtl_assoc_bio, which
is only called from blk_throtl_bio, which is only called from
blkcg_bio_issue_check, which is only called from
generic_make_request_checks, which is only called from
generic_make_request, which at that point consumes the bio from the
callers perspective.

bio_associate_blkcg might be a different story, but then we should
treat both very differently.

> The other reason is I'd like
> blk_throtl_bio_endio is only called once for the whole bio not for splitted
> bio, so this depends on bio_free to free cgroup info for chained bio which
> always does bio_put.

Then we'll need to fix that.  We really should not require every
caller of bio_init to pair it with a new uninit call, which would be
a whole lot more work.
