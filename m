Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89E0C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 02:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC862084A
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 02:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nXKsasbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeLQCx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:53:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33474 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeLQCx3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 21:53:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so5405407plo.0
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 18:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YfMkwlIWoHxvmqWW798tQZ/HImcR8LguCgFmN+YP0Bg=;
        b=nXKsasbr9gQGphkT+wck0LPNMPdcr65sQPvN9eMTs7FJeXzn16GZMM1r0hTm5y72np
         DBRh6lzTWqVvYGpvb70a+a3yFkB63TjWJmicMhV5GHPSYBSKSaThYUjIlxwoke3DfE13
         Jj0H9zzXejbH9/aSD0ERQcdqMyce4DB8ExJD+HXInKCrdH47yhmWug4GSPkafOIhZd/N
         4nF0z0SaiZqgLUs1nrqtkisqrfTqr5ZPV7VcGqUuyNR4DHoU/gUADx8yqOjoUoC7Jk7i
         uCfFGh25IpqmHa+KfsqfEOpM8cSwmhJmkx4uQCccpirenKlTbFcf3OlGp/qjMrSTrIUh
         l0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YfMkwlIWoHxvmqWW798tQZ/HImcR8LguCgFmN+YP0Bg=;
        b=VBLTsWOcYVRkXQKastL5j86iFZuw5uh3P6541UYw+Ud1GVtV1EkqzMXxV52M8iud76
         7pFUpG0BHobwG1kGADgs2IEeIlvAZM2zpPO+R99F60Foz0KJQiYnPRYniqXsipE1usMR
         gUAdX4dete+KBS02b5tvnOCVmyEhc6mpHnajnz9VuiJ/yJgPjWfL0srhQj8ueRKdJY/e
         qmQh/OdApqzMklBlrPclgJEDuRKo5LiubfzksfVLPcpZz6C8rhYZx5WbPUSePympTp4R
         FLKtOUr2maWpNKCs+N0/ZD743O5fC/ew5LPXwvLTXCObsjKj2jeDcPBEJoYmgv572Yqc
         X0YQ==
X-Gm-Message-State: AA+aEWZuAuxVV1D+ro8nJIMHJMd4UP2bc2al1hXpC7rgDr0nfwSZ6bGt
        3olSlbrIn9gbeMkJastbxwGg8s+bjDPi1A==
X-Google-Smtp-Source: AFSGD/WH+hv1ogLSFk14nz6LbCMm0efP8RmPMsmCTYFrpAt4DZjEilDnk1kvmqXe+BqFV9Cp3mV8RA==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr11446691plb.332.1545015208343;
        Sun, 16 Dec 2018 18:53:28 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 34sm14109313pgp.90.2018.12.16.18.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 18:53:27 -0800 (PST)
Subject: Re: [PATCH v2] block: update documentation
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20181130053624.1910-1-damien.lemoal@wdc.com>
 <BYAPR04MB5816A9782EC48BDE63A25B56E7A30@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1cb44da8-cb45-cf5d-dfc9-76a87fc12f53@kernel.dk>
