Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3780C433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Apr 2022 21:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352307AbiD1VrZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Apr 2022 17:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiD1VrY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Apr 2022 17:47:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF91A776A
        for <linux-block@vger.kernel.org>; Thu, 28 Apr 2022 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651182247; x=1682718247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m/acreNIl2rWYjlVezvJCF1GJU64s3Qgnn+Km+O6eew=;
  b=kg2TMiV+0uwtE2I74AYwtzh1CmpyOITgytkeBE2BXFYRjvtiUfLCIl0r
   2IPS+vAJxnpYv3CO/7t6tVhqqd19rtQiua+4e3G243L3YQ3ttoKIVpkmb
   zsWPpceZJNWJnmj0pUerdsV/84oDV9K04KpncVrXjvhACFpAXMN0mOKfz
   6uaLFGs8LPRa8Gkbn8NqNbpf0EMRs1lSZideppt+NHM0FcVORt0wsuxoh
   lFpFcFmupR3pQobTYnQ7dZaDQmMRBxihkFtRTFgvtYxAqwxXUXzKMGwH9
   PQu06Iwhnrvc4G7tZ0/wwSkeNd66sqkJthGCJnB6LFEunGsvnmrXQ+SbT
   g==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="303311005"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2022 05:44:06 +0800
IronPort-SDR: pi6r5uaXhKEIPHNIOj9OTgyrN8k7SsoHliYp6mfy9OrcXbzTjRfEFZhtMJW1eO7fsJX3tLRSaG
 x+6t4ei5T3QJkK5NrlnbIgBMwbzU5DEMQbuYdBjNUOUY9Ob3aqejrOXpVZkyX/LMtZB8N3GoLY
 jw714XHXgIYCMDS0Os38SBOeZz4hzTruOibeRL0j5f6rHCt7kiqS3ieJYY+AYP7CnHFF/f8C2i
 y+FbBc8abxH6svvbBRs/DKOgwxez7nZb6d8ZzEhVIMGSRRS2RqWZHrA0TE7ZFXQ8tBD/CdXViV
 pplOcg2vuFBEod5Hg1wjzrKD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 14:14:15 -0700
IronPort-SDR: dZK8pCUSkMNCk4pov3lfJLaFhIppVCMGS6GdG1eqikvskX3wD++4J38Ythfhi1PQQ86ZFps1TG
 p6OUcxYlBqS3FlRvRvICRUt+Q8UeSF5MEnltTCmyzTE5hQbYTlAloQAtz9og4vEGF0KGpk6oqz
 kEKyfHrKCeUyf8BiXyPk+6+reWkdxpCGiS+g+OvC2AnAJ2RjRTPwq3ttiKxd1KO8nxshx2lCje
 ypmxNtqysbSRtxbIkhBLc+E54ybRC0AOu+sMHFVhdcsLDseOgwAIr8Rqz8+BJ5jABnATRByrzs
 2Ic=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 14:44:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kq8Jk2rQhz1SVny
        for <linux-block@vger.kernel.org>; Thu, 28 Apr 2022 14:44:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651182245; x=1653774246; bh=m/acreNIl2rWYjlVezvJCF1GJU64s3Qgnn+
        Km+O6eew=; b=P7Z2ssSysU3MXGjLqOpjIgw3LkMvOLPFsZ5/L/hy8zTXh7RRhg5
        oW7hJpKY5xehv6PCj5aAjux8iBygbEnlV6pT61szKcFi3rCbccmLZRC1mYDrsL9w
        5JjAtxFSVU6nXK85++NGprWHqgYwmhFNOvKCxx/jlLeOdAbLXCvijl/CpAN9syTf
        uL0rhmb3+rt+C1w/CE2rhsYUt7mNpL5EBJi00FmBRkg8jYpAkhDP+NtofLGylSHU
        IdqnZobibaJqdqpH2JChH3JY23wQeJdMZHT5/1cFVjlUHop8+7zb5n39efSFkKX2
        cNB3p+K+aur3vqxw7TEWidzO8wXpFiJo6QQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z_9zggU5Hq7A for <linux-block@vger.kernel.org>;
        Thu, 28 Apr 2022 14:44:05 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kq8Jb59qtz1Rvlc;
        Thu, 28 Apr 2022 14:43:59 -0700 (PDT)
Message-ID: <ce56cb7d-f184-aad1-4935-5f622e7afe5d@opensource.wdc.com>
Date:   Fri, 29 Apr 2022 06:43:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de,
        naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
        chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        josef@toxicpanda.com, jonathan.derrick@linux.dev, agk@redhat.com,
        kbusch@kernel.org, kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676@eucas1p1.samsung.com>
 <20220427160255.300418-17-p.raghav@samsung.com>
 <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
 <YmrQFu9EbMmrL2Ys@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YmrQFu9EbMmrL2Ys@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/22 02:34, Luis Chamberlain wrote:
> On Thu, Apr 28, 2022 at 08:42:41AM +0900, Damien Le Moal wrote:
>> On 4/28/22 01:02, Pankaj Raghav wrote:
>>> From: Luis Chamberlain <mcgrof@kernel.org>
>>>
>>> Today dm-zoned relies on the assumption that you have a zone size
>>> with a power of 2. Even though the block layer today enforces this
>>> requirement, these devices do exist and so provide a stop-gap measure
>>> to ensure these devices cannot be used by mistake
>>>
>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> ---
>>>  drivers/md/dm-zone.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
>>> index 57daa86c19cf..221e0aa0f1a7 100644
>>> --- a/drivers/md/dm-zone.c
>>> +++ b/drivers/md/dm-zone.c
>>> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>>>  	struct request_queue *q = md->queue;
>>>  	unsigned int noio_flag;
>>>  	int ret;
>>> +	struct block_device *bdev = md->disk->part0;
>>> +	sector_t zone_sectors;
>>> +	char bname[BDEVNAME_SIZE];
>>> +
>>> +	zone_sectors = bdev_zone_sectors(bdev);
>>> +
>>> +	if (!is_power_of_2(zone_sectors)) {
>>> +		DMWARN("%s: %s only power of two zone size supported\n",
>>> +		       dm_device_name(md),
>>> +		       bdevname(bdev, bname));
>>> +		return 1;
>>> +	}
>>
>> Why ?
>>
>> See my previous email about still allowing ZC < ZS for non power of 2 zone
>> size drives. dm-zoned can easily support non power of 2 zone size as long
>> as ZC == ZS for all zones.
> 
> Great, thanks for the heads up.
> 
>> The problem with dm-zoned is ZC < ZS *AND* potentially variable ZC per
>> zone. That cannot be supported easily (still not impossible, but
>> definitely a lot more complex).
> 
> I see thanks.
> 
> Testing would still be required to ensure this all works well with npo2.
> So I'd prefer to do that as a separate effort, even if it is easy. So
> for now I think it makes sense to avoid this as this is not yet well
> tested.
> 
> As with filesystem support, we've even have gotten hints that support
> for npo2 should be easy, but without proper testing it would not be
> prudent to enable support for users yet.
> 
> One step at a time.

Yes, in general, I agree. But in this case, that will create kernel
versions that end up having partial support for zoned drives. Not ideal to
say the least. So if the patches are not that big, I would rather like to
see everything go into a single release.

-- 
Damien Le Moal
Western Digital Research
