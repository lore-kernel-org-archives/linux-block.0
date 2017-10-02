Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:53745 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdJBNw0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 09:52:26 -0400
Date: Mon, 2 Oct 2017 06:52:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Cathy Avery <cavery@redhat.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        stable@vger.kernel.org, Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V7 6/6] SCSI: set block queue at preempt only when SCSI
 device is put into quiesce
Message-ID: <20171002135225.GF19119@infradead.org>
References: <20170930061214.10622-1-ming.lei@redhat.com>
 <20170930061214.10622-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170930061214.10622-7-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +	/*
> +	 * Simply quiesing SCSI device isn't safe, it is easy
> +	 * to use up requests because all these allocated requests
> +	 * can't be dispatched when device is put in QIUESCE.
> +	 * Then no request can be allocated and we may hang
> +	 * somewhere, such as system suspend/resume.
> +	 *
> +	 * So we set block queue in preempt only first, no new
> +	 * normal request can enter queue any more, and all pending
> +	 * requests are drained once blk_set_preempt_only()
> +	 * returns. Only RQF_PREEMPT is allowed in preempt only mode.
> +	 */
> +	blk_set_preempt_only(sdev->request_queue, true);
> +
>  	mutex_lock(&sdev->state_mutex);
>  	err = scsi_device_set_state(sdev, SDEV_QUIESCE);

Why is this not under state_mutex so that we guarantee it's atomic
vs sdev state changes?

> @@ -2964,6 +2981,8 @@ void scsi_device_resume(struct scsi_device *sdev)
>  	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0)
>  		scsi_run_queue(sdev->request_queue);
>  	mutex_unlock(&sdev->state_mutex);
> +
> +	blk_set_preempt_only(sdev->request_queue, false);

Same here.
