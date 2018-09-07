Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: umem: replace spin_lock_bh with spin_lock in
 tasklet callback
To: jun qian <hangdianqj@163.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180907172720.48621-1-hangdianqj@163.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <530bb11e-30a2-6088-913a-5edee1d5d63c@kernel.dk>
Date: Fri, 7 Sep 2018 11:34:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180907172720.48621-1-hangdianqj@163.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/7/18 11:27 AM, jun qian wrote:
> As you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Looks good to me, applied.

-- 
Jens Axboe
