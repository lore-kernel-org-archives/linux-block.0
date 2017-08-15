Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] loop: fix to a race condition due to the early
 registration of device
To: Anton Volkov <avolkov@ispras.ru>, tom.leiming@gmail.com
Cc: osandov@fb.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, ldv-project@linuxtesting.org,
 khoroshilov@ispras.ru
References: <CACVXFVN-pKP5zePBvUtKkpEkOi=1fr+ePsudxbciN993BHGzNA@mail.gmail.com>
 <1502109470-2945-1-git-send-email-avolkov@ispras.ru>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1426f1f4-4193-e107-4191-251888bc0952@kernel.dk>
Date: Tue, 15 Aug 2017 12:51:05 -0600
MIME-Version: 1.0
In-Reply-To: <1502109470-2945-1-git-send-email-avolkov@ispras.ru>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/07/2017 06:37 AM, Anton Volkov wrote:
> The early device registration made possible a race leading to allocations
> of disks with wrong minors.
> 
> This patch moves the device registration further down the loop_init
> function to make the race infeasible.
> 
> Found by Linux Driver Verification project (linuxtesting.org).

Added for 4.14, thanks.

-- 
Jens Axboe
