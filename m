Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v4 07/10] block, scsi: Rework runtime power management
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Alan Stern <stern@rowland.harvard.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
 <20180804000325.3610-8-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c92dffc6-c7e6-c040-00db-6f42e51618fb@oracle.com>
Date: Mon, 6 Aug 2018 10:46:38 +0800
MIME-Version: 1.0
In-Reply-To: <20180804000325.3610-8-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 08/04/2018 08:03 AM, Bart Van Assche wrote:
> Instead of allowing requests that are not power management requests
> to enter the queue in runtime suspended status (RPM_SUSPENDED), make
> the blk_get_request() caller block. 

Who will resume the runtime suspended device ?

In original blk-legacy, when a request is added, blk_pm_add_request will call
pm_request_resume could do that. The request will be issued after the q is resumed
successfully.

After this patch, non-pm request will be blocked and pm_request_resume is removed from
blk_pm_add_request, who does resume the runtime suspended q and device ?

Thanks
Jianchao
