Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A543FC001DE
	for <linux-block@archiver.kernel.org>; Mon,  7 Aug 2023 18:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjHGSTH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHGSTG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Aug 2023 14:19:06 -0400
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Aug 2023 11:19:03 PDT
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ADD8F
        for <linux-block@vger.kernel.org>; Mon,  7 Aug 2023 11:19:03 -0700 (PDT)
Received: from mailpool-fe-01.fibernetics.ca (mailpool-fe-01.fibernetics.ca [208.85.217.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id D915C75CEF;
        Mon,  7 Aug 2023 18:13:56 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-01.fibernetics.ca (Postfix) with ESMTP id CCED33EBBA;
        Mon,  7 Aug 2023 18:13:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mailpool-fe-01.fibernetics.ca ([208.85.217.144])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id IGvPir2wpeRp; Mon,  7 Aug 2023 18:13:51 +0000 (UTC)
Received: from [192.168.48.17] (host-192.252-165-26.dyn.295.ca [192.252.165.26])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 9DF303EBB6;
        Mon,  7 Aug 2023 18:13:50 +0000 (UTC)
Message-ID: <662fab49-2493-a86b-1683-a33b858e2e85@interlog.com>
Date:   Mon, 7 Aug 2023 14:13:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v5 4/7] scsi: scsi_debug: Support disabling zone write
 locking
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230731221458.437440-1-bvanassche@acm.org>
 <20230731221458.437440-5-bvanassche@acm.org>
Content-Language: en-CA
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230731221458.437440-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023-07-31 18:14, Bart Van Assche wrote:
> Make it easier to test handling of QUEUE_FLAG_NO_ZONE_WRITE_LOCK by
> adding support for setting this flag for scsi_debug request queues.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Douglas Gilbert <dgilbert@interlog.com>

Thanks.

> ---
>   drivers/scsi/scsi_debug.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 9c0af50501f9..57c6242bfb26 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -832,6 +832,7 @@ static int dix_reads;
>   static int dif_errors;
>   
>   /* ZBC global data */
> +static bool sdeb_no_zwrl;
>   static bool sdeb_zbc_in_use;	/* true for host-aware and host-managed disks */
>   static int sdeb_zbc_zone_cap_mb;
>   static int sdeb_zbc_zone_size_mb;
> @@ -5138,9 +5139,13 @@ static struct sdebug_dev_info *find_build_dev_info(struct scsi_device *sdev)
>   
>   static int scsi_debug_slave_alloc(struct scsi_device *sdp)
>   {
> +	struct request_queue *q = sdp->request_queue;
> +
>   	if (sdebug_verbose)
>   		pr_info("slave_alloc <%u %u %u %llu>\n",
>   		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
> +	if (sdeb_no_zwrl)
> +		blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
>   	return 0;
>   }
>   
> @@ -5738,6 +5743,7 @@ module_param_named(ndelay, sdebug_ndelay, int, S_IRUGO | S_IWUSR);
>   module_param_named(no_lun_0, sdebug_no_lun_0, int, S_IRUGO | S_IWUSR);
>   module_param_named(no_rwlock, sdebug_no_rwlock, bool, S_IRUGO | S_IWUSR);
>   module_param_named(no_uld, sdebug_no_uld, int, S_IRUGO);
> +module_param_named(no_zone_write_lock, sdeb_no_zwrl, bool, S_IRUGO);
>   module_param_named(num_parts, sdebug_num_parts, int, S_IRUGO);
>   module_param_named(num_tgts, sdebug_num_tgts, int, S_IRUGO | S_IWUSR);
>   module_param_named(opt_blks, sdebug_opt_blks, int, S_IRUGO);
> @@ -5812,6 +5818,8 @@ MODULE_PARM_DESC(ndelay, "response delay in nanoseconds (def=0 -> ignore)");
>   MODULE_PARM_DESC(no_lun_0, "no LU number 0 (def=0 -> have lun 0)");
>   MODULE_PARM_DESC(no_rwlock, "don't protect user data reads+writes (def=0)");
>   MODULE_PARM_DESC(no_uld, "stop ULD (e.g. sd driver) attaching (def=0))");
> +MODULE_PARM_DESC(no_zone_write_lock,
> +		 "Disable serialization of zoned writes (def=0)");
>   MODULE_PARM_DESC(num_parts, "number of partitions(def=0)");
>   MODULE_PARM_DESC(num_tgts, "number of targets per host to simulate(def=1)");
>   MODULE_PARM_DESC(opt_blks, "optimal transfer length in blocks (def=1024)");

