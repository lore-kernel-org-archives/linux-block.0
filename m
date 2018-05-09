Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] brd: Mark as non-rotational
To: SeongJae Park <sj38.park@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180503095326.7414-1-sj38.park@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4da307ac-77c5-1eed-434c-005c97f9a308@kernel.dk>
Date: Wed, 9 May 2018 08:44:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180503095326.7414-1-sj38.park@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/3/18 3:53 AM, SeongJae Park wrote:
> This commit sets QUEUE_FLAG_NONROT and clears up QUEUE_FLAG_ADD_RANDOM
> to mark the ramdisks as non-rotational device.

Applied for 4.18, thanks.

-- 
Jens Axboe
