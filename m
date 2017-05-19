Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blktrace: fix integer parse
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
Cc: Kernel-team@fb.com
References: <3ceaaf95edea4e3f506f1e458323ceef5886f955.1495169957.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <817759b0-a412-e603-3413-cec09d7a88b5@kernel.dk>
Date: Fri, 19 May 2017 09:21:42 -0600
MIME-Version: 1.0
In-Reply-To: <3ceaaf95edea4e3f506f1e458323ceef5886f955.1495169957.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/19/2017 09:04 AM, Shaohua Li wrote:
> sscanf is a very poor way to parse integer. For example, I input
> "discard" for act_mask, it gets 0xd and completely messes up. Using
> correct API to do integer parse.
> 
> This patch also makes attributes accept any base of integer.

Thanks Shaohua, applied.

-- 
Jens Axboe
