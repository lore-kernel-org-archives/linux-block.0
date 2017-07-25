Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: clear disconnected on reconnect
To: josef@toxicpanda.com, nbd-general@lists.sourceforge.net,
 linux-block@vger.kernel.org, kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <1501003879-18014-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0dee4a36-f33b-078c-d2c5-4ad23c174e7e@kernel.dk>
Date: Tue, 25 Jul 2017 13:58:22 -0600
MIME-Version: 1.0
In-Reply-To: <1501003879-18014-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/25/2017 11:31 AM, josef@toxicpanda.com wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> If our device loses its connection for longer than the dead timeout we
> will set NBD_DISCONNECTED in order to quickly fail any pending IO's that
> flood in after the IO's that were waiting during the dead timer.
> However if we re-connect at some point in the future we'll still see
> this DISCONNECTED flag set if we then lose our connection again after
> that, which means we won't get notifications for our newly lost
> connections.  Fix this by just clearing the DISCONNECTED flag on
> reconnect in order to make sure everything works as it's supposed to.

Will add for 4.13. Any chance that you can write blktests regression
tests for some of the bugs that you are fixing for nbd? Would be nice
to have that be part of the regular regression suite.

-- 
Jens Axboe
