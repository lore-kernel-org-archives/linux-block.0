Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
Subject: Re: [PATCH v4 3/6] zram: Delete gendisk before cleaning up the
 request queue
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
 <20180223010808.25765-4-bart.vanassche@wdc.com>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <4e0ef750-3631-cefe-814a-0e92e478da09@gmail.com>
Date: Fri, 23 Feb 2018 17:51:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180223010808.25765-4-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 18/2/23 09:08, Bart Van Assche wrote:
> Remove the disk, partition and bdi sysfs attributes before cleaning up
> the request queue associated with the disk.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <ngupta@vflare.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
