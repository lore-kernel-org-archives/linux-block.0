Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579A1C433F5
	for <linux-block@archiver.kernel.org>; Fri,  6 May 2022 15:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391134AbiEFPpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 May 2022 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344240AbiEFPpp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 May 2022 11:45:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F9689A7
        for <linux-block@vger.kernel.org>; Fri,  6 May 2022 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651851720; x=1683387720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CudXlomFZkQJESGju0/Iz+s8hFiIaxDM6HlQScgYRIU=;
  b=JeI5NX8IpOB54YqPpSX/crPohncKa9sCSYu1sa1aBv5RzTsnFtUKlnPZ
   ehK/+pnBZR7Cmi1U7OyaXthLz7huvnrAPmhZNEAN3NsrvdzEqXqwneNxL
   Frfx1E37C1JWRiKG276S6bOFp66zgAZYM20hMDttqSBAA6vxTc3JhAfZR
   1Ai5HyBKcZ8uWPSpEC2fXHNDJvWPggmnxnz+rqnbf3NoKe3acUr2DJ8Qc
   sdVq3S1VElbuvAj6snCQ3vxgLOy1n5+3L4k1ImLzIwokkDWhv3lSg5yy7
   lGCzwczjV91uUhXYWsk8Fqelzy4IXpzfk5mp/uRR5aR7GZcuuFMO7MO0E
   A==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647273600"; 
   d="scan'208";a="199701354"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 May 2022 23:41:59 +0800
IronPort-SDR: TqZwx98ovRdd0MIc39pSDAMpFvYOvUvu3HsChehH/xGOn/xsXs7o0o/yuH9imn3WvKSQ6dJOpt
 nT2CwUqcSWQM4St/JNu5gEU41SPCtMrf2HL97PR9ONB2zzDhWPdzps0Er+xxA9LuY5oFttKnAY
 xEgoUq+OCfuP5Q7/0Gt23KzIoTrGznAMLPNAu3AZNMtlziruFDH2hsGMZC+pS0vqvhbmbarBgE
 QWgYwbFzFkgRnLBmn0g56+kVhf+KUQusYZpPmUQyj88Pki6BkIhmlUnVBvvylMTLozQABEQfh0
 iRQCTbTYMdRgNnvQ/gqUxuW4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2022 08:12:16 -0700
IronPort-SDR: KqxjG8q+RZ7Chw7jsbgD4SLsKTUYm/omC6C19CeIWTDZ3f/QlHgT5R4VdyXAiR10vRBBbHUFyh
 thmGtB7crA2ULwhyX659tJiog5L5cZD8UCcl+WDBJiAmEZRKNZvXYkckvFotgPAQ/s5yhsAg3B
 wwJA/Nmf9bomonqqU/9rXoeBD+2aWfBPPrgs9XBbuV1IpMq71Hiq5TaAkSM4xNLXeYJhJ54fEg
 sz1SK04lFiOjNQIlLlyJSgSGJ/knX4a1RsmFkVJB99sPxSivW8YkJ7seQ3/Ks0LPjLwbSVSL0L
 iOw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2022 08:42:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KvvvC0zwmz1Rwrw
        for <linux-block@vger.kernel.org>; Fri,  6 May 2022 08:41:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651851718; x=1654443719; bh=CudXlomFZkQJESGju0/Iz+s8hFiIaxDM6Hl
        QScgYRIU=; b=WbBRu0S7iR1SmhEVR9i30Kql+kUpme4JxK84Ex4n5H1AfUhQ0EA
        s43ehh3Jxi03c/aa1PkPy9zpXcal9LS0jQoLHXDoQ8X64pfmVU8F+Y8nBgHjfgas
        nkAL+jnWw5ThcR+Jq1BNnuhc0o/mhwqQ5IiqOdwPxU5eHhWBbzcI7rR1dUJwE2Fi
        SMt7XqWc9/XGM7LK0GmzTFUNkZ+KteMkRDfpeOhq0if7HyNffaZrnfkJFK1T736p
        S4EMQmEAWtxxz4M7PkJBG2UGqoKaNk93iakpAHvYx7Hk5wLPL3e1zc9RYTuzeG/j
        dNxUKQCZnRC3KA89AxMPNpyTuxFnJGOFejw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YVDSWZteFMgR for <linux-block@vger.kernel.org>;
        Fri,  6 May 2022 08:41:58 -0700 (PDT)
Received: from [10.225.103.215] (hn9j2j3.ad.shared [10.225.103.215])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kvvv75djhz1Rvlc;
        Fri,  6 May 2022 08:41:55 -0700 (PDT)
Message-ID: <7f1bd653-6f75-7c0d-9a82-e8992b1476e4@opensource.wdc.com>
Date:   Sat, 7 May 2022 00:41:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        hare@suse.de, dsterba@suse.com, axboe@kernel.dk, hch@lst.de,
        snitzer@kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        gost.dev@samsung.com, jonathan.derrick@linux.dev,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
 <20220506081105.29134-12-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220506081105.29134-12-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/06 17:11, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Today dm-zoned relies on the assumption that you have a zone size
> with a power of 2. Even though the block layer today enforces this
> requirement, these devices do exist and so provide a stop-gap measure
> to ensure these devices cannot be used by mistake
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-zone.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3e7b1fe15..27dc4ddf2 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>  	struct request_queue *q = md->queue;
>  	unsigned int noio_flag;
>  	int ret;
> +	struct block_device *bdev = md->disk->part0;
> +	sector_t zone_sectors;
> +	char bname[BDEVNAME_SIZE];
> +
> +	zone_sectors = bdev_zone_sectors(bdev);
> +
> +	if (!is_power_of_2(zone_sectors)) {
> +		DMWARN("%s: %s only power of two zone size supported\n",
> +		       dm_device_name(md),
> +		       bdevname(bdev, bname));
> +		return 1;

return -EINVAL;

The error propagates to dm_table_set_restrictions() so a proper error code must
be returned.


> +	}
>  
>  	/*
>  	 * Check if something changed. If yes, cleanup the current resources


-- 
Damien Le Moal
Western Digital Research
