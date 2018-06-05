Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: Consistently use request pointer in debug messages.
To: kvigor@gmail.com, linux-block@vger.kernel.org
Cc: josef@toxicpanda.com, Kevin Vigor <kvigor@fb.com>
References: <1528130412-4541-1-git-send-email-kvigor@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4706db89-d51b-a1a9-e01f-50f1a9af6f86@kernel.dk>
Date: Tue, 5 Jun 2018 09:45:21 -0600
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

Applied, with the SOB added.

-- 
Jens Axboe
