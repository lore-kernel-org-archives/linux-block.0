Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] loop: fix LOOP_GET_STATUS lock imbalance
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Dmitry Vyukov <dvyukov@google.com>
References: <6bee3eddc24ef5525ca12efb023e66b2503cb178.1523033157.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <68e352d4-1775-d8be-5a17-2406df33b3e5@kernel.dk>
Date: Fri, 6 Apr 2018 13:37:36 -0600
MIME-Version: 1.0
In-Reply-To: <6bee3eddc24ef5525ca12efb023e66b2503cb178.1523033157.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/6/18 10:57 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 2d1d4c1e591f made loop_get_status() drop lo_ctx_mutex before
> returning, but the loop_get_status_old(), loop_get_status64(), and
> loop_get_status_compat() wrappers don't call loop_get_status() if the
> passed argument is NULL. The callers expect that the lock is dropped, so
> make sure we drop it in that case, too.

Applied, thanks Omar.

-- 
Jens Axboe
