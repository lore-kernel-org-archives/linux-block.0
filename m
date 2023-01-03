Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54298C3DA7A
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 02:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbjACCdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Jan 2023 21:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjACCdy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Jan 2023 21:33:54 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE32D103E
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 18:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672713233; x=1704249233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m7CZUEu0rfN0SOVohyMC53s9FO7RSU1uMypinK6ksRk=;
  b=PyBRk951L7fwKdIKGfGoaopsnWpCGhIu890NywkIzLWaQlWcTAbFMr1y
   SFozyudiHC0ZtQmNPwKXAR/p+GwnwHw8uLfthWppkwOq6/1Z3CfQT8W8N
   ZPZqj3wuS35Rc5wnl5JbosVJfEbTshoOJOfsP5ZYbVWSehJ+MgQQEEDJJ
   nsCWvkNTrfRmV7z+48ZvX3Gx91k51ziAoXdckLwVLOdBZ8DeF+OmLE8cJ
   lOlw59FrjJPXEA5ZVhTsJvNFDcMTaVXmZBYf7n/EOs9uGMS9DDAJ3sijy
   bCP6qK4I71Kb0PtZPQqTxP7BX/mijzlnBQsZb0qsXPqDazj5BWDg7lTzw
   g==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="224959416"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 10:33:52 +0800
IronPort-SDR: XgK3YJcIWQIgIX3nqajkZhOgXM873zUvcsHU9OZxDEhIr6htj68+5bA9WdQuBsWLNaLyObvjU8
 4m+PMuIw1aJOf5In3pryc0BDr3/BgoCj9dS+6gd+NpLvlvv35PPos12vxHRLtk6PqzoRCjtuSN
 D8rNpBiSQgAvn+O6THkCoqrcOKGUjyS2o5cQGrofKI/R9py9Ine5GXz/VirSUJraH30D4wmJ6r
 JTRsPo89az/qXNIJf/pf59uOpTJ6VNNoE/HMWYLdx60CaEU5qKyLAd7LvQDSbDhayYY7Xpr0Kx
 GcE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 17:46:06 -0800
IronPort-SDR: tCFOwIZ6LTXO5hie1y7SniSrMCSdNviETXGbkF2fMdK6NkDpuSKeRNhaGvF8slPlJsZQyUs1DT
 RIr39qhPhVuhcdmHua+O6JhHB5n/XjYMuOauj7no4fKZYYIpNPKlFHF9LHu5OsqP5B7FZqe8wv
 tpPnxKPYbGoZEMkNGqXdqogzVU1BwegrIBs/tLZ8f4Cu1APQhD2SsSb+U6SfAhAAfEMHs06eTl
 iAM+kZ4ZvxCMASQa5NcO+WD/vTdUZPf+H7vxmE96WXgT04sZXrAo+XuQNpsZD79eqawzChsonm
 jBA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 18:33:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmGy80w8Vz1Rwtl
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 18:33:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672713231; x=1675305232; bh=m7CZUEu0rfN0SOVohyMC53s9FO7RSU1uMyp
        inK6ksRk=; b=G9qql6fVwHBAZmPI0LXOsmy3znq7MttXL2EiNnxJznnZ8/kwDwe
        n8EK9lPE1E7TkhzwL7jOPLxJcTiYR2ohTP5I/IPtyllCTwL5Rc6jgHysimGcaNJ6
        wtFYx3UmWTyukd8McTe0nwXKj3oarUaYIIENk5TOID0bsk6BnxcoAmTv2ZD+eEsr
        CgND+8KnNLHOZp+1OmvI3pYVm+puTu3iimRmloL/awchHfahFpEXoIBhUqVgCbyE
        tLRVDGbgSGC2XHcA0Z+dQIbHnXzExUcIDpbuN4O2+NXqU6S+ULEc3imB0Sq7Wdi6
        k4fdythtP+euHvI8yv0hFnn0kv8NVdHV7GA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e8K0xqzv1O2v for <linux-block@vger.kernel.org>;
        Mon,  2 Jan 2023 18:33:51 -0800 (PST)
Received: from [10.225.163.3] (unknown [10.225.163.3])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmGy62mDSz1RvLy;
        Mon,  2 Jan 2023 18:33:50 -0800 (PST)
Message-ID: <d4613092-e29d-574e-9d1e-4f5a3eca8b56@opensource.wdc.com>
Date:   Tue, 3 Jan 2023 11:33:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 7/8] block, bfq: remove unnecessary goto tag in
 bfq_dispatch_rq_from_bfqq
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, jack@suse.com,
        paolo.valente@linaro.org, axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
 <20230103095303.2223546-8-shikemeng@huaweicloud.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230103095303.2223546-8-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/3/23 18:53, Kemeng Shi wrote:
> We jump to tag only for returning current rq. Return directly to
> remove this tag.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  block/bfq-iosched.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9ff424c78e9b..a11be312ac77 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4966,7 +4966,7 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
>  	bfq_dispatch_remove(bfqd->queue, rq);
>  
>  	if (bfqq != bfqd->in_service_queue)
> -		goto return_rq;
> +		return rq;
>  
>  	/*
>  	 * If weight raising has to terminate for bfqq, then next
> @@ -4986,12 +4986,9 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
>  	 * belongs to CLASS_IDLE and other queues are waiting for
>  	 * service.
>  	 */
> -	if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
> -		goto return_rq;
> +	if (bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq))
> +		bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
>  
> -	bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
> -
> -return_rq:
>  	return rq;
>  }
>  

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

