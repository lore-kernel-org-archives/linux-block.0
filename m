Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43299 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbeCIHA4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Mar 2018 02:00:56 -0500
Subject: Re: [PATCH V4 0/4] SCSI: fix selection of reply(hw) queue
To: Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
References: <20180309033218.23042-1-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ec20753a-d12a-3393-507e-793686ba8ef9@suse.de>
Date: Fri, 9 Mar 2018 08:00:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180309033218.23042-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/09/2018 04:32 AM, Ming Lei wrote:
> Hi All,
> 
> The patches fixes reply queue(virt-queue on virtio-scsi) selection on hpsa,
> megaraid_sa and virtio-scsi, and IO hang can be caused easily by this issue.
> 
> This issue is triggered by 84676c1f21e8 ("genirq/affinity: assign vectors
> to all possible CPUs"). After 84676c1f21e8, it is easy to see one msix
> vector mapped to all offline CPUs. If the reply queue is seleteced from
> all allocated msix vectors(reply queues) in round-roin way, the selected
> replay queue may not have any online CPU mapped, IO hang is caused.
> 
> Both hpsa and megaraid_sas uses host-wide tagset, we can't convert the
> reply queue to blk_mq hw queue directly, otherwise IO performance is degraded
> much, according to Kashyap's test, so this patchset sets up one mapping talbe
> for selecting reply queue, and this approach has been used by mpt3sas already.
> 
> For virtio-scsi, the virt-queue is really hw queue wrt. blk-mq view, so
> we introduce 'force_blk_mq' for fix this issue because: 1) virtio-blk
> has been used for years in blk-mq mode; 2) we have discussed recently
> that scsi_mq will be enabled at default soon. 
> 
> gitweb:
> 	https://github.com/ming1/linux/tree/v4.16-rc-select-reply-queue-fix-V4
> 
> V4:
> 	- splitted from previous patchset
> 	- handle virtio-scsi by force_blk_mq
> 
> Ming Lei (4):
>   scsi: hpsa: fix selection of reply queue
>   scsi: megaraid_sas: fix selection of reply queue
>   scsi: introduce force_blk_mq
>   scsi: virtio_scsi: fix IO hang caused by irq vector automatic affinity
> 
>  drivers/scsi/hosts.c                        |  1 +
>  drivers/scsi/hpsa.c                         | 73 +++++++++++++++++++++--------
>  drivers/scsi/hpsa.h                         |  1 +
>  drivers/scsi/megaraid/megaraid_sas.h        |  2 +-
>  drivers/scsi/megaraid/megaraid_sas_base.c   | 34 +++++++++++++-
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 12 ++---
>  drivers/scsi/virtio_scsi.c                  | 59 ++---------------------
>  include/scsi/scsi_host.h                    |  3 ++
>  8 files changed, 100 insertions(+), 85 deletions(-)
> 
Well ... while this looks good in principle, what happens on cpu hotplug?
Don't we have to redo the map then?

Cheers,

Hannes

-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
