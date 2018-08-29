Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Scott Bauer <scott.bauer@intel.com>
Cc: hch@infradead.org, linux-block@vger.kernel.org,
 Scott Bauer <sbauer@plzdonthack.me>, stable@vger.kernel.org
References: <20180426175108.29280-1-scott.bauer@intel.com>
 <20180829124842.plpsjdvausmtikhj@mwanda>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <46b669b9-e31f-54a6-dcd6-10e5b7f30406@kernel.dk>
Date: Wed, 29 Aug 2018 08:09:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180829124842.plpsjdvausmtikhj@mwanda>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/29/18 6:48 AM, Dan Carpenter wrote:
> Sorry, I responded to this patch that this wasn't a real bug, but then
> Scott corrected me that it was.
> 
> Anyway, it is a bug and we haven't applied this patch yet.

It is now, apparently I lost track of it too. Thanks Scott.

-- 
Jens Axboe
