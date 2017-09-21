Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix a crash caused by wrong API
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
Cc: Kernel-team@fb.com, Bart Van Assche <bart.vanassche@wdc.com>,
 Omar Sandoval <osandov@fb.com>
References: <bbf02e9095a5e8d5d71c7001881aa6d5c765bda2.1506021255.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6dce7f4a-5837-8bd7-a5a5-e2564dc8ac52@kernel.dk>
Date: Thu, 21 Sep 2017 13:19:24 -0600
MIME-Version: 1.0
In-Reply-To: <bbf02e9095a5e8d5d71c7001881aa6d5c765bda2.1506021255.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/21/2017 01:17 PM, Shaohua Li wrote:
> part_stat_show takes a part device not a disk, so we should use
> part_to_disk.

Oops, thanks Shaohua! Applied.

-- 
Jens Axboe
