Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v2 4/5] block, scsi: Rework runtime power management
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Alan Stern <stern@rowland.harvard.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
 <20180725222607.8854-5-bart.vanassche@wdc.com>
 <0fe202dd-32a6-4bd1-43dd-440511ad52e4@oracle.com>
 <f9c2402d-3150-d286-ae9c-31cc17865b93@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <02cb3a83-bba0-2f8d-1e4d-019447db3b36@oracle.com>
Date: Thu, 26 Jul 2018 16:44:21 +0800
MIME-Version: 1.0
In-Reply-To: <f9c2402d-3150-d286-ae9c-31cc17865b93@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 07/26/2018 03:52 PM, jianchao.wang wrote:
> In addition, .runtime_suspend is invoked under spinlock and irq-disabled.
> So sleep is forbidden here.
> Please refer to rpm_suspend
> 
> * This function must be called under dev->power.lock with interrupts disabled
> 
__rpm_callback will unlock the spinlock before invoke the callback.
Sorry for the noise.

Thanks
Jianchao
