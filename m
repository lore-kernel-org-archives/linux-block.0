Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: Consistently use request pointer in debug messages.
To: kvigor@gmail.com, linux-block@vger.kernel.org
Cc: josef@toxicpanda.com, Kevin Vigor <kvigor@fb.com>
References: <1528130412-4541-1-git-send-email-kvigor@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <10d1cb78-5d68-0301-ae5c-3d35ce68383a@kernel.dk>
Date: Tue, 5 Jun 2018 08:23:06 -0600
MIME-Version: 1.0
In-Reply-To: <1528130412-4541-1-git-send-email-kvigor@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/4/18 10:40 AM, kvigor@gmail.com wrote:
> From: Kevin Vigor <kvigor@fb.com>
> 
> Existing dev_dbg messages sometimes identify request using request
> pointer, sometimes using nbd_cmd pointer. This makes it hard to
> follow request flow. Consistently use request pointer instead.

You're missing the Signed-off-by.

-- 
Jens Axboe
