Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH -v2] loop: add recursion validation to LOOP_CHANGE_FD
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-block@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <20180507153352.GB999@thunk.org>
 <20180507153758.15989-1-tytso@mit.edu>
 <962f1475-38d6-6be5-8d6f-3a48d1bbcd2d@I-love.SAKURA.ne.jp>
 <20180605145149.GA7839@thunk.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d3d44e3e-00cb-d3d0-bdd0-b038ea474655@kernel.dk>
Date: Tue, 5 Jun 2018 09:07:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180605145149.GA7839@thunk.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/5/18 8:51 AM, Theodore Y. Ts'o wrote:
> On Tue, Jun 05, 2018 at 10:04:56PM +0900, Tetsuo Handa wrote:
>> I noticed that this patch is forgotten at ext4.git#loop-fix and therefore
>> is not available at linux-next.git . Please be sure to include for 4.18 .
> 
> I was assuming Jens was going to send it to Linus, after he does a
> review.  I could send a pull request to Linus directly, but while I
> was the original author of loop driver, that was like two decades ago
> (and LOOP_CHANGE_FD was *not* my idea), and normally loop driver
> changes goes up to Linus through the block tree, I believe.

I'll queue it up, thanks Ted.

-- 
Jens Axboe
