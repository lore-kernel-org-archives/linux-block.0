Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA5C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 06:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7592083E
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 06:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDJF6X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:58:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:56172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfDJF6X (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 01:58:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B0D8AD7C;
        Wed, 10 Apr 2019 05:58:22 +0000 (UTC)
Subject: Re: [PATCHv2] scsi: core: set result when the command cannot be
 dispatched
To:     Jaesoo Lee <jalee@purestorage.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>
References: <1554854375-7708-1-git-send-email-jalee@purestorage.com>
 <CAJX3CtgE5oN=uw2rAWS8hsqkEZHCgfy5r=McFTj0rhRd490HhQ@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e0c6af34-bc98-1336-e2b8-96f746bdc16a@suse.de>
Date:   Wed, 10 Apr 2019 07:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJX3CtgE5oN=uw2rAWS8hsqkEZHCgfy5r=McFTj0rhRd490HhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/19 2:02 AM, Jaesoo Lee wrote:
> When SCSI blk-mq is enabled, there is a bug in handling errors in scsi_queue_rq.
> Specifically, the bug is not setting result field of scsi_request correctly when
> the dispatch of the command has been failed. Since the upper layer code
> including the sg_io ioctl expects to receive any error status from result field
> of scsi_request, the error is silently ignored and this could cause data
> corruptions for some applications.
> 
> Signed-off-by: Jaesoo Lee <jalee@purestorage.com>
> ---
>   drivers/scsi/scsi_lib.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 2018967..dc2550c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1699,8 +1699,12 @@ static blk_status_t scsi_queue_rq(struct
> blk_mq_hw_ctx *hctx,
>                          ret = BLK_STS_DEV_RESOURCE;
>                  break;
>          default:
> +               if (unlikely(!scsi_device_online(sdev)))
> +                       scsi_req(req)->result = DID_NO_CONNECT << 16;
> +               else
> +                       scsi_req(req)->result = DID_ERROR << 16;
>                  /*
> -                * Make sure to release all allocated ressources when
> +                * Make sure to release all allocated resources when
>                   * we hit an error, as we will never see this command
>                   * again.
>                   */
> --
> 2.7.4
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
