Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8F7C43217
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 10:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKBKHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 06:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKBKHQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 06:07:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1228324082
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667383634; x=1698919634;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JCX4B4TGkjLJ3lQDVKPLvWo4xblaY/2CTtdZ/PqgQVk=;
  b=kASU/gV3L/Km/S4UjRhxraJSs0+pW1PWWBsDPs5z/lpCTjqtGu1Bc098
   kmFD2mJZ9J1tyzH5awelU1kbjuhg3TECFgTfl87T39u7C8TbVol3L/TSv
   bIeEt08nYrY1dmDXWPMKswjn2XDQk3LsoVavPphPnsw8ymmafOibKAOUb
   XuuPgRGjgYmmYn6vxnQIJX1hqEl+MfFMb+fmlcPQYerWSo1WVaeqZhgKe
   NuIEiuucj8Lc6I1UmsZtkX6UWaQqr8mHX2XAMKsP/g35DvCxsERvRi9De
   zC6WXdfgIG34+YAxWOeIhpAwZEIjWT2m1j+xLnJMEqZscS/RELVNZlKwC
   A==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="213591751"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 18:07:14 +0800
IronPort-SDR: bw7fw8vXYKJcuWsfGQC6g3ZogENqRTRnyX94lgiP2XLCNAKf3YopDc3WOpHgbUSGHNbSjSeVJH
 bYyYacNwL1rPE1rANtIHtpFpy2tcVZ6JAmmJ+c4ROSXgz3T5tUyezSY5+kTf5asgqwr1mzFEB3
 tDec2dKvxdcvfK1psXqA/2vI8/DcplC1PkjCU4wWKqF91K65TBO9fcqQH4PVGi/e3jppjQcyvR
 txhBNg8RnyyIOu72mMt7JZ+i1FjOFrbq+/nUkWEdADn4qq/wRTKpevlbkfaape9ZOuR/5iXYOb
 8Q7nii0EH6H812Nx7HW1WfXV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 02:26:28 -0700
IronPort-SDR: OO174g9pd+4JhIBtDzvsuQhsbMm0+w/x7oec/CBERGqWYQ7+/rBSu2xyqhD/mdkfi+dhxV+Iul
 +o/Dpe/JmKkiN4IqCskqp+0wFdAse8632LN8Iqc3Ms9wARwynBuTRzaPFhxRXVKR56ujqdjWfw
 W9nQnNK3h32rtyLh4j8XqoBlfMszVWvhWS1x8YuxijeOgQB82BPVPe4LxZ0BUWVc6/ipKjOAMY
 3EtQp4I118/pvcwjTKtM6rAfqH56md0bXOK8ISDrNidfZ5JG2EGuWHc8DSrxcJGDvcUQhQBUJB
 ZTc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 03:07:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N2Mxs4BFpz1Rwtm
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 03:07:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667383631; x=1669975632; bh=JCX4B4TGkjLJ3lQDVKPLvWo4xblaY/2CTtd
        Z/PqgQVk=; b=enw5S1jfA1UIbRfoqOQnFzAVaShXYf6niQN0V4yRV16dPpPUOG7
        D9Cum052+X+M+icWV+U5guVp7wmrSu+09dYCcYKk/njpvgsIwxpIWxRCBaJFqzP5
        R72CGhP1d3vVOU28MT7QQkk7ZseNi/5zWvodB1BUiqWjZBDiNaPGdnVNSMi5me4M
        zNIfFlsJ3DVW4LTLLHM6wrkpZ9P3P2i8AZ7a+baz/FFQhnjiNJ3dwh846ZNFsSgh
        fXCXTO1mUwncobwtHp1j6lYVmorrS8AAwoy1GkihaA7YG/kDogjOikkKbNS0/ae9
        L1fPxRRUQNAFMkVRTR6azX17Tb7WVA//YeA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ovbYkYz7WASf for <linux-block@vger.kernel.org>;
        Wed,  2 Nov 2022 03:07:11 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N2Mxm3H54z1RvTp;
        Wed,  2 Nov 2022 03:07:07 -0700 (PDT)
Message-ID: <ff0c2ab7-8e82-40d9-1adf-78ee12846e1f@opensource.wdc.com>
Date:   Wed, 2 Nov 2022 19:07:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, john.garry2@mail.dcu.ie
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <9a2f30cc-d0e9-b454-d7cd-1b0bd3cf0bb9@opensource.wdc.com>
 <0e60fab5-8a76-9b7e-08cf-fb791e01ae08@huawei.com>
 <71b56949-e4d7-fd94-c44a-867080b7a4fa@opensource.wdc.com>
 <b03b37a2-35dc-5218-7279-ae68678a47ff@huawei.com>
 <0e4994f7-f131-39b0-c876-f447b71566cd@opensource.wdc.com>
 <05cf6d61-987b-025d-b694-a58981226b97@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <05cf6d61-987b-025d-b694-a58981226b97@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/22 18:52, John Garry wrote:
