Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B5C433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 07:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiKVHao (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 02:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiKVHan (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 02:30:43 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AE231222
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 23:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669102239; x=1700638239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hDonoSZRim6wZimWT9YeDmLwt53bAzfsd1XjPVwnT3A=;
  b=BhUVhJRWSEQ4RSFWgbMP3WsOutFCiuLNYRPZg3ZcjwNXeedRiJqNgUDP
   cOWef+uaAcFBVb8/zOyoohXF+qhNElR8pKs309PzX381itaVRS99Ha5D4
   faYmN4F6LhqgTo0GtBs7VdOi+0Bpry1u2/HnpDWMdLnZWgbtTlcLsk1zw
   NRmXbIP6xXaeIuvR0XIwjyuHeuyM5KELu04SIPJIBgLpea/bzLdx0tYpb
   fItXgW4N63A16qY1YjYF1cpD02EonnV8TIYpw0C2jBQjhJ+fQ8wKp2Gvy
   6UY/UH6fEniW5xhWFsEoY+ugr1eTV4OmIJewqS4jMQneOd/6t5G1lZlyp
   A==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="215118223"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 15:30:38 +0800
IronPort-SDR: odMbHBg1PJVz8wCTjtMnuhND0G3WijPhwrpIxit2LG93k9tqCzjz7XN47bYjNAJEmZZSjmfVi8
 bWCWZuPzTtRIWaBVTvA6AVvmSJ/cTSvC6KQJjcj754QoC+VprUiMV4lqPG3MYt/LAWf9bz6Bgz
 rL0SRYSYjqYKyQ3KLDUw3t3+XkRQK3Nd4Vo3udQMtxAWJo7XiTDhXFJBCT0XFDac1Fl52eYMXo
 jMOXIQl/Fh5QPHgQWj91ERp6Wgxmf4H/BpTgg5MRFU9a5+AfP1nFh5hK71R6Kr0QeJPxn114fB
 C/I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 22:49:27 -0800
IronPort-SDR: AYvECTLFgCo9SrR+0TAN+gukm5q1lHP8mHpUXIRG5z5sLL0o/ac4WvWbGc9Gam9qaRFAAgkFsR
 ra6x5K0IAJ/233REsbiOgUgG15+4kBfwGzgLd4v7LbtpM+PIqSpKOauqirIRWRfbH94guOkrqo
 1uoZ3IaBPcDbFGfOwS8Ik5XHklXJRnxdBO3I4SAkmn7+bt3FaToS7t08zuDcTAUmggRDGl+h02
 AfwBwCFaKm81etqcsOreCgMpDlHQh6sf7sgYb4P+A2xuj8TXOjkcgkoKgJlZctOurABDrYjeIC
 YGc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 23:30:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NGbWy4dktz1RwqL
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 23:30:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669102238; x=1671694239; bh=hDonoSZRim6wZimWT9YeDmLwt53bAzfsd1X
        jPVwnT3A=; b=mxOEdyCjXfEL5bu7S5BM5Wr5Lyx3swnuZJvK5um6C4bqA+uTYT2
        SOr1oGvCj/Vb1Q82Ec3rFfcHHx0Q8uh7QJTuQimL+W+nEjG6JD5cBuJgmcYcs8q+
        sZc4/o+cPGRQhL/RucfrVJLygD5a+5my/ookAXoHLfbhjyl5eLXGpHrexNavBAHp
        Hni+6ZH50/h/KI8VW0apfnKlSAuVvKmIDAG8rrSGu791c/tj1rv4wLHuwHdjaWbk
        SYOWsRNQyKrqyB2xPb60GPGcKUEDOa4ij1Z9zxosX3nnCtUswAOw88KJBlzttmpl
        oewMdcgVZJ47cTbCIib+dXyumjBUT7x7ztg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xpj1uv4POvp5 for <linux-block@vger.kernel.org>;
        Mon, 21 Nov 2022 23:30:38 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NGbWx3xhQz1RvLy;
        Mon, 21 Nov 2022 23:30:37 -0800 (PST)
Message-ID: <34e8a861-e265-f9ef-53ae-1b18a595c700@opensource.wdc.com>
Date:   Tue, 22 Nov 2022 16:30:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] blk-mq: fix queue reference leak on
 blk_mq_alloc_disk_for_queue failure
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <20221122072753.426077-1-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221122072753.426077-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/22/22 16:27, Christoph Hellwig wrote:
> Drop the disk reference just acquired when __alloc_disk_node failed.

s/disk reference/request queue reference

Apart from that, looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> 
> Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a3a5fb4d4ef667..02a1f6e501ea8d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4108,9 +4108,14 @@ EXPORT_SYMBOL(__blk_mq_alloc_disk);
>  struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
>  		struct lock_class_key *lkclass)
>  {
> +	struct gendisk *disk;
> +
>  	if (!blk_get_queue(q))
>  		return NULL;
> -	return __alloc_disk_node(q, NUMA_NO_NODE, lkclass);
> +	disk = __alloc_disk_node(q, NUMA_NO_NODE, lkclass);
> +	if (!disk)
> +		blk_put_queue(q);
> +	return disk;
>  }
>  EXPORT_SYMBOL(blk_mq_alloc_disk_for_queue);
>  

-- 
Damien Le Moal
Western Digital Research

