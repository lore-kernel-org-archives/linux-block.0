Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
Subject: Re: [PATCH v4 2/6] md: Delete gendisk before cleaning up the request
 queue
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Shaohua Li <shli@kernel.org>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
 <20180223010808.25765-3-bart.vanassche@wdc.com>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <4b0e5408-de2f-54fd-d41e-5c2186d88bd3@gmail.com>
Date: Fri, 23 Feb 2018 17:50:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180223010808.25765-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 18/2/23 09:08, Bart Van Assche wrote:
> Remove the disk, partition and bdi sysfs attributes before cleaning up
> the request queue associated with the disk.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Shaohua Li <shli@kernel.org>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
