Return-Path: <axboe@kernel.dk>
Subject: Re: [block] 044f1daaaa kernel BUG at block/blk-mq.c:415!
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
 LKP <lkp@01.org>
References: <20170627035301.j4slju6w4hah76tt@wfg-t540p.sh.intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4eea705d-fa46-8ae5-a5bc-d47384a75d2e@kernel.dk>
Date: Mon, 26 Jun 2017 22:16:09 -0600
MIME-Version: 1.0
In-Reply-To: <20170627035301.j4slju6w4hah76tt@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/26/2017 09:53 PM, Fengguang Wu wrote:
> Greetings,
> 
> Sorry the report is a bit late, this bug looks still active:
> 
 
First I've heard about it!

> [   36.037364]   sector 2, nr/cnr 0/2
> [   36.037367]   bio ffff88001af84e80, biotail ffff88001af84e80, len 0
> [   36.037367]   bio ffff88001af84e80, biotail ffff88001af84e80, len 0
> [   36.037424] ------------[ cut here ]------------
> [   36.037424] ------------[ cut here ]------------
> [   36.037428] kernel BUG at block/blk-mq.c:415!
> [   36.037428] kernel BUG at block/blk-mq.c:415!
> [   36.037433] invalid opcode: 0000 [#1] PREEMPT SMP
> [   36.037433] invalid opcode: 0000 [#1] PREEMPT SMP
> [   36.037434] Modules linked in:
> [   36.037434] Modules linked in:

Do you have the full dmesg of this? I looked at the one attached to the
bug report, but that's a completely different bug (NULL deref in drm).
Are you sure it's still the above blk-mq BUG() we're hitting?

-- 
Jens Axboe
