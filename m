Return-Path: <BATV+de86e71b538cb4077339+5140+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 19 Sep 2017 09:01:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Meng Xu <mengxu.gatech@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, meng.xu@gatech.edu,
	sanidhya@gatech.edu, taesoo@gatech.edu
Subject: Re: [PATCH] scsi: ensure the header peeked does not change in the
 actual message
Message-ID: <20170919160102.GA17416@infradead.org>
References: <1505834638-37142-1-git-send-email-mengxu.gatech@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505834638-37142-1-git-send-email-mengxu.gatech@gmail.com>
List-ID: <linux-block@vger.kernel.org>

> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index 7440de4..971044d 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -466,6 +466,12 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
>  	if (copy_from_user(req->cmd, sic->data, cmdlen))
>  		goto error;
>  
> +	/*
> +	 * override the request header (opcode) to make sure that it matches
> +	 * the first fetch from sic->data 
> +	 */
> +	*((unsigned int *)req->cmd) = opcode;
> +
>  	if (in_len && copy_from_user(buffer, sic->data + cmdlen, in_len))

NAK.

Just don't copy the byte twice.  E.g. change things to not copy
the first byte again.
