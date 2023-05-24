Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEBAC77B73
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 20:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjEXUum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXUul (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 16:50:41 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CE8180
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 13:50:40 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 03F76762D4;
        Wed, 24 May 2023 20:50:39 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id E2C7860507;
        Wed, 24 May 2023 20:50:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id gzE_DctWgSDQ; Wed, 24 May 2023 20:50:38 +0000 (UTC)
Received: from [192.168.48.17] (host-192.252-165-26.dyn.295.ca [192.252.165.26])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id B3F1B60316;
        Wed, 24 May 2023 20:50:36 +0000 (UTC)
Message-ID: <d1c373e0-b27f-8e70-9c6b-2d131bf6b62e@interlog.com>
Date:   Wed, 24 May 2023 16:50:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v5 8/9] scsi_debug: Support configuring the maximum
 segment size
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jyescas@google.com, mcgrof@kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230522222554.525229-1-bvanassche@acm.org>
 <20230522222554.525229-9-bvanassche@acm.org>
Content-Language: en-CA
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230522222554.525229-9-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023-05-22 18:25, Bart Van Assche wrote:
> Add a kernel module parameter for configuring the maximum segment size.
> This patch enables testing SCSI support for segments smaller than the
> page size.
> 
> Cc: Doug Gilbert <dgilbert@interlog.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Acked-by: Douglas Gilbert <dgilbert@interlog.com>

> ---
>   drivers/scsi/scsi_debug.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 8c58128ad32a..e951c622bf64 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -752,6 +752,7 @@ static int sdebug_host_max_queue;	/* per host */
>   static int sdebug_lowest_aligned = DEF_LOWEST_ALIGNED;
>   static int sdebug_max_luns = DEF_MAX_LUNS;
>   static int sdebug_max_queue = SDEBUG_CANQUEUE;	/* per submit queue */
> +static unsigned int sdebug_max_segment_size = BLK_MAX_SEGMENT_SIZE;
>   static unsigned int sdebug_medium_error_start = OPT_MEDIUM_ERR_ADDR;
>   static int sdebug_medium_error_count = OPT_MEDIUM_ERR_NUM;
>   static int sdebug_ndelay = DEF_NDELAY;	/* if > 0 then unit is nanoseconds */
> @@ -5735,6 +5736,7 @@ module_param_named(lowest_aligned, sdebug_lowest_aligned, int, S_IRUGO);
>   module_param_named(lun_format, sdebug_lun_am_i, int, S_IRUGO | S_IWUSR);
>   module_param_named(max_luns, sdebug_max_luns, int, S_IRUGO | S_IWUSR);
>   module_param_named(max_queue, sdebug_max_queue, int, S_IRUGO | S_IWUSR);
> +module_param_named(max_segment_size, sdebug_max_segment_size, uint, S_IRUGO);
>   module_param_named(medium_error_count, sdebug_medium_error_count, int,
>   		   S_IRUGO | S_IWUSR);
>   module_param_named(medium_error_start, sdebug_medium_error_start, int,
> @@ -5811,6 +5813,7 @@ MODULE_PARM_DESC(lowest_aligned, "lowest aligned lba (def=0)");
>   MODULE_PARM_DESC(lun_format, "LUN format: 0->peripheral (def); 1 --> flat address method");
>   MODULE_PARM_DESC(max_luns, "number of LUNs per target to simulate(def=1)");
>   MODULE_PARM_DESC(max_queue, "max number of queued commands (1 to max(def))");
> +MODULE_PARM_DESC(max_segment_size, "max bytes in a single segment");
>   MODULE_PARM_DESC(medium_error_count, "count of sectors to return follow on MEDIUM error");
>   MODULE_PARM_DESC(medium_error_start, "starting sector number to return MEDIUM error");
>   MODULE_PARM_DESC(ndelay, "response delay in nanoseconds (def=0 -> ignore)");
> @@ -7723,6 +7726,7 @@ static int sdebug_driver_probe(struct device *dev)
>   
>   	sdebug_driver_template.can_queue = sdebug_max_queue;
>   	sdebug_driver_template.cmd_per_lun = sdebug_max_queue;
> +	sdebug_driver_template.max_segment_size = sdebug_max_segment_size;
>   	if (!sdebug_clustering)
>   		sdebug_driver_template.dma_boundary = PAGE_SIZE - 1;
>   

