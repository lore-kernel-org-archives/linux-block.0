Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix a type conversion error in __get_request()
To: Wei Fang <fangwei1@huawei.com>
References: <1467637420-4967-1-git-send-email-fangwei1@huawei.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <577BEF75.7010208@kernel.dk>
Date: Tue, 5 Jul 2016 11:33:41 -0600
MIME-Version: 1.0
In-Reply-To: <1467637420-4967-1-git-send-email-fangwei1@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/04/2016 07:03 AM, Wei Fang wrote:
> Theoretically, request only flags in enum rq_flag_bits can bigger
> than 31 after we add some new flags in the future, so we can't
> store REQ_IO_STAT in op_flags which is a int type in __get_request().
> Actually, when REQ_IO_STAT become 31, the most-significant bit of
> op_flags will be 1, and OR it to ->cmd_flags will cause the top 32
> bits of ->cmd_flags become 1.
>
> Fix it by using a u64-type object to store flags.

Why not change op_flags to a 64-bit type, if the flags are already 
overflowing?

Either that, or we need a BUILD_BUG_ON() for the flags not being > 32 bit.

-- 
Jens Axboe
