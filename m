Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "roger.pau@citrix.com"
	<roger.pau@citrix.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "jbacik@fb.com" <jbacik@fb.com>,
	"james.smart@broadcom.com" <james.smart@broadcom.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>
Subject: Re: [PATCH 02/25] block: remove the blk_execute_rq return value
Date: Thu, 13 Apr 2017 20:03:22 +0000
Message-ID: <1492113800.24345.9.camel@sandisk.com>
References: <20170406153944.10058-1-hch@lst.de>
	 <20170406153944.10058-3-hch@lst.de>
In-Reply-To: <20170406153944.10058-3-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-04-06 at 17:39 +0200, Christoph Hellwig wrote:
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 92b4b41d19d2..4b72fdf67548 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -242,8 +242,8 @@ static int nfsd4_scsi_identify_device(struct block_de=
vice *bdev,
>  	req->cmd[4] =3D bufflen & 0xff;
>  	req->cmd_len =3D COMMAND_SIZE(INQUIRY);
> =20
> -	error =3D blk_execute_rq(rq->q, NULL, rq, 1);
> -	if (error) {
> +	blk_execute_rq(rq->q, NULL, rq, 1);
> +	if (rq->errors) {
>  		pr_err("pNFS: INQUIRY 0x83 failed with: %x\n",
>  			rq->errors);
>  		goto out_put_request;

Hello Christoph,

That blk_execute_rq() call can only be reached if a few lines above 0 was
assigned to the "error" variable. Since nfsd4_scsi_identify_device() return=
s
the value of the "error" variable I think -EIO should be assigned to that
variable before the "goto out_put_request" statement is reached.

Bart.=
