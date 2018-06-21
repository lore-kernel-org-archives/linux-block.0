Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: Add the nbd NBD_DISCONNECT_ON_CLOSE config flag.
To: Doron Roberts-Kedes <doronrk@fb.com>, linux-block@vger.kernel.org
Cc: josef@toxicpanda.com
References: <20180615210532.499516-1-doronrk@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2af87ca7-5caa-f1c4-095d-6293ea6ad972@kernel.dk>
Date: Wed, 20 Jun 2018 19:12:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180615210532.499516-1-doronrk@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/15/18 3:05 PM, Doron Roberts-Kedes wrote:
> If NBD_DISCONNECT_ON_CLOSE is set on a device, then the driver will
> issue a disconnect from nbd_release if the device has no remaining
> bdev->bd_openers.
> 
> Fix ret val so reconfigure with only setting the flag succeeds.

Applied, thanks.

-- 
Jens Axboe
