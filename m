Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Wed, 30 May 2018 13:28:51 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: kvigor@gmail.com
Cc: linux-block@vger.kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	Kevin Vigor <kvigor@fb.com>
Subject: Re: [PATCH] nbd: clear DISCONNECT_REQUESTED flag once disconnection
 occurs.
Message-ID: <20180530172850.a2cqzrl6rltlxmni@destiny>
References: <1527698711-14919-1-git-send-email-kvigor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527698711-14919-1-git-send-email-kvigor@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 30, 2018 at 10:45:11AM -0600, kvigor@gmail.com wrote:
> From: Kevin Vigor <kvigor@fb.com>
> 
> When a userspace client requests a NBD device be disconnected, the
> DISCONNECT_REQUESTED flag is set. While this flag is set, the driver
> will not inform userspace when a connection is closed.
> 
> Unfortunately the flag was never cleared, so once a disconnect was
> requested the driver would thereafter never tell userspace about a
> closed connection. Thus when connections failed due to timeout, no
> attempt to reconnect was made and eventually the device would fail.
> 
> Fix by clearing the DISCONNECT_REQUESTED flag (and setting the
> DISCONNECTED flag) once all connections are closed.
> 
> Changes relative to v1 (https://marc.info/?l=linux-block&m=152763540418902):
> 
> * remove pointless wake_up() -> wake_up_all() change.
> 

Usually you want to put the changelog after the --- bit below so we can all see
it but it doesn't end up in the git changelog.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
