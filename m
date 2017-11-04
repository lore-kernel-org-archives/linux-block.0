Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] SCSI: don't get target/host busy_count in
 scsi_mq_get_budget()
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
 Laurence Oberman <loberman@redhat.com>, linux-scsi@vger.kernel.org,
 Omar Sandoval <osandov@fb.com>, John Garry <john.garry@huawei.com>
References: <20171104015534.32684-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <adb7f6bd-bf0d-8176-808b-32a84ac4273a@kernel.dk>
Date: Sat, 4 Nov 2017 08:19:58 -0600
MIME-Version: 1.0
In-Reply-To: <20171104015534.32684-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/03/2017 07:55 PM, Ming Lei wrote:
> It is very expensive to atomic_inc/atomic_dec the host wide counter of
> host->busy_count, and it should have been avoided via blk-mq's mechanism
> of getting driver tag, which uses the more efficient way of sbitmap queue.
> 
> Also we don't check atomic_read(&sdev->device_busy) in scsi_mq_get_budget()
> and don't run queue if the counter becomes zero, so IO hang may be caused
> if all requests are completed just before the current SCSI device
> is added to shost->starved_list.

This looks like an improvement. I have added it for 4.15.

Bart, does this fix your hang?

-- 
Jens Axboe
