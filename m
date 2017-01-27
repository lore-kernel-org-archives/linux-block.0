Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 15/18] scsi: allocate scsi_cmnd structures as part of
 struct request
Date: Fri, 27 Jan 2017 18:39:46 +0000
Message-ID: <1485542367.4267.19.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
         <1485365126-23210-16-git-send-email-hch@lst.de>
In-Reply-To: <1485365126-23210-16-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-01-25 at 18:25 +0100, Christoph Hellwig wrote:
> -unsigned char *scsi_alloc_sense_buffer(struct Scsi_Host *shost, gfp_t gf=
p_mask,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int numa_node)
> +static unsigned char *scsi_alloc_sense_buffer(struct Scsi_Host *shost,
> +=A0=A0=A0=A0=A0=A0=A0gfp_t gfp_mask, int numa_node)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0return kmem_cache_alloc_node(scsi_select_sense_ca=
che(shost), gfp_mask,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0n=
uma_node);
> @@ -697,14 +696,13 @@ static bool scsi_end_request(struct request *req, i=
nt error,
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (bidi_bytes)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0s=
csi_release_bidi_buffers(cmd);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_release_buffers(cmd);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_put_command(cmd);
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spin_lock_irqsave(q->queu=
e_lock, flags);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0blk_finish_request(req, e=
rror);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spin_unlock_irqrestore(q-=
>queue_lock, flags);
> =A0
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_release_buffers(cmd);
> -
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_put_command(cmd);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_run_queue(q);
> =A0=A0=A0=A0=A0=A0=A0=A0}

Hello Christoph,

Why=A0have the=A0scsi_release_buffers() and scsi_put_command(cmd) calls bee=
n
moved up? I haven't found an explanation for this change in the patch
description.

Please also consider to remove the cmd->request->special =3D NULL assignmen=
ts
via this patch. Since this patch makes the lifetime of struct scsi_cmnd and
struct request identical these assignments are no longer needed.

This patch introduces the function scsi_exit_rq(). Having two functions
for the single-queue path that release resources (scsi_release_buffers()
and scsi_exit_rq()) is confusing. Since every scsi_release_buffers() call
is followed by a blk_unprep_request() call, have you considered to move
the scsi_release_buffers() call into scsi_unprep_fn() via an additional
patch?

Thanks,

Bart.
