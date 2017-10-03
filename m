Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11581 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdJCIRN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Oct 2017 04:17:13 -0400
Date: Tue, 3 Oct 2017 16:17:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
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
Message-ID: <20171003081702.GB23564@ming.t460p>
References: <20170930061214.10622-1-ming.lei@redhat.com>
 <20170930061214.10622-7-ming.lei@redhat.com>
 <20171002135225.GF19119@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002135225.GF19119@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 02, 2017 at 06:52:25AM -0700, Christoph Hellwig wrote:
> > +	/*
> > +	 * Simply quiesing SCSI device isn't safe, it is easy
> > +	 * to use up requests because all these allocated requests
> > +	 * can't be dispatched when device is put in QIUESCE.
> > +	 * Then no request can be allocated and we may hang
> > +	 * somewhere, such as system suspend/resume.
> > +	 *
> > +	 * So we set block queue in preempt only first, no new
> > +	 * normal request can enter queue any more, and all pending
> > +	 * requests are drained once blk_set_preempt_only()
> > +	 * returns. Only RQF_PREEMPT is allowed in preempt only mode.
> > +	 */
> > +	blk_set_preempt_only(sdev->request_queue, true);
> > +
> >  	mutex_lock(&sdev->state_mutex);
> >  	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
> 
> Why is this not under state_mutex so that we guarantee it's atomic
> vs sdev state changes?

It isn't necessary since what we want is to make sure only RQF_PREEMPT
is allowed once blk_set_preempt_only() returns, and putting a lock
before freezing queue might risk to deadlock.

-- 
Ming
