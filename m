Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] sbitmap: initialize weight to zero
To: Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
References: <20160919133408.25559-1-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cab7d4ae-3079-7add-d72b-1bdecf57e13d@kernel.dk>
Date: Mon, 19 Sep 2016 08:20:45 -0600
MIME-Version: 1.0
In-Reply-To: <20160919133408.25559-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/19/2016 07:34 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable weight is not being initialized to zero before it is
> used to compute the weight sum. Ensure it is initialized to zero.
>
> Found with static analysis with cppcheck:
> [lib/sbitmap.c:177]: (error) Uninitialized variable: weight

Thanks, applied. Strange, this is an old issue, it was just moved to 
this file. It should have triggered on mainline too. My compiler doesn't 
complain here:

$ gcc --version
gcc (Ubuntu 6.2.0-3ubuntu11~16.04) 6.2.0 20160901

-- 
Jens Axboe
