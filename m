Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D343C38A2D
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 01:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiJ0BQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 21:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiJ0BQw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 21:16:52 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F94A54CBE
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 18:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666833411; x=1698369411;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4ap/kLZ0OSB6Zuig+PaHn7p6EhgNVXfGROLAu+d2tkk=;
  b=KYNgIhu4g/lFkqcueM//QR9z1sWnZ4+0DJFn8k6AiKLlekCw+GuDwx+L
   qHtou0MrjOsdcX+FO0JJcIi9vSjj2PV54pM2TTNJOO69krBxSSmw5MdxR
   SUanKE7LN6TJcMmmNqmLnGFLOantg2K2bGjY6C32kTA3UGABXAojoSyhp
   2thyGWDqL3856ehz2SC05jsEHhuP/0IQUDE7r+B+Q0AnZPF7EGJuL25fp
   IMqQye+fXRfYKw+HiG2JG1q3mn9gYyEJKyugtHAUZ2olMvllWwp8fNuoB
   hMJgXfrd761brQ+5WBUA1da5o8omXBXeHjCWYjJh2cw79UZEeAVS+u76Z
   A==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="326936998"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 09:16:48 +0800
IronPort-SDR: vJHVgiNJ3Tw38ISNxDu6dMLvafX4EbixcBN+bpQrLhOwc8dHA1Xa/tyCflxeozg40fGV4mny9A
 Ri+GkNzRPYst6qhsk/7ellZJfB2ydzZGs6TyQv1IbPy1g50Iq9KYsKqSjZauiLz/FDQDmwSjoE
 cSm0tIeAiPSWRJHXH1iJ6+HZNgOlEvW56aMsWjkqwSegrijO5r1mZDQDSPQaedrLtYDHa1/CK4
 60gsUTSngoltLRAByiiPsdfmtHooD+t6zynySUIwG+7bAhi722rDZVuH7DBi6CE8BzwdrFs9+y
 XQpD8KVR+orzzlN/N2bzEUCi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 17:30:28 -0700
IronPort-SDR: YUsSP0By5Fsh12N5651BXsDdrxNrA8EEi+ndcAYq51JzzhqBg90N0f5lMLAguBCgZIA7YI57+/
 XxXM/EHKDEJiO197NWuXDUsIyGZbmXanDPwC8msNFPpqcmthYqn9AlC0Iocy6TgVHiKBbJzDBi
 hGddxHpCoSzlsS5qZcAeLYiUwpnysPrX9zCGvP2Ch5vtK3+uOIo/9Gi2W4MTbKEyF2eWGdoKIS
 /DRxF40Jx8NdIwAF2gAPbvQ12t17Z0XU39Uzmmxsnkk5WNcyHCu3HWKLajWyXZSswV3xdJiwFb
 CXY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 18:16:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MySSb44CPz1RwtC
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 18:16:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666833406; x=1669425407; bh=4ap/kLZ0OSB6Zuig+PaHn7p6EhgNVXfGROL
        Au+d2tkk=; b=fc5pQpFSYHWJxqN13XqqQn2NYyh/xGBn+XIMtiysMOBlZmkncqh
        RMejpVRBPwy5UVZFVRK4sxLxtDRx9zvJZm7vpjYoGIIFlC1FBZyWWUMed/5UX5GK
        KVXV2fqb1kLWVQqXp0Hx42aC7OEEfYz/ouOOk8HdY8wM1ArnQwMCvivqW5gYXgmN
        eMiZGPUU5N6Vn7AxqZarHXJV0pDx43l+DUD4bsGsnuwy9rXNQZ1gfH8fBrTFUfqO
        u9p4uCE2SCrXol9iCQYSuxGmBS6itFIaAER5LfCoYOuE82El49HoDFHRGktVu5eQ
        c9SK0ieU/U2JNXd4JKb8XuMAIbJOyvqgTBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d1nGpuO0mKY6 for <linux-block@vger.kernel.org>;
        Wed, 26 Oct 2022 18:16:46 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MySSX3v2yz1RvLy;
        Wed, 26 Oct 2022 18:16:44 -0700 (PDT)
Message-ID: <9cd8aa6a-98be-ddba-db4e-07ed59b53f08@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 10:16:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 01/22] blk-mq: Don't get budget for reserved
 requests
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1666693096-180008-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/22 19:17, John Garry wrote:
> It should be possible to send reserved requests even when there is no
> budget, so don't request a budget in that case.
> 
> This comes into play when we need to allocate a reserved request from the
> target device request queue for error handling for that same device.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  block/blk-mq.c          | 4 +++-
>  drivers/scsi/scsi_lib.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 260adeb2e455..d8baabb32ea4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1955,11 +1955,13 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  	errors = queued = 0;
>  	do {
>  		struct blk_mq_queue_data bd;
> +		bool need_budget;
>  
>  		rq = list_first_entry(list, struct request, queuelist);
>  
>  		WARN_ON_ONCE(hctx != rq->mq_hctx);
> -		prep = blk_mq_prep_dispatch_rq(rq, !nr_budgets);
> +		need_budget = !nr_budgets && !blk_mq_is_reserved_rq(rq);
> +		prep = blk_mq_prep_dispatch_rq(rq, need_budget);
>  		if (prep != PREP_DISPATCH_OK)
>  			break;

Below this code, there is:

		if (nr_budgets)
			nr_budgets--;

Don't you need to change that to:

		if (need_budget && nr_budgets)
			nr_budgets--;

? Otherwise, the accounting will be off.

>  
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index fa96d3cfdfa3..39d4fd124375 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -298,7 +298,8 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
>  	if (starget->can_queue > 0)
>  		atomic_dec(&starget->target_busy);
>  
> -	sbitmap_put(&sdev->budget_map, cmd->budget_token);
> +	if (!blk_mq_is_reserved_rq(scsi_cmd_to_rq(cmd)))
> +		sbitmap_put(&sdev->budget_map, cmd->budget_token);
>  	cmd->budget_token = -1;
>  }
>  

-- 
Damien Le Moal
Western Digital Research

