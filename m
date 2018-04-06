Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36001 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeDFRBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Apr 2018 13:01:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id g14so1176005pfh.3
        for <linux-block@vger.kernel.org>; Fri, 06 Apr 2018 10:01:45 -0700 (PDT)
Date: Fri, 6 Apr 2018 10:01:42 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] loop: fix LOOP_GET_STATUS lock imbalance
Message-ID: <20180406170142.GB11697@vader>
References: <6bee3eddc24ef5525ca12efb023e66b2503cb178.1523033157.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6bee3eddc24ef5525ca12efb023e66b2503cb178.1523033157.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 06, 2018 at 09:57:03AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 2d1d4c1e591f made loop_get_status() drop lo_ctx_mutex before
> returning, but the loop_get_status_old(), loop_get_status64(), and
> loop_get_status_compat() wrappers don't call loop_get_status() if the
> passed argument is NULL. The callers expect that the lock is dropped, so
> make sure we drop it in that case, too.
> 
> Reported-by: syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com
> Fixes: 2d1d4c1e591f ("loop: don't call into filesystem while holding lo_ctl_mutex")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Based on Linus' tree.
> 
>  drivers/block/loop.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)

Also just pushed a regression test to blktests:

140ee15de9f3 ("loop: add ioctl lock imbalance regression test")
