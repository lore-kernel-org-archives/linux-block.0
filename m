Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: set sk->sk_sndtimeo for our sockets
To: josef@toxicpanda.com, nbd-general@lists.sourceforge.net,
 linux-block@vger.kernel.org, kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <1496950770-5642-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b3fd3402-4ef4-0540-9fda-394433d24d1e@kernel.dk>
Date: Fri, 9 Jun 2017 08:33:47 -0600
MIME-Version: 1.0
In-Reply-To: <1496950770-5642-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/08/2017 01:39 PM, josef@toxicpanda.com wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> If the nbd server stops receiving packets altogether we will get stuck
> waiting for them to receive indefinitely as the tcp buffer will never
> empty, which looks like a deadlock.  Fix this by setting the sk send
> timeout to our configured timeout, that way if the server really
> misbehaves we'll disconnect cleanly instead of waiting forever.

Queued up for 4.13, thanks.

-- 
Jens Axboe
