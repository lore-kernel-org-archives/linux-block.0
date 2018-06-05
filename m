Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH -v2] loop: add recursion validation to LOOP_CHANGE_FD
To: "Theodore Ts'o" <tytso@mit.edu>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, syzkaller-bugs@googlegroups.com
References: <20180507153352.GB999@thunk.org>
 <20180507153758.15989-1-tytso@mit.edu>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <962f1475-38d6-6be5-8d6f-3a48d1bbcd2d@I-love.SAKURA.ne.jp>
Date: Tue, 5 Jun 2018 22:04:56 +0900
MIME-Version: 1.0
In-Reply-To: <20180507153758.15989-1-tytso@mit.edu>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

I noticed that this patch is forgotten at ext4.git#loop-fix and therefore
is not available at linux-next.git . Please be sure to include for 4.18 .

On 2018/05/08 0:37, Theodore Ts'o wrote:
> Refactor the validation code used in LOOP_SET_FD so it is also used in
> LOOP_CHANGE_FD.  Otherwise it is possible to construct a set of loop
> devices that all refer to each other.  This can lead to a infinite
> loop in starting with "while (is_loop_device(f)) .." in loop_set_fd().
> 
> Fix this by refactoring out the validation code and using it for
> LOOP_CHANGE_FD as well as LOOP_SET_FD.
> 
> Reported-by: syzbot+4349872271ece473a7c91190b68b4bac7c5dbc87@syzkaller.appspotmail.com
> Reported-by: syzbot+40bd32c4d9a3cc12a339@syzkaller.appspotmail.com
> Reported-by: syzbot+769c54e66f994b041be7@syzkaller.appspotmail.com
> Reported-by: syzbot+0a89a9ce473936c57065@syzkaller.appspotmail.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  drivers/block/loop.c | 68 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 30 deletions(-)
> 
