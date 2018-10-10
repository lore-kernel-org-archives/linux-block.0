Return-Path: <jthumshirn@suse.de>
Date: Wed, 10 Oct 2018 13:42:27 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/15 v2] loop: Fix oops and possible deadlocks
Message-ID: <20181010114227.GA12977@linux-x5ow.site>
References: <20181010100415.26525-1-jack@suse.cz>
 <a40fcf62-85a4-a6be-0803-d99dedf8cc61@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a40fcf62-85a4-a6be-0803-d99dedf8cc61@i-love.sakura.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 10, 2018 at 07:19:00PM +0900, Tetsuo Handa wrote:
> On 2018/10/10 19:04, Jan Kara wrote:
> > Hi,
> > 
> > this patch series fixes oops and possible deadlocks as reported by syzbot [1]
> > [2]. The second patch in the series (from Tetsuo) fixes the oops, the remaining
> > patches are cleaning up the locking in the loop driver so that we can in the
> > end reasonably easily switch to rereading partitions without holding mutex
> > protecting the loop device.
> > 
> > I have lightly tested the patches by creating, deleting, and modifying loop
> > devices but if there's some more comprehensive loopback device testsuite, I
> > can try running it. Review is welcome!
> 
> Testing on linux-next by syzbot will be the most comprehensive. ;-)

Apart from that blktests has a loop category and I think it could also be
worthwhile to add the C reproducer from syzkaller to blktests.

Byte,
	Johannes
-- 
Johannes Thumshirn                                        SUSE Labs 
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
