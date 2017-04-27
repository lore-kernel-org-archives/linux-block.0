Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57477 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932644AbdD0X3Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 19:29:16 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 5/6] mtip32xx: convert internal command issue to block IO
 path
Date: Thu, 27 Apr 2017 23:29:13 +0000
Message-ID: <1493335751.2625.19.camel@sandisk.com>
References: <1493333494-600-1-git-send-email-axboe@fb.com>
         <1493333494-600-6-git-send-email-axboe@fb.com>
In-Reply-To: <1493333494-600-6-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-04-27 at 16:51 -0600, Jens Axboe wrote:
> @@ -1114,10 +1121,16 @@ static int mtip_exec_internal_command(struct mtip=
_port *port,
>  					u32 opts,
>  					unsigned long timeout)
>  {
> -	struct mtip_cmd_sg *command_sg;
>  	DECLARE_COMPLETION_ONSTACK(wait);
>  	struct mtip_cmd *int_cmd;
>  	struct driver_data *dd =3D port->dd;
> +	struct request *rq;
> +	struct mtip_int_cmd icmd =3D {
> +		.fis_len =3D fis_len,
> +		.buffer =3D buffer,
> +		.buf_len =3D buf_len,
> +		.opts =3D opts
> +	};
>  	int rv =3D 0;
>  	unsigned long start;
> =20
> @@ -1132,6 +1145,8 @@ static int mtip_exec_internal_command(struct mtip_p=
ort *port,
>  		dbg_printk(MTIP_DRV_NAME "Unable to allocate tag for PIO cmd\n");
>  		return -EFAULT;
>  	}
> +	rq =3D blk_mq_rq_from_pdu(int_cmd);
> +	rq->end_io_data =3D &icmd;
> =20
>  	set_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
> =20
> @@ -1158,30 +1173,10 @@ static int mtip_exec_internal_command(struct mtip=
_port *port,
>  	/* Copy the command to the command table */
>  	memcpy(int_cmd->command, fis, fis_len*4);
> =20
> -	/* Populate the SG list */
> -	int_cmd->command_header->opts =3D
> -		 __force_bit2int cpu_to_le32(opts | fis_len);
> -	if (buf_len) {
> -		command_sg =3D int_cmd->command + AHCI_CMD_TBL_HDR_SZ;
> -
> -		command_sg->info =3D
> -			__force_bit2int cpu_to_le32((buf_len-1) & 0x3FFFFF);
> -		command_sg->dba	=3D
> -			__force_bit2int cpu_to_le32(buffer & 0xFFFFFFFF);
> -		command_sg->dba_upper =3D
> -			__force_bit2int cpu_to_le32((buffer >> 16) >> 16);
> -
> -		int_cmd->command_header->opts |=3D
> -			__force_bit2int cpu_to_le32((1 << 16));
> -	}
> -
> -	/* Populate the command header */
> -	int_cmd->command_header->byte_count =3D 0;
> -
>  	start =3D jiffies;
> =20
> -	/* Issue the command to the hardware */
> -	mtip_issue_non_ncq_command(port, MTIP_TAG_INTERNAL);
> +	/* insert request and run queue */
> +	blk_execute_rq_nowait(rq->q, NULL, rq, true, NULL);
> =20
>  	/* Wait for the command to complete or timeout. */
>  	rv =3D wait_for_completion_interruptible_timeout(&wait,

Hello Jens,

What will happen upon timeout? Will the=A0end_io_data pointer be dereferenc=
ed if
a timeout occurs? Can that cause the completion function to access data on =
the
stack after it has been freed?

Bart.=
