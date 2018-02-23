Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
Subject: Re: [PATCH v4 1/6] block/loop: Delete gendisk before cleaning up the
 request queue
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Josef Bacik <jbacik@fb.com>, Shaohua Li <shli@fb.com>,
 Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
 <20180223010808.25765-2-bart.vanassche@wdc.com>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <1a29c99d-64cb-9884-3acd-1cd7b1f0e100@gmail.com>
Date: Fri, 23 Feb 2018 17:49:48 +0800
MIME-Version: 1.0
In-Reply-To: <20180223010808.25765-2-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 18/2/23 09:08, Bart Van Assche wrote:
> Remove the disk, partition and bdi sysfs attributes before cleaning up
> the request queue associated with the disk.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Josef Bacik <jbacik@fb.com>
> Cc: Shaohua Li <shli@fb.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Ming Lei <ming.lei@redhat.com>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
