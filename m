Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] mg_disk: fix error path in mg_probe()
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <1467121361-21632-1-git-send-email-b.zolnierkie@samsung.com>
Cc: unsik Kim <donari75@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5772AD7E.1020006@kernel.dk>
Date: Tue, 28 Jun 2016 11:01:50 -0600
MIME-Version: 1.0
In-Reply-To: <1467121361-21632-1-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/28/2016 07:42 AM, Bartlomiej Zolnierkiewicz wrote:
> MG_DISK_MAJ is defined as 0 so dynamic block major number
> allocation is used by the driver and the assigned major
> number is stored in host->major.  This patch fixes error
> path in mg_probe() to use host->major instead of using
> MG_DISK_MAJ.

Added, thanks Bart.

-- 
Jens Axboe
