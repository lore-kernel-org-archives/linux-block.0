Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Mon, 12 Mar 2018 17:00:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Omar Sandoval <osandov@fb.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V4 4/4] scsi: virtio_scsi: fix IO hang caused by irq
 vector automatic affinity
Message-ID: <20180312090052.GA23903@ming.t460p>
References: <20180309033218.23042-1-ming.lei@redhat.com>
 <20180309033218.23042-5-ming.lei@redhat.com>
 <20180310101520.GC32022@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180310101520.GC32022@lst.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Sat, Mar 10, 2018 at 11:15:20AM +0100, Christoph Hellwig wrote:
> This looks generally fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> As a follow on we should probably kill virtscsi_queuecommand_single and
> thus virtscsi_host_template_single as well.
> > Given storage IO is always C/S model, there isn't such issue with SCSI_MQ(blk-mq),
> 
> What does C/S mean here?

Client–Server.

> 
> > @@ -580,10 +573,7 @@ static int virtscsi_queuecommand_single(struct Scsi_Host *sh,
> >  					struct scsi_cmnd *sc)
> >  {
> >  	struct virtio_scsi *vscsi = shost_priv(sh);
> > -	struct virtio_scsi_target_state *tgt =
> > -				scsi_target(sc->device)->hostdata;
> >  
> > -	atomic_inc(&tgt->reqs);
> >  	return virtscsi_queuecommand(vscsi, &vscsi->req_vqs[0], sc);
> >  }
> 
> >  static int virtscsi_queuecommand_multi(struct Scsi_Host *sh,
> >  				       struct scsi_cmnd *sc)
> >  {
> >  	struct virtio_scsi *vscsi = shost_priv(sh);
> > -	struct virtio_scsi_target_state *tgt =
> > -				scsi_target(sc->device)->hostdata;
> > -	struct virtio_scsi_vq *req_vq;
> > -
> > -	if (shost_use_blk_mq(sh))
> > -		req_vq = virtscsi_pick_vq_mq(vscsi, sc);
> > -	else
> > -		req_vq = virtscsi_pick_vq(vscsi, tgt);
> > +	struct virtio_scsi_vq *req_vq = virtscsi_pick_vq_mq(vscsi, sc);
> >  
> >  	return virtscsi_queuecommand(vscsi, req_vq, sc);
> 
> Given how virtscsi_pick_vq_mq works virtscsi_queuecommand_single and
> virtscsi_queuecommand_multi now have identical behavior.  That means
> virtscsi_queuecommand_single should be removed, and
> virtscsi_queuecommand_multi should be merged into virtscsi_queuecommand,

OK.

> 
> > @@ -823,6 +768,7 @@ static struct scsi_host_template virtscsi_host_template_single = {
> >  	.target_alloc = virtscsi_target_alloc,
> >  	.target_destroy = virtscsi_target_destroy,
> >  	.track_queue_depth = 1,
> > +	.force_blk_mq = 1,
> 
> This probably isn't strictly needed.  That being said with your
> change we could probably just drop virtscsi_host_template_single entirely.
> 

OK.

Thanks,
Ming
