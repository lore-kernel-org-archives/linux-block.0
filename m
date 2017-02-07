Return-Path: <prvs=3211f4b139=jbacik@fb.com>
Message-ID: <1486485392.4094.0.camel@fb.com>
Subject: Re: [PATCH] nbd: freeze the queue before making changes
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <kernel-team@fb.com>,
        <nbd-general@lists.sourceforge.net>, <axboe@kernel.dk>
Date: Tue, 7 Feb 2017 11:36:32 -0500
In-Reply-To: <1486396489-2911-1-git-send-email-jbacik@fb.com>
References: <1486396489-2911-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-02-06 at 10:54 -0500, Josef Bacik wrote:
> The way we make changes to the NBD device is inherently racey, as we
> could be in the middle of a request and suddenly change the number of
> connections.  In practice this isn't a big deal, but with timeouts we
> have to take the config_lock in order to protect ourselves since it
> is
> important those values don't change.  Fix this by freezing the queue
> before we do any of our device operations.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Actually nevermind, this messes with my plans around reconnections
since freezing also waits for existing timeouts to fire.  I'll drop
this and fix it a different way.  Thanks,

Josef
