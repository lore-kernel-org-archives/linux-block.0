Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597CEC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 08:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiDRID3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 04:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiDRID2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 04:03:28 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFFFB7E7
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650268850; x=1681804850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N3pAk4FME4FfpMn1iEoaJawKiDbUT/rSC5t+NXLtpDE=;
  b=Lfq56d+sznKISqAeA2QDMR4/b9fhBOgrbor+EGp4U7ZK4HRXrk/mJzwV
   y6Q1NTWTGPtIHSkonNHBAH+d9xkpu/JVXHszyLWVz0Iac48wda0R3f/FH
   X3B8yVFRY4l3Cx7Nv5UqSTPBDESrbGWlGSxxgE+0ndplG6I49AMepENuk
   O24Dy1fLKSS2eV5nXdD0zVibKVflpe+yPeFKgVRRvVLoLaadXct35DdbQ
   caFfblJDupv2eEoqFr6SBdMqbMKtLsdBMWlPMwKGVYS7Qd7DUQU5O7cZk
   ER/RWxsmu6eSR2tQZpFwnig9X6QgCD/89SHylo6IoWj31DcUeQT2ACYCq
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; 
   d="scan'208";a="197010060"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:00:19 +0800
IronPort-SDR: lCWM7WjM1PlY04QG6Uz+AGbvnzuUWPh4+07CHfmjwzaMynBd4b2xnhGZcX7yZiOoK8jryo08Na
 MQ2zJzXYssP9+kRRQvMViuqjjFIlIDrvH8uAYnufuY+VI8vBICwBlJMSqDysxfIPo8qGuIbByw
 BiYuMDjhn+rsbIGItIpR4m2qITwclhm1bs124IQBmpyY2RLgac9WRHn0VTgKJhAXHL2vhCm2+X
 gZXdA0H5w/v5OvDCB6rRO8LAnMzAy1k7p1xBJwghFm9jnJhKzTsjHBi5FVqQemSP+zob6e4mQ2
 G/b8C0oenx54yshz8Di4kCun
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 00:31:26 -0700
IronPort-SDR: rToYkkbFdm7r8p4xjCpIi/ked4toxSI/Mln2jS7wrwkZdo36LmuffIPxGJfMWLo5Rh494BrQME
 Gs3gl0p9S5lmXEll03wBqNZYLzUQ78mvQbh66V5n2Dh+MIZbzgblw8uzNBkSC7+sHMUX2cM8OI
 zQkkDwgE8q5kaA3QpoHCrmLOXy0J1QtGUUavMPoK8d92PhnJwKBbMUV0RIYBd33Yp73JiTRxf/
 6J5JEs67Io0ibxNzXmpUgVCxDCld+BDlHpZs+ZUpOyFU2g1R6+A6r4EcWClCCsJ6Ah45SqMpCx
 Ots=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 01:00:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfVp56g2z1SVp6
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 01:00:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650268816; x=1652860817; bh=N3pAk4FME4FfpMn1iEoaJawKiDbUT/rSC5t
        +NXLtpDE=; b=MEaqTu1yLViO++hF68PbHZUjVy7TbgArEZJCg3ei0W3w63rahlS
        2Oo9xzEB1Hx/lKCZUW9cGxczRM5Vrelcmvm9LANOVITnzOz8I2ENOdHZ8+QZ1EgN
        AZbTJJPS5t+7rlIrvoqjzTM4/pA02YTjhTAOlM22DwLiDuWvFGrwrZrjedl6MWM0
        LeHSHFh+6fRMFLxAIaOghVOR6xxwYGlJreU3ftYCeSBDAGj6khBFbTabVJETggeQ
        MBI1MQTFt1UdPdWbOrfszs+m5LYz/r5BLn1Raj1hqGWkB0hJMq1rknMyPlvQI86M
        WaEj3itLOmiucUlEX7D/KClfJgATBNly39g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B34TGzzzGk8m for <linux-block@vger.kernel.org>;
        Mon, 18 Apr 2022 01:00:16 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfVj0QSXz1Rvlx;
        Mon, 18 Apr 2022 01:00:12 -0700 (PDT)
Message-ID: <fd915a51-035f-d5c6-42a1-c517e3d1f1b1@opensource.wdc.com>
Date:   Mon, 18 Apr 2022 17:00:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 05/11] dm-zoned: don't set the
 discard_alignment queue limit
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Song Liu <song@kernel.org>, dm-devel@redhat.com,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, linux-s390@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        xen-devel@lists.xenproject.org, linux-um@lists.infradead.org,
        Mike Snitzer <snitzer@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
        linux-block@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
        linux-raid@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-6-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/22 13:53, Christoph Hellwig wrote:
> The discard_alignment queue limit is named a bit misleading means the
> offset into the block device at which the discard granularity starts.
> Setting it to the discard granularity as done by dm-zoned is mostly
> harmless but also useless.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-zoned-target.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index cac295cc8840e..0ec5d8b9b1a4e 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -1001,7 +1001,7 @@ static void dmz_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  	blk_limits_io_min(limits, DMZ_BLOCK_SIZE);
>  	blk_limits_io_opt(limits, DMZ_BLOCK_SIZE);
>  
> -	limits->discard_alignment = DMZ_BLOCK_SIZE;
> +	limits->discard_alignment = 0;
>  	limits->discard_granularity = DMZ_BLOCK_SIZE;
>  	limits->max_discard_sectors = chunk_sectors;
>  	limits->max_hw_discard_sectors = chunk_sectors
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
