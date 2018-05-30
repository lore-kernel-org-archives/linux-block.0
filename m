Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: clear DISCONNECT_REQUESTED flag once disconnection
 occurs.
To: kvigor@gmail.com, linux-block@vger.kernel.org
Cc: josef@toxicpanda.com, Kevin Vigor <kvigor@fb.com>
References: <1527698711-14919-1-git-send-email-kvigor@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1b462c26-1a10-58b8-8459-9d9fa3fb4413@kernel.dk>
Date: Wed, 30 May 2018 11:31:05 -0600
MIME-Version: 1.0
In-Reply-To: <1527698711-14919-1-git-send-email-kvigor@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/30/18 10:45 AM, kvigor@gmail.com wrote:
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

Applied, thanks Kevin.

-- 
Jens Axboe
