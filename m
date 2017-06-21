Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 04/12] block: Make most scsi_req_init() calls implicit
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Nicholas Bellinger <nab@linux-iscsi.org>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
 <20170620181549.24903-5-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f6651e1c-35fb-b46e-b270-66c98303a4b5@suse.de>
Date: Wed, 21 Jun 2017 08:54:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170620181549.24903-5-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 08:15 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Instead of explicitly calling scsi_req_init() after blk_get_request(),
> call that function from inside blk_get_request(). Add an
> .initialize_rq_fn() callback function to the block drivers that need
> it. Merge the IDE .init_rq_fn() function into .initialize_rq_fn()
> because it is too small to keep it as a separate function. Keep the
> scsi_req_init() call in ide_prep_sense() because it follows a
> blk_rq_init() call.
> 
> References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Nicholas Bellinger <nab@linux-iscsi.org>
> ---
>  block/bsg.c                        |  1 -
>  block/scsi_ioctl.c                 |  3 ---
>  drivers/block/pktcdvd.c            |  1 -
>  drivers/cdrom/cdrom.c              |  1 -
>  drivers/ide/ide-atapi.c            |  1 -
>  drivers/ide/ide-cd.c               |  1 -
>  drivers/ide/ide-cd_ioctl.c         |  1 -
>  drivers/ide/ide-devsets.c          |  1 -
>  drivers/ide/ide-disk.c             |  1 -
>  drivers/ide/ide-ioctls.c           |  2 --
>  drivers/ide/ide-park.c             |  2 --
>  drivers/ide/ide-pm.c               |  2 --
>  drivers/ide/ide-probe.c            |  6 +++---
>  drivers/ide/ide-tape.c             |  1 -
>  drivers/ide/ide-taskfile.c         |  1 -
>  drivers/scsi/osd/osd_initiator.c   |  2 --
>  drivers/scsi/osst.c                |  1 -
>  drivers/scsi/scsi_error.c          |  1 -
>  drivers/scsi/scsi_lib.c            | 15 ++++++++++++++-
>  drivers/scsi/scsi_transport_sas.c  |  2 ++
>  drivers/scsi/sg.c                  |  2 --
>  drivers/scsi/st.c                  |  1 -
>  drivers/target/target_core_pscsi.c |  2 --
>  fs/nfsd/blocklayout.c              |  1 -
>  include/scsi/scsi_cmnd.h           |  1 +
>  25 files changed, 20 insertions(+), 33 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