Date:   Sun, 16 Dec 2018 19:53:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816A9782EC48BDE63A25B56E7A30@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 4:54 PM, Damien Le Moal wrote:
> Jens,
> 
> On 2018/11/30 14:36, Damien Le Moal wrote:
>> Add the description of the zoned, nr_zones and chunk_sectors sysfs queue
>> attributes to Documentation/block/queue-sysfs.txt. The description of
>> the zoned and chunk_sector attributes are mostly copied from
>> ABI/testing/sysfs-block (added a typo fix). While at it, also fix a
>> typo in the description of the io_poll_delay attribute.
>>
>> nr_zones description is also added to ABI/testing/sysfs-block and
>> contact email address updated for the zoned attribute.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  Documentation/ABI/testing/sysfs-block | 12 +++++++++--
>>  Documentation/block/queue-sysfs.txt   | 29 ++++++++++++++++++++++++++-
>>  2 files changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
>> index dea212db9df3..7710d4022b19 100644
>> --- a/Documentation/ABI/testing/sysfs-block
>> +++ b/Documentation/ABI/testing/sysfs-block
>> @@ -244,7 +244,7 @@ Description:
>>  
>>  What:		/sys/block/<disk>/queue/zoned
>>  Date:		September 2016
>> -Contact:	Damien Le Moal <damien.lemoal@hgst.com>
>> +Contact:	Damien Le Moal <damien.lemoal@wdc.com>
>>  Description:
>>  		zoned indicates if the device is a zoned block device
>>  		and the zone model of the device if it is indeed zoned.
>> @@ -259,6 +259,14 @@ Description:
>>  		zone commands, they will be treated as regular block
>>  		devices and zoned will report "none".
>>  
>> +What:		/sys/block/<disk>/queue/nr_zones
>> +Date:		November 2018
>> +Contact:	Damien Le Moal <damien.lemoal@wdc.com>
>> +Description:
>> +		nr_zones indicates the total number of zones of a zoned block
>> +		device ("host-aware" or "host-managed" zone model). For regular
>> +		block devices, the value is always 0.
>> +
>>  What:		/sys/block/<disk>/queue/chunk_sectors
>>  Date:		September 2016
>>  Contact:	Hannes Reinecke <hare@suse.com>
>> @@ -268,6 +276,6 @@ Description:
>>  		indicates the size in 512B sectors of the RAID volume
>>  		stripe segment. For a zoned block device, either
>>  		host-aware or host-managed, chunk_sectors indicates the
>> -		size of 512B sectors of the zones of the device, with
>> +		size in 512B sectors of the zones of the device, with
>>  		the eventual exception of the last zone of the device
>>  		which may be smaller.
>> diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
>> index 2c1e67058fd3..39e286d7afc9 100644
>> --- a/Documentation/block/queue-sysfs.txt
>> +++ b/Documentation/block/queue-sysfs.txt
>> @@ -64,7 +64,7 @@ guess, the kernel will put the process issuing IO to sleep for an amount
>>  of time, before entering a classic poll loop. This mode might be a
>>  little slower than pure classic polling, but it will be more efficient.
>>  If set to a value larger than 0, the kernel will put the process issuing
>> -IO to sleep for this amont of microseconds before entering classic
>> +IO to sleep for this amount of microseconds before entering classic
>>  polling.
>>  
>>  iostats (RW)
>> @@ -194,4 +194,31 @@ blk-throttle makes decision based on the samplings. Lower time means cgroups
>>  have more smooth throughput, but higher CPU overhead. This exists only when
>>  CONFIG_BLK_DEV_THROTTLING_LOW is enabled.
>>  
>> +zoned (RO)
>> +----------
>> +This indicates if the device is a zoned block device and the zone model of the
>> +device if it is indeed zoned. The possible values indicated by zoned are
>> +"none" for regular block devices and "host-aware" or "host-managed" for zoned
>> +block devices. The characteristics of host-aware and host-managed zoned block
>> +devices are described in the ZBC (Zoned Block Commands) and ZAC
>> +(Zoned Device ATA Command Set) standards. These standards also define the
>> +"drive-managed" zone model. However, since drive-managed zoned block devices
>> +do not support zone commands, they will be treated as regular block devices
>> +and zoned will report "none".
>> +
>> +nr_zones (RO)
>> +-------------
>> +For zoned block devices (zoned attribute indicating "host-managed" or
>> +"host-aware"), this indicates the total number of zones of the device.
>> +This is always 0 for regular block devices.
>> +
>> +chunk_sectors (RO)
>> +------------------
>> +This has different meaning depending on the type of the block device.
>> +For a RAID device (dm-raid), chunk_sectors indicates the size in 512B sectors
>> +of the RAID volume stripe segment. For a zoned block device, either host-aware
>> +or host-managed, chunk_sectors indicates the size in 512B sectors of the zones
>> +of the device, with the eventual exception of the last zone of the device which
>> +may be smaller.
>> +
>>  Jens Axboe <jens.axboe@oracle.com>, February 2009
>>
> 
> Ping...
> 
> As Johannes suggested, you may also want to update your email address (I did not
> do so as this is somewhat personal information).

Thanks, added. I'll see if I can remember to update that part...

-- 
Jens Axboe

