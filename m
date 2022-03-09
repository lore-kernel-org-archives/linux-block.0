Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A4C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 21:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiCIVox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiCIVow (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 16:44:52 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3611E3C6
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 13:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646862231; x=1678398231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UOCaRwRejX2MRt5Kznnykwz4zyvkKUYyeuiz314ZHuc=;
  b=PstifnziAIS7/wYch8rb6PAoSv2O9QeDsMGP7Z6KeC03hsJSD8kJuwpJ
   ZKAnt9pjEdHGwUHHFQurL+XL45Ef3/46JvLDk2c19M5wfDBP1zOf8mY3Q
   6FwxrUfCl0yYoIWjVLkGlX3bhi0I0Aka3+y8dhHhhhD+Stw5eyc+QrRFr
   9nNuTtkC7glW/NK/mQLHBzCJ5heSl828Qv6tZ5n/JDd06yVlWJGpH1OfI
   L2RZhNsyKrTbmt9kBleqpGuQjrqzZ/FI5OlSOJ7MctoJ7IcwaZvbfh34B
   x6+CVzMcUtw+zV8tcmTmusr0pufTCldjFtpkVGQhMi8P7zZfPK49tVfZ8
   A==;
X-IronPort-AV: E=Sophos;i="5.90,168,1643644800"; 
   d="scan'208";a="194893767"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 05:43:51 +0800
IronPort-SDR: DsW/XX9FKx6GRNobM9ppfU3jclKmEcVp4QOq8XD2xmzGAa+S86hb+1pvp55oBf292vZLV0neuQ
 feiikC99Sg8TbkPJX7tbAqb9zGqrJsqJK8XuTTsGgG4TxADZDIQldQWUp7mEAJx+rMRky/ztV4
 7erEN7xxt4TLKPciuwSzYHWaczOKkHmGvdhWEtRwQrqk6ibDCw7R9OFxWLIa4aoxRTjF7FhmCz
 BbT5bId+stRHtOQ5O6oROK05V4td96gZyaBNzlERt7TuvzBIdRZ7IKY5JdAkKFeRX8lSdKHvTY
 nZjklLwcipcCyOM+EvAJUsXv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 13:16:08 -0800
IronPort-SDR: Yu4sefH4ljoCIE8fuELVHAaows40OZiHgr/z3KW0UY4CX9p5/bDY/byjX11cGZfWVsQumbBe7e
 gugsu6Y1UgMdoMTfi2rMdGk4RIrzUpkWL1R9a7WTsLItnFRnPIPZqahjOk2Ude6yCH8ATzlRmm
 1VbJZak/5ZamAYrby2GcH+Z54PMU44ek/y4682coYMTUaqjFQDxEj3aYooeT9JAIlbC2yisErj
 nN8IrsLjIpaiYrWUoEOnbU3hSvtEK+Rfe2P6gxE3W8Jq01HRc6UR6tNJ2f+KQlexobUyk3aPtd
 CrY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 13:43:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KDQgX4gXqz1SVp3
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 13:43:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646862231; x=1649454232; bh=UOCaRwRejX2MRt5Kznnykwz4zyvkKUYyeui
        z314ZHuc=; b=OrKRk04VdQjcp4cBqOeoeTG+SknDdGAhlc1vdJsxcgcUAkWWOOS
        v//pN74y8/OiWDRIMFpUl8KyrNrTBBFcfW4nxdBw9mX7oZXULbAYXBKyNinQoyqc
        KzQuX/EQso1djgS68tQKshxZeL2ettHmwZiOAB/+ss0XIarXYJw2jNwKHLrmHqWs
        QJXoE5NnAjEpRm9lYmBy5guFKlWnAPzPsF1D4nBNKBw8gom8Ut4bjfRDCM5m1+BZ
        89iFKbQikWXDLzSFqBIvx46sPmBNUyQKddEiJAyv/G6MPLFo3VE2f5itUh0wUn3L
        JelQitTKJJCijuMjJ0fRchxCoJKKlXKsXtw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rIK_rqvIaUBl for <linux-block@vger.kernel.org>;
        Wed,  9 Mar 2022 13:43:51 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KDQgT0yxcz1Rvlx;
        Wed,  9 Mar 2022 13:43:48 -0800 (PST)
Message-ID: <bdb92eac-59ef-3ba1-16cb-31219e3a264b@opensource.wdc.com>
Date:   Thu, 10 Mar 2022 06:43:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/6] nvme: zns: Add support for power_of_2 emulation to
 NVMe ZNS devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160@eucas1p1.samsung.com>
 <20220308165349.231320-5-p.raghav@samsung.com>
 <d13c40a5-3f87-fb2c-155e-dd64535067ac@opensource.wdc.com>
 <cf527b75-8fba-96ba-659d-fbb46fbe9de7@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <cf527b75-8fba-96ba-659d-fbb46fbe9de7@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/22 23:33, Pankaj Raghav wrote:
