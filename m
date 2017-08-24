Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH for-next] block: Fix left-over bi_bdev usage
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Cc: linux-block <linux-block@vger.kernel.org>
References: <1503531955-2626-1-git-send-email-keith.busch@intel.com>
 <20170824084133.GA19313@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3141c7a7-7da5-cf5f-9667-00b270c2a233@kernel.dk>
Date: Thu, 24 Aug 2017 08:09:03 -0600
MIME-Version: 1.0
In-Reply-To: <20170824084133.GA19313@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/24/2017 02:41 AM, Christoph Hellwig wrote:
> On Wed, Aug 23, 2017 at 07:45:55PM -0400, Keith Busch wrote:
>> The bi_bdev field was replaced with the gendisk. This patch just fixes
>> an omission.
> 
> Thanks Keith.  I'm pretty sure I fixed exactly this one when
> rebasing from my nvme tree to the block tree.  But I guess I didn't
> finish the rebase fully, as usual - git rebase considered harmful :)

Problem is, the issue doesn't exist in my for-4.14/block branch, it
only exists when that is merged with master. I'll apply it to my
for-next branch, even though that one is not persistent, so that
it builds.

-- 
Jens Axboe
