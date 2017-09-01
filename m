Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V3 0/2] block/loop: improve performance
To: Shaohua Li <shli@kernel.org>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Shaohua Li <shli@fb.com>
References: <cover.1504240556.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6e28f456-b335-4392-2cf4-e2c05406c502@kernel.dk>
Date: Fri, 1 Sep 2017 08:44:58 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1504240556.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/31/2017 11:09 PM, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> two small patches to improve performance for loop in directio mode. The goal is
> to increase IO size sending to underlayer disks.

Applied for 4.14, thanks.

-- 
Jens Axboe