> 
> 
> On 2022-03-09 05:04, Damien Le Moal wrote:
>> On 3/9/22 01:53, Pankaj Raghav wrote:
>  
>> Contradiction: reducing the impact of performance regression is not the
>> same as "does not create a performance regression". So which one is it ?
>> Please add performance numbers to this commit message.
> 
>> And also please actually explain what the patch is changing. This commit
>> message is about the why, but nothing on the how.
>>
> I will reword and add a bit more context to the commit log with perf numbers
> in the next revision
>>> +EXPORT_SYMBOL_GPL(nvme_fail_po2_zone_emu_violation);
>>> +
>>
>> This should go in zns.c, not in the core.
>>
> Ok.
> 
>>> +
>>> +static void nvme_npo2_zone_setup(struct gendisk *disk)
>>> +{
>>> +	nvme_ns_po2_zone_emu_setup(disk->private_data);
>>> +}
>>
>> This helper seems useless.
>>
> I tried to retain the pattern with report_zones which is currently like this:
> static int nvme_report_zones(struct gendisk *disk, sector_t sector,
> 		unsigned int nr_zones, report_zones_cb cb, void *data)
> {
> 	return nvme_ns_report_zones(disk->private_data, sector, nr_zones, cb,
> 			data);
> }
> 
> But I can just remove this helper and use nvme_ns_po2_zone_emu_setup cb directly
> in nvme_bdev_fops.
> 
>>> +
>>>  /*
>>>   * Convert a 512B sector number to a device logical block number.
>>>   */
>>>  static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
>>>  {
>>> -	return sector >> (ns->lba_shift - SECTOR_SHIFT);
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +	return ns->sect_to_lba(ns, sector);
>>
>> So for a power of 2 zone sized device, you are forcing an indirect call,
>> always. Not acceptable. What is the point of that po2_zone_emu boolean
>> you added to the queue ?
> This is a good point and we had a discussion about this internally.
> Initially I had something like this:
> if (!blk_queue_is_po2_zone_emu(disk))
> 	return sector >> (ns->lba_shift - SECTOR_SHIFT);
> else
> 	return __nvme_sect_to_lba_po2(ns, sec);

No need for the else.

> 
> But @Luis indicated that it was better to set an op which comes at a cost of indirection
> instead of having a runtime check with a if/else in the **hot path**. The code also looks
> more clear with having an op.

The indirect call using a function pointer makes the code obscure. And
the cost of that call is far greater and always present compared to the
CPU branch prediction which will luckily avoid most of the time taking
the wrong branch of an if.

> 
> The performance analysis that we performed did not show any regression while using the indirection
> for po2 zone sizes, at least on the x86_64 architecture.
> So maybe we could use this opportunity to discuss which approach could be used here.

The easiest one that makes the code clear and easy to understand.



-- 
Damien Le Moal
Western Digital Research
