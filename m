Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] Three minor patches for kernel v4.8
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@fb.com>
References: <25262742-283b-fc4d-30df-d6a9196c85a5@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57601E4F.8000202@kernel.dk>
Date: Tue, 14 Jun 2016 09:10:07 -0600
MIME-Version: 1.0
In-Reply-To: <25262742-283b-fc4d-30df-d6a9196c85a5@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/14/2016 09:01 AM, Bart Van Assche wrote:
> Hello Jens,
>
> The three patches in this series are what I came up with after having
> analyzed the output of building the block layer with make options W=1
> and C=2. It would be appreciated if you would consider these patches for
> inclusion in kernel v4.8. These three patches are:
>
> 0001-block-partition-generic.c-Remove-a-set-but-not-used-.patch
> 0002-block-bio-integrity.c-Add-include-blk.h.patch
> 0003-block-blk-cgroup.c-Declare-local-symbols-static.patch

Thanks Bart, looks nice'n simple. Added for 4.8.

-- 
Jens Axboe
