Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69980C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 21:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2956920857
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 21:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="j1k//Pfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDIV5w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:57:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42008 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfDIV5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 17:57:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so513794qtc.9
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQPBepk5nqvlyEOai9uRYFb+c0oWu0PxQUglCfJhh2w=;
        b=j1k//PfwOe5nYkJSjrjVBWpng5jrg2EwA2noUJbv8PmN9LTCdiOyiUiHRl5yLVGI0l
         giAn/gfN+vmHQY+BCMa0LwKww/GQ2GCEbRHKl0kUJa9yScpifWO/BufAHNnxozqdbLGZ
         0z1o4swNmA8yCd622hTCRO4m7aQuPDqvhSOGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQPBepk5nqvlyEOai9uRYFb+c0oWu0PxQUglCfJhh2w=;
        b=qJbLL6Ej2j5yaFqxgg0X1vU6pjJczJgFBzyl6Qrl6Y8Ews+Ucn7ehx8a3RGqAJR6eC
         le3AMmfkDGVJ4JenWesnpJU6MLNA52pEdruviiaquGroalRIOdn7DbPokCm5ND4as8n3
         IIgLVz2YddgN7edMqbXcltjx6uDT54hjHj+6qXLedNzhZpRDf/2+gm8Esnak4eOexWK+
         W5cUS89d2jCoY25Fz0TQG0DhVed9Fw+i2AblWcPbpTTeIZ+IkxMSvQvASHnUVnOICYAc
         Y9u91NUtRrqXSab2/7bmBeYCxY+he6KpCpeSIvKq2dB53i6z7Ti/B70tf8QqG9xBkbNs
         7bFA==
X-Gm-Message-State: APjAAAWoRYvsoXWDlzQ2ZLXKcNm2A/FzhCP8uhK+RBd1eI8qwRriudvP
        m06y2u1cFjCMHzwiEhNPNxePOk9zKny7hUHhux2Jtg==
X-Google-Smtp-Source: APXvYqzYlJXOIYI0rOgdyQoLvEJVVpUUn14wJUZoy09sgMTTBKnMMyI7Qvg4JRf9GYHR4koIRgck8s7v5EbRIBQFZfo=
X-Received: by 2002:a0c:b107:: with SMTP id q7mr32621798qvc.77.1554847071321;
 Tue, 09 Apr 2019 14:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <1554846371-33660-1-git-send-email-jalee@purestorage.com> <CAJX3CthodX6+G1agGR==ZTbc6J0gg55ca+ABQ7hmy3TPT+dsDw@mail.gmail.com>
In-Reply-To: <CAJX3CthodX6+G1agGR==ZTbc6J0gg55ca+ABQ7hmy3TPT+dsDw@mail.gmail.com>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Tue, 9 Apr 2019 14:57:40 -0700
Message-ID: <CAJX3CthRVzj74wQTResQQwLg73Q4N5JeP3i9-fO3B2eWd9+7Jw@mail.gmail.com>
Subject: Re: [PATCH] scsi: core: set result when the command cannot be dispatched
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This is the test results.

0. Kernel configs
Version: 5.1-rc1
Boot parameter: dm_mod.use_blk_mq=Y scsi_mod.use_blk_mq=Y

1. Normal state
: (As expected) The command succeeded

$ sg_write_same --lba=100 --xferlen=512 /dev/sg5
$

2. Immediately after bringing down the iSCSI interface at the target
: (As expected) Failed with DID_TRANSPORT_DISRUPTED after a few seconds
$ sg_write_same --lba=100 --xferlen=512 /dev/sg5
Write same: transport: Host_status=0x0e [DID_TRANSPORT_DISRUPTED]
Driver_status=0x00 [DRIVER_OK, SUGGEST_OK]

Write same(10) command failed

3. Immediately after the DID_TRANSPORT_DISRUPTED error
: (As expected) Failed with DID_NO_CONNECT after a few seconds
$ sg_write_same --lba=100 --xferlen=512 /dev/sg5
Write same: transport: Host_status=0x01 [DID_NO_CONNECT]
Driver_status=0x00 [DRIVER_OK, SUGGEST_OK]

Write same(10) command failed

4. Issued IO again
: (As expected) The command failed
$ sg_write_same --lba=100 --xferlen=512 /dev/sg5
Write same: pass through os error: No such device or address
Write same(10) command failed

Thanks,

Jaesoo Lee.

On Tue, Apr 9, 2019 at 2:53 PM Jaesoo Lee <jalee@purestorage.com> wrote:
>
> When SCSI blk-mq is enabled, there is a bug in handling errors in scsi_queue_rq.
> Specifically, the bug is not setting result field of scsi_request correctly when
> the dispatch of the command has been failed. Since the upper layer code
> including the sg_io ioctl expects to receive any error status from result field
> of scsi_request, the error is silently ignored and this could cause data
> corruptions for some applications. This commit also fixes another bug that the
> result field is not initialized when scsi_request is allocated.
>
> Signed-off-by: Jaesoo Lee <jalee@purestorage.com>
> ---
>  block/scsi_ioctl.c      | 1 +
>  drivers/scsi/scsi_lib.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index 533f4ae..f2d7979 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -723,6 +723,7 @@ void scsi_req_init(struct scsi_request *req)
>         req->cmd = req->__cmd;
>         req->cmd_len = BLK_MAX_CDB;
>         req->sense_len = 0;
> +       req->result = 0;
>  }
>  EXPORT_SYMBOL(scsi_req_init);
>
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 2018967..af1488d 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1699,6 +1699,7 @@ static blk_status_t scsi_queue_rq(struct
> blk_mq_hw_ctx *hctx,
>                         ret = BLK_STS_DEV_RESOURCE;
>                 break;
>         default:
> +               scsi_req(req)->result = DID_NO_CONNECT << 16;
>                 /*
>                  * Make sure to release all allocated ressources when
>                  * we hit an error, as we will never see this command
> --
> 2.7.4
