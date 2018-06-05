Return-Path: <tytso@thunk.org>
Date: Tue, 5 Jun 2018 10:51:49 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH -v2] loop: add recursion validation to LOOP_CHANGE_FD
Message-ID: <20180605145149.GA7839@thunk.org>
References: <20180507153352.GB999@thunk.org>
 <20180507153758.15989-1-tytso@mit.edu>
 <962f1475-38d6-6be5-8d6f-3a48d1bbcd2d@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <962f1475-38d6-6be5-8d6f-3a48d1bbcd2d@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 05, 2018 at 10:04:56PM +0900, Tetsuo Handa wrote:
> I noticed that this patch is forgotten at ext4.git#loop-fix and therefore
> is not available at linux-next.git . Please be sure to include for 4.18 .

I was assuming Jens was going to send it to Linus, after he does a
review.  I could send a pull request to Linus directly, but while I
was the original author of loop driver, that was like two decades ago
(and LOOP_CHANGE_FD was *not* my idea), and normally loop driver
changes goes up to Linus through the block tree, I believe.

Cheers,

						- Ted

> 
> On 2018/05/08 0:37, Theodore Ts'o wrote:
> > Refactor the validation code used in LOOP_SET_FD so it is also used in
> > LOOP_CHANGE_FD.  Otherwise it is possible to construct a set of loop
> > devices that all refer to each other.  This can lead to a infinite
> > loop in starting with "while (is_loop_device(f)) .." in loop_set_fd().
> > 
> > Fix this by refactoring out the validation code and using it for
> > LOOP_CHANGE_FD as well as LOOP_SET_FD.
> > 
> > Reported-by: syzbot+4349872271ece473a7c91190b68b4bac7c5dbc87@syzkaller.appspotmail.com
> > Reported-by: syzbot+40bd32c4d9a3cc12a339@syzkaller.appspotmail.com
> > Reported-by: syzbot+769c54e66f994b041be7@syzkaller.appspotmail.com
> > Reported-by: syzbot+0a89a9ce473936c57065@syzkaller.appspotmail.com
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  drivers/block/loop.c | 68 +++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 38 insertions(+), 30 deletions(-)
> > 
