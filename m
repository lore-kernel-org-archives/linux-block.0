Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] bcache: closures: move control bits one bit right
To: Michael Lyle <mlyle@lyle.org>, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>
References: <20180109191323.5816-1-mlyle@lyle.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b88ff532-f66a-8dc3-db0c-cd207e5a3e3e@kernel.dk>
Date: Tue, 9 Jan 2018 12:19:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180109191323.5816-1-mlyle@lyle.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 12:13 PM, Michael Lyle wrote:
> Otherwise, architectures that do negated adds of atomics (e.g. s390)
> to do atomic_sub fail in closure_set_stopped.

Applied, thanks for fixing that up.

-- 
Jens Axboe
