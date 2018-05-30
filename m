Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-throttle: return proper bool type to caller instead
 of 0/1
To: Chengguang Xu <cgxu519@gmx.com>
Cc: linux-block@vger.kernel.org
References: <1527589964-138223-1-git-send-email-cgxu519@gmx.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1cf0f593-4ed7-f171-7f9b-85d5149e2830@kernel.dk>
Date: Wed, 30 May 2018 12:48:36 -0600
MIME-Version: 1.0
In-Reply-To: <1527589964-138223-1-git-send-email-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/29/18 4:32 AM, Chengguang Xu wrote:
> Change to return true/false only for bool type return code.

Looks good, applied.

-- 
Jens Axboe
