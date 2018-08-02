Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block/compat_ioctl: fix range check in BLKGETSIZE
To: Khazhismel Kumykov <khazhy@google.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180406222350.174104-1-khazhy@google.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e40fc93d-ddb1-23a5-725c-e8ab613168cb@kernel.dk>
Date: Thu, 2 Aug 2018 15:31:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180406222350.174104-1-khazhy@google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/6/18 4:23 PM, Khazhismel Kumykov wrote:
> kernel ulong and compat_ulong_t may not be same width. Use type directly
> to eliminate mismatches.
> 
> This would result in truncation rather than EFBIG for 32bit mode for
> large disks.

Sorry for not getting to this. Applied, thanks.

-- 
Jens Axboe
