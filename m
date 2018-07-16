Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] nbd: don't requeue the same request twice.
To: Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, kernel-team@fb.com
References: <20180716161136.21222-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a1cd7ad4-7761-56ed-997e-a40763308a25@kernel.dk>
Date: Mon, 16 Jul 2018 10:16:33 -0600
MIME-Version: 1.0
In-Reply-To: <20180716161136.21222-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/16/18 10:11 AM, Josef Bacik wrote:
> We can race with the snd timeout and the per-request timeout and end up
> requeuing the same request twice.  We can't use the send_complete
> completion to tell if everything is ok because we hold the tx_lock
> during send, so the timeout stuff will block waiting to mark the socket
> dead, and we could be marked complete and still requeue.  Instead add a
> flag to the socket so we know whether we've been requeued yet.

Applied 1-2 for 4.18, thanks.

-- 
Jens Axboe
