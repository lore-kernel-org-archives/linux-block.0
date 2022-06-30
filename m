Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B47C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 23:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiF3Xfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiF3Xft (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 19:35:49 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F17599E5
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 16:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656632144; x=1688168144;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=raRugrPI6FLeb9WE0Cl64qOPToVZHbaqdGVu8RGPsQo=;
  b=itwxQw9vFpQRvuwQYMb34adeWo/ycODv1nym8zvJwigq/EFamw2UJCz4
   JOrpbQC1wUwt2T1PZvv9k3N/k5jxHeSKqzCJWmVi1xPcNv8+qiUOUbCnE
   RgWgoEUkIK5NQXb2vUIVoxYdc6SUN5aLXp3K+UmZNcfhr0/DU7HWA+elb
   QESQlc1/wNZs+PhM1jErNT7DMP4W0CSz8vpnF99PUah5T3LQFCZzOm4Bk
   IDJjy3kF5I2lJoMRrIv015VyWKWNG6Kmr/96tS9gG4I3lnFkWtI2m35k9
   SRFUKFp+sp01E+fSr4wdioRq7T4rj8skG8btEpjuy9e7sj6n07TDR7grW
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650902400"; 
   d="scan'208";a="316648416"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 07:35:44 +0800
IronPort-SDR: vblt0EzgJJhjgUCmXl/EmVBwUdu0jnZqQM/r0gbHH/hYSHht0YSzTBV4IW/jV6uUiJmZk9/MpS
 GoyTSchUlD8aVp1ep+CGgtU8/Yiz6dq71OtT3ssGZbFjXx8PK733E3EuoEksmQr0og2O9ATop2
 Gl0JCq6Cg82crKn7gVjPWQwr/SloiWZUYevdUI1V5dEC9neSfQRcjDBI3S3eYoN902baIeHI8s
 S0/G2AJ13ZOOD3tHHELLWfHrwicvNrxEFaW0IOeMIo9y5MzTuewxKKUq1RvvQha7HWfiqbiP7E
 ywSp36JtV1sKiD9AzYb0mXkO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 15:53:17 -0700
IronPort-SDR: lcaCHjfGm1ShmfgMcS6aJ4ahAAeeJCabf1e87EKyrmaUky6FlgAlaNSZSx1bqxnp/KIF3SV7Di
 VfqbQW3pSgg6JYACUx3mvtsHgSS5yIoVf3uLwWF/OtLoPgWMBoS5ewRpyzYzwuPaabpNe1aBnw
 6WP0h2CBBXbCvWbbOye727kGl+9sDbpYi81UGVeJE5UMWU0v7bzeZUCnXA71Khn5Tl8Rb6S+DT
 uXg4v1Adyh3yhrfmXQkLfEoB+PGIFD546RBBBGMcyUVyHo9K+rmaw85EnOoiWZ8Oga8JckKO7u
 AVA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 16:35:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYvpR6cyqz1Rwnl
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 16:35:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656632143; x=1659224144; bh=raRugrPI6FLeb9WE0Cl64qOPToVZHbaqdGV
        u8RGPsQo=; b=pMKa9qABtHr7Ug0wyJ8vOtDojgRLK88hly0qgdw9v4LMF9EFwag
        zJjRHXatIrxHrPNeoGIbDjhhCa7W9U3uzmBhGlONUHtb+kegfZXMzTkiHttQAsWM
        DqfEDyXPS86cw516CbgFdwDstvl806G0PNLtB/FHMlmf9frZppUg+k7dspGh/rQh
        +tSZ9IAwUotLpTWKFc2RCoH94xvtbyfn7sjzkUnhGzq4Yj+utgnWk9En9bNcBbA7
        9ddR3wPDql1eyc+SupLFw/edlcEJoiotDfPZib1RkGE1ubJNN/kb8EEzD+K5AgY8
        xYZIq7+g7ZKW3WbwzCXknvTcIo1C3BGsPzw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7_331IZHq1tk for <linux-block@vger.kernel.org>;
        Thu, 30 Jun 2022 16:35:43 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYvpQ5Zm8z1RtVk;
        Thu, 30 Jun 2022 16:35:42 -0700 (PDT)
Message-ID: <889f5c03-d686-be89-5797-b736ab3e4080@opensource.wdc.com>
Date:   Fri, 1 Jul 2022 08:35:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 08/63] block/mq-deadline: Use the new blk_opf_t type
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-9-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220629233145.2779494-9-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 08:30, Bart Van Assche wrote:
> Use the new blk_opf_t type for an argument that represents a bitwise
> combination of a request operation and request flags.
> 
> This patch does not change any functionality.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 1a9e835e816c..c5589e9155e6 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -543,7 +543,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
>   * function is used by __blk_mq_get_tag().
>   */
> -static void dd_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
> +static void dd_limit_depth(blk_opf_t op, struct blk_mq_alloc_data *data)
>  {
>  	struct deadline_data *dd = data->q->elevator->elevator_data;
>  

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
