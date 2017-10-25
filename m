Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: handle interrupted sendmsg with a sndtimeo set
To: Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>, stable@vger.kernel.org
References: <1508875038-3397-1-git-send-email-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cbd4b1be-2a67-be68-d23a-b4d45625d4ad@kernel.dk>
Date: Tue, 24 Oct 2017 18:51:18 -0600
MIME-Version: 1.0
In-Reply-To: <1508875038-3397-1-git-send-email-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/24/2017 01:57 PM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> If you do not set sk_sndtimeo you will get -ERESTARTSYS if there is a
> pending signal when you enter sendmsg, which we handle properly.
> However if you set a timeout for your commands we'll set sk_sndtimeo to
> that timeout, which means that sendmsg will start returning -EINTR
> instead of -ERESTARTSYS.  Fix this by checking either cases and doing
> the correct thing.

Added for 4.14, thanks Josef.

-- 
Jens Axboe
