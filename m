Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] blk-mq: update ->init_request and ->exit_request
 prototypes
To: Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>
References: <20170427174501.18965-1-hch@lst.de>
 <20170427174501.18965-2-hch@lst.de>
 <x49inlpsoey.fsf@segfault.boston.devel.redhat.com>
 <20170428140923.GA32073@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e97a7758-075f-f48a-9a5f-52ce9ac8c1ec@kernel.dk>
Date: Fri, 28 Apr 2017 08:19:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170428140923.GA32073@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/28/2017 08:09 AM, Christoph Hellwig wrote:
> On Thu, Apr 27, 2017 at 02:20:21PM -0400, Jeff Moyer wrote:
>> Hi, Christoph,
>>
>> Christoph Hellwig <hch@lst.de> writes:
>>
>>> Remove the request_idx parameter, which can't be used safely now that we
>>> support I/O schedulers with blk-mq.  Except for a superflous check in
>>> mtip32xx it was unused anyway.
>>
>> I'm not sure how your patch builds.  If I look at the mtip32xx driver in
>> for-4.12/post-merge, I see this:
> 
> Meh, you're right.  It did build fine when I tested it based on Jens'
> for-4.12/block + my nvme PR.  But it seems like the post-merge merge
> branch doesn't have the previous mtip32xxx fix yet that is a prerequisite
> for this change.  Jens:  any idea why?  I'm getting lost in the maze
> of branches..

There are only two branches :-)

I'll rebase the post-merge one, that's basically just for me to sync. But
it doesn't help that they are moving apart. I'll do that now. If you can
review the mtip32xx stuff, then we can have one happy base in post-merge
that can take further work on top of that.

-- 
Jens Axboe
