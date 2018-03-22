Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] mmc: block: Delete gendisk before cleaning up the request
 queue
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
References: <1521716176-20731-1-git-send-email-shawn.lin@rock-chips.com>
 <1521737959.2637.7.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <56cad842-1236-ce35-78a4-599d9c956470@kernel.dk>
Date: Thu, 22 Mar 2018 11:05:03 -0600
MIME-Version: 1.0
In-Reply-To: <1521737959.2637.7.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/22/18 10:59 AM, Bart Van Assche wrote:
> On Thu, 2018-03-22 at 18:56 +0800, Shawn Lin wrote:
>> dd if=/dev/urandom of=/dev/mmcblk1 bs=4k count=10000
>> with a SD card hotplug during transfer reports a warning below
>> introduced by commit a063057d7c73 ("block: Fix a race between
>> request queue removal and the block cgroup controller"). So we
>> should now remove the disk, partition and bdi sysfs attributes
>> before cleaning up the request queue associated with the disk.
> 
> Since del_gendisk() may submit I/O calling blk_cleanup_queue() before
> del_gendisk() has never been safe so this requirement is not really new.
> Anyway, thanks for this patch.

Indeed, it has always been so. In any case, patch does look good,
applied.


-- 
Jens Axboe