> Hi Damien,
> 
>>>>>
>>>>> Please also note that for AHCI, I make reserved depth =1, while for SAS
>>>>> controllers it is greater. This means that in theory we could alloc > 1x
>>>>> reserved command for SATA disk, but I don't think it matters.
>>>> Yes, 1 is enough. However, is 1 reserved out of 32 total, meaning that
>>>> the
>>>> user can only use 31 tags ? or is it 32+1 reserved ? which we can do
>>>> since
>>>> when using the reserved request, we will not use a hw tag (all reserved
>>>> requests will be non-ncq).
>>>>
>>>> The 32 + 1 scheme will work.
>>>
>>> Yes, 32 + 1 is what we want. I now think that there is a mistake in my
>>> code in this series for ahci.
>>>
>>> So I think we need for ahci:
>>>
>>> can_queue = 33 >
>> Hmm.. For ATA, can_queue should be only 32. nr_tags is going to be 33
>> though as we include one tag for a reserved command. No ? (may be I
>> misunderstand can_queue though).
> 
> Yes, we want nr_tags=33. But according to semantics of can_queue, it 
> includes total of regular and reserved tags. This is because tag_set 
> depth is total of regular and reserved tags, and we subtract reserved 
> tags from total depth in blk_mq_init_bitmaps():
> 
> int blk_mq_init_bitmaps(.., unsigned int queue_depth, unsigned int 
> reserved, ..)
> {
> 	unsigned int depth = queue_depth - reserved;
> 	...
> 
> 	if (bt_alloc(bitmap_tags, depth, round_robin, node
> 
> 
> So we want a change like this as well:
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index da7ee8bec165..cbcc337055a7 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -390,7 +390,7 @@ extern const struct attribute_group 
> *ahci_sdev_groups[];
>   */
> #define AHCI_SHT(drv_name)                                             \
>         __ATA_BASE_SHT(drv_name),                                       \
> -       .can_queue              = AHCI_MAX_CMDS,                        \
> +       .can_queue              = AHCI_MAX_CMDS + 1,                    \
>         .sg_tablesize           = AHCI_MAX_SG,                          \
>         .dma_boundary           = AHCI_DMA_BOUNDARY,                    \
>         .shost_groups           = ahci_shost_groups,
> 
> I know it seems strange, but still 32 tags will only ever be available 
> for non-internal commands (as it is today) and 1 for ata internal command.
> 
>>
>>> nr_reserved_cmds = 1
>>>
>>> while I only have can_queue = 32
>>
>> Which seems right to me.
>>
>>>
>>> I need to check that again for ahci driver and AHCI SHT...
>>>
>>>> But for CDL command completion handling, we
>>>> will need a NCQ command to do a read log, to avoid forcing a queue drain.
>>>> For that to reliably work, we'll need a 31+1+1 setup...
>>>>
>>>
>>> So is your idea to permanently reserve 1 more command from 32 commands ?
>>
>> Yes. Command Duration Limits has this weird case were commands may be
>> failed when exceeding their duration limit with a "good status" and
>> "sense data available bit" set. This case was defined to avoid the queue
>> stall that happens with any NCQ error. The way to handle this without
>> relying on EH (as that would also cause a queue drain) is to issue an
>> NCQ read log command to fetch the "sense data for successful NCQ
>> commands" log, to retrieve the sense data for the completed command and
>> check if it really failed or not. So we absolutely need a reserved
>> command for this, Without a reserved command, it is a nightmare to
>> support (tag reuse would be another solution, but it is horrible).
>>
>>> Or re-use 1 from 32 (and still also have 1 separate internal command)?
>>
>> I am not yet 100% sure if we can treat that internal NCQ read log like
>> any other read/write request... If we can, then the 1-out-of-32
>> reservation would not be needed. Need to revisit all the cases we need
>> to take care of (because in the middle of this CDL completion handling,
>> regular NCQ errors can happen, resulting in a drive reset that could
>> wreck everything as we lose the sense data for the completed requests).
>>
>> In any case, I think that we can deal with that extra reserved command
>> on top of you current series. No need to worry about it for now I think.
>>
> 
> So are you saying that you are basing current CDL support on libata 
> internally managing this extra reserved tag (and so do not need this 
> SCSI midlayer reserved tag support yet)?

Not really. For now, it is using libata EH, that is, when we need the
internal command for the read log, we know the device is idle and no
command is on-going. So we send a non-NCQ command which does not have a tag.

Ideally, all of this should use a real reserved tag to allow for an NCQ
read log outside of EH, avoiding the drive queue drain.

> 
> Thanks,
> John

-- 
Damien Le Moal
Western Digital Research

