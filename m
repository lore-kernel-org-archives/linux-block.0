Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v6 10/12] block: Change the runtime power management
 approach (1/2)
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
 <20180809194149.15285-11-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b09a092b-da49-c071-c79a-63c3d1cde494@oracle.com>
Date: Fri, 10 Aug 2018 09:59:36 +0800
MIME-Version: 1.0
In-Reply-To: <20180809194149.15285-11-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 08/10/2018 03:41 AM, Bart Van Assche wrote:
> Instead of scheduling runtime resume of a request queue after a
> request has been queued, schedule asynchronous resume during request
> allocation. The new pm_request_resume() calls occur after
> blk_queue_enter() has increased the q_usage_counter request queue
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> member. This change is needed for a later patch that will make request
> allocation block while the queue status is not RPM_ACTIVE.

Is it "after getting q->q_usage_counter fails" ?
And also this blk_pm_request_resume  will not affect the normal path. ;)

Thanks
Jianchao
