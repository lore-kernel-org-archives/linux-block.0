Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH][v2] blk-iolatency: fix max_depth comparisons
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <20180711143442.16566-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <34d655c9-f48b-ae57-b143-a5d510eb4c9d@kernel.dk>
Date: Wed, 11 Jul 2018 08:39:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180711143442.16566-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/11/18 8:34 AM, Josef Bacik wrote:
> max_depth used to be a u64, but I changed it to a unsigned int but
> didn't convert my comparisons over everywhere.  Fix by using UINT_MAX
> everywhere instead of (u64)-1.

Thanks Josef, applied for 4.19.

-- 
Jens Axboe
