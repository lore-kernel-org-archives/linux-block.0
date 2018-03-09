Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750897AbeCIHkC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Mar 2018 02:40:02 -0500
Date: Fri, 9 Mar 2018 15:39:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH V4 0/4] SCSI: fix selection of reply(hw) queue
Message-ID: <20180309073941.GC25709@ming.t460p>
References: <20180309033218.23042-1-ming.lei@redhat.com>
 <ec20753a-d12a-3393-507e-793686ba8ef9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ec20753a-d12a-3393-507e-793686ba8ef9@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 09, 2018 at 08:00:52AM +0100, Hannes Reinecke wrote:
> On 03/09/2018 04:32 AM, Ming Lei wrote:
> > Hi All,
> > 
> > The patches fixes reply queue(virt-queue on virtio-scsi) selection on hpsa,
> > megaraid_sa and virtio-scsi, and IO hang can be caused easily by this issue.
> > 
> > This issue is triggered by 84676c1f21e8 ("genirq/affinity: assign vectors
> > to all possible CPUs"). After 84676c1f21e8, it is easy to see one msix
> > vector mapped to all offline CPUs. If the reply queue is seleteced from
> > all allocated msix vectors(reply queues) in round-roin way, the selected
> > replay queue may not have any online CPU mapped, IO hang is caused.
> > 
> > Both hpsa and megaraid_sas uses host-wide tagset, we can't convert the
> > reply queue to blk_mq hw queue directly, otherwise IO performance is degraded
> > much, according to Kashyap's test, so this patchset sets up one mapping talbe
> > for selecting reply queue, and this approach has been used by mpt3sas already.
> > 
> > For virtio-scsi, the virt-queue is really hw queue wrt. blk-mq view, so
> > we introduce 'force_blk_mq' for fix this issue because: 1) virtio-blk
> > has been used for years in blk-mq mode; 2) we have discussed recently
> > that scsi_mq will be enabled at default soon. 
> > 
> > gitweb:
> > 	https://github.com/ming1/linux/tree/v4.16-rc-select-reply-queue-fix-V4
> > 
> > V4:
> > 	- splitted from previous patchset
> > 	- handle virtio-scsi by force_blk_mq
> > 
> > Ming Lei (4):
> >   scsi: hpsa: fix selection of reply queue
> >   scsi: megaraid_sas: fix selection of reply queue
> >   scsi: introduce force_blk_mq
> >   scsi: virtio_scsi: fix IO hang caused by irq vector automatic affinity
> > 
> >  drivers/scsi/hosts.c                        |  1 +
> >  drivers/scsi/hpsa.c                         | 73 +++++++++++++++++++++--------
> >  drivers/scsi/hpsa.h                         |  1 +
> >  drivers/scsi/megaraid/megaraid_sas.h        |  2 +-
> >  drivers/scsi/megaraid/megaraid_sas_base.c   | 34 +++++++++++++-
> >  drivers/scsi/megaraid/megaraid_sas_fusion.c | 12 ++---
> >  drivers/scsi/virtio_scsi.c                  | 59 ++---------------------
> >  include/scsi/scsi_host.h                    |  3 ++
> >  8 files changed, 100 insertions(+), 85 deletions(-)
> > 
> Well ... while this looks good in principle, what happens on cpu hotplug?
> Don't we have to redo the map then?

Each item in the table is used to for mapping one CPU id to the hw queue index,
and the size of the table is 'nr_cpu_id', so no need to redo the map on cpu hotplug,
just like the usage of set->mq_map in blk-mq.

Thank,
Ming
