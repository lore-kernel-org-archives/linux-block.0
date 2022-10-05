Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC856C433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 05:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJEFJU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 01:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiJEFIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 01:08:51 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DEB73328
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 22:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664946400; x=1696482400;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EeFB7dhZIp+jQGWS+hX5NNzke0u6/fjW43g1++marZU=;
  b=VIVD4dPAcrWf7iJ+9KjXECRRWGOPB5YgurUXWN+WGzXKkIJ73TfsvwOF
   bJS0VLw3eO+A3ot8DTMjsP+HFXM20D24Nkv7Y/BFV8i+KYpBu2bhfznPz
   DuMvMlA9rUfrm3tUvSFqSpNqgXtvMyU+a00Szs+/1+EuWtv3bctg3fY3W
   oVJwbpFLDLekpSWt6k4KGWlr4M4O7U44q2l70VRHbhF6rJQVA++GGH59E
   FpL4+DTKq8eWWXwQ1aVl0KMWVOF3v8Ft674ZL/C+4++Bp/4xui0WhSojM
   xxHsJUxiZxLfoWy4KXRcVrevflM1dvnPFJl8iae/yWwLE1RFBWkgo+VJv
   g==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="213419526"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:06:23 +0800
IronPort-SDR: NysGftoHHNBnFCSntOYRluIoHHN6Z62YfE6wpBVBsdp5pmBtj2Rhds8K8SeJA0Lq7H4DM+22NI
 qOxTfIeHwqV9OuwjDypg/RcOpXDSFAJm3rxT/9cIbhdPqBQi98shonBW5o0e27nC4KYYpzWRWo
 tHga5rOD8IcA5Bt6TwCYMBYS6ZlzRS+5GYI8gyLKo2fArIIXvvoRfiLy3mm99g4Od8eTFqBWtb
 eexznA8nIqCU8d1jXR2GdaswKfBDlb7jPCsOfbjBl4xsMNxICiIVKs7n1sLUCavzPD17hMk0E8
 uZ2wg6bTmlZgeAeMVb99jJyD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:20:37 -0700
IronPort-SDR: 09USLd2btnN8E2PEkFHQokOptaODZAlBszQ0cPhsXSifgBaevm95BbnXijLzYdYxfBGBZoZbrz
 SnrXsLqH6NYYvEotsS1Rxpe2EjX3pVq9heJH+kqwMzAjVCmmF5U9fpYSsa2htfC+Cvk644CHA9
 0SO69XNUYs2cCSMtvLy0ps87Prr42p03a+Rfwu3/mFswuR1lQfGHKIEqYvQuhHZe/AEU9Vs2+a
 bTV9yN9eB4gXjKzzXss5Z8cvg2AprF66Pbdgn1ju1se/ChqM2ef+EhDU1N/HXvcw1UmjHlFOxL
 Nxs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:06:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj2bg1wVdz1Rwtm
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 22:06:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664946382; x=1667538383; bh=EeFB7dhZIp+jQGWS+hX5NNzke0u6/fjW43g
        1++marZU=; b=YKAozr7TbiFanSOWsaUl7LJWKepls26WHxlHBneEkUVarAlnlVw
        KdRlJzj29gFBzcri5pAhPDm0g0wvlhYDpHlNqwqe7PBahW3142oAMpRv5wQUtv63
        cj0SidiuVcbfsIYKM596fyELPnorTLHE26JraNHoJ0hhi1/yASSj5twPkCqcZYbF
        WBlplZslJLaxeDzYRBzu7uvYv/xRaZedREOni9O81T9dNO5hWf8Hqg1b8EUhi5oD
        WRYAoEmG4Pf/vF0eruPwelrZ0JobZPRJLt8Ag3xjnaoiErqlaZG+KFGa1VikTyYi
        UL5+rb19S0WljvNAYEMlxFCncqSlX8IfYBw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BKPMIXKwrK9K for <linux-block@vger.kernel.org>;
        Tue,  4 Oct 2022 22:06:22 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj2bd0nCjz1RvTp;
        Tue,  4 Oct 2022 22:06:20 -0700 (PDT)
Message-ID: <ea505961-758e-01ab-6ce9-775f170c3979@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 14:06:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 6/6] null_blk: remove extra space in switch condition
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-7-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221005031701.79077-7-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/22 12:17, Chaitanya Kulkarni wrote:
> The extra space in after switch condition does not follow kernel coding
> standards, remove extra space in switch condition end_cmd().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/null_blk/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index eda5050d6dee..e030f87d0208 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -789,7 +789,7 @@ static void end_cmd(struct nullb_cmd *cmd)
>  {
>  	int queue_mode = cmd->nq->dev->queue_mode;
>  
> -	switch (queue_mode)  {
> +	switch (queue_mode) {
>  	case NULL_Q_MQ:
>  		blk_mq_end_request(cmd->rq, cmd->error);
>  		return;

-- 
Damien Le Moal
Western Digital Research

