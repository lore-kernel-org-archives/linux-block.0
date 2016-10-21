Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] badblocks: badblocks_set/clear update unacked_exist
To: Shaohua Li <shli@fb.com>, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org
References: <39f303dcb7bdf2958b6f82a0646467dfbc8d1abd.1476999400.git.shli@fb.com>
Cc: tomasz.majchrzak@intel.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ef73bc09-433d-8c3b-d70f-3400d4624ed5@kernel.dk>
Date: Fri, 21 Oct 2016 10:15:28 -0600
MIME-Version: 1.0
In-Reply-To: <39f303dcb7bdf2958b6f82a0646467dfbc8d1abd.1476999400.git.shli@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/20/2016 03:40 PM, Shaohua Li wrote:
> When bandblocks_set acknowledges a range or badblocks_clear a range,
> it's possible all badblocks are acknowledged. We should update
> unacked_exist if this occurs.

Applied, thanks.

-- 
Jens Axboe
