Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933409AbeD1I1I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Apr 2018 04:27:08 -0400
Date: Sat, 28 Apr 2018 16:26:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@fb.com" <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "don.brace@microsemi.com" <don.brace@microsemi.com>,
        "james.bottomley@hansenpartnership.com"
        <james.bottomley@hansenpartnership.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>
Subject: Re: [PATCH 3/3] scsi: avoid to hold host-wide counter of host_busy
 for scsi_mq
Message-ID: <20180428082638.GB7325@ming.t460p>
References: <20180420065742.8043-1-ming.lei@redhat.com>
 <20180420065742.8043-4-ming.lei@redhat.com>
 <cf84baf9bd61fd1a3ab34aa956d496d164aef44f.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cf84baf9bd61fd1a3ab34aa956d496d164aef44f.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 27, 2018 at 04:16:48PM +0000, Bart Van Assche wrote:
> On Fri, 2018-04-20 at 14:57 +0800, Ming Lei wrote:
> > +struct scsi_host_mq_in_flight {
> > +	int cnt;
> > +};
> > +
> > +static void scsi_host_check_in_flight(struct request *rq, void *data,
> > +		bool reserved)
> > +{
> > +	struct scsi_host_mq_in_flight *in_flight = data;
> > +
> > +	if (blk_mq_request_started(rq))
> > +		in_flight->cnt++;
> > +}
> > +
> >  /**
> >   * scsi_host_busy - Return the host busy counter
> >   * @shost:	Pointer to Scsi_Host to inc.
> >   **/
> >  int scsi_host_busy(struct Scsi_Host *shost)
> >  {
> > -	return atomic_read(&shost->host_busy);
> > +	struct scsi_host_mq_in_flight in_flight = {
> > +		.cnt = 0,
> > +	};
> > +
> > +	if (!shost->use_blk_mq)
> > +		return atomic_read(&shost->host_busy);
> > +
> > +	blk_mq_tagset_busy_iter(&shost->tag_set, scsi_host_check_in_flight,
> > +			&in_flight);
> > +	return in_flight.cnt;
> >  }
> >  EXPORT_SYMBOL(scsi_host_busy);
> 
> This patch introduces a subtle behavior change that has not been explained
> in the commit message. If a SCSI request gets requeued that results in a
> decrease of the .host_busy counter by scsi_device_unbusy() before the request
> is requeued and an increase of the host_busy counter when scsi_queue_rq() is
> called again. During that time such requests have the state MQ_RQ_COMPLETE and
> hence blk_mq_request_started() will return true and scsi_host_check_in_flight()

No, __blk_mq_requeue_request() will change the rq state into MQ_RQ_IDLE,
so such issue you worried about, please look at scsi_mq_requeue_cmd(),
which calls blk_mq_requeue_request(), which puts driver tag and updates
rq's state to IDLE.

> will include these requests. In other words, this patch introduces a subtle
> behavior change that has not been explained in the commit message. Hence I'm
> doubt that this change is correct.

As I explained above, no such issue.


Thanks,
Ming
