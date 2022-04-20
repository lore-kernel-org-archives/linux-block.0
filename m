Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A40C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 00:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiDTAuX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 20:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiDTAuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 20:50:22 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250F020F76
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650415657; x=1681951657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=11bExQEpZyxZcDwOC/APR7SfTMGk/VNtMKq0WdE+dpE=;
  b=Zvs3bxbt4HpR6yhjJyDxrfwsxbEhAnlbI9fFJ3ZfmYjxbepOagPUX6jz
   bjj1dR4VA9614/LPeGuqmPNVSZnm1yJOWMEKv3Ww/inT64wbsociywyU6
   zUed1Yuxj00TGRo8DUj/egVW7mopgnYmCMIcMV3MSSFzIO0OuxPn2PKDl
   WwveSTfu25nTmrRYrf7Li5brh9eL1xNoNqAcjVq1Lqf7QOFdoFOM3TjUW
   dFB0qmWWGKZ2gKU5/TRgWwaL/WGT4iW0HeHOkREm/Cmv6iIa4+77c9q3Q
   /byKUR30qhlp6YsYpNaRyp/3pbM2fmw//N+heB6X3dNSSLwJ3A02A6XaW
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="310283233"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 08:47:37 +0800
IronPort-SDR: QI2o+/I+5PytaUjqk15CLyPk/jpwVWVRL2Gd6RZGb1WDWozWSt3etzNaGHpSNtrtkuSuM8bUBf
 qEddw1X4KZyWpiie60OpEBnqZ2y8FXi85PnQKyS104xK65FmdNlKGvvXq3IJIghUqCi8M3RigK
 LSNa1QBOk29yY/eoj51ND/MpaQAB2hgadrZYC3i0R+A3FjRBX8Bf/Kq8LIlDJCCMXQtJ099MC3
 GmcPu9ip+V/OomiHFVJwhi1t1FsNMdYmtrpAETf/x1Zjeom0IxElzh4jV5urQF4uV6B08KMHA6
 /p3oR/AL8sk84gZUwAuAbHd0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:18:42 -0700
IronPort-SDR: CzeE8YJUCjSPdu+rZ4FZ/IAvA7phwWYsUqJCvZa592eruShjc6zjN1Viql2LwO5Wz3C8IFi7zo
 bmWR/mC+nLTMbzl+Klwe8BWwPKR7oS4BoZK76uRoQTjXbDBhmWm8FY4Y66rQOHQZdGvygnzjQo
 aNGTUJkM/oncNoDefPkwps8izTuVAK0D+qpF3ZGTkcDMm2qsONWwjWsxy7ngkr++plh2DmpeNo
 0BczSuTspc8afD+SGXdLVUU9kA4gtfv5IRITKcdfydHkC3nDDAAgTP6uLHIEZgJFlrGGIGF2I1
 qg0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:47:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kjhpd0qQvz1SHwl
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:47:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650415656; x=1653007657; bh=11bExQEpZyxZcDwOC/APR7SfTMGk/VNtMKq
        0WdE+dpE=; b=ES/VOc9KM5IrMDAWdbCPNNi/MOs+8f3zenpx5JLDyGa8tHCXzW9
        oYPfgs98TKed1PiZA/GH4wSqOvFxTMKVpE9yL2WAWhL9rSw2GJLtgtCVCBetB1Ie
        3/NPjBZt0PtED2F7TiUDigMK9c2+N4aQI5Aq1iyzGyZll9JAyFro6nit5BfIXdm3
        8B4NBSDJ86t6/XEpaUjfjCGfco6SFFTTirVzB2nfp0efP55fnrllQR8NAaeqeSTF
        GykuAsdZi6y8bvWAgjY/i/Ow2zWc52WLqmBONixJR0z5oPBT3Nsflc4u77wHmqb7
        JhaSn/tkfI6yFT0BxGvj6p3J6o4/Xys/fZg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id buMbb2UL97Pj for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 17:47:36 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kjhpb56vVz1Rvlx;
        Tue, 19 Apr 2022 17:47:35 -0700 (PDT)
Message-ID: <f8092a23-f346-8ee3-796f-2752b581dd00@opensource.wdc.com>
Date:   Wed, 20 Apr 2022 09:47:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] block: null_blk: Improve device creation with
 configfs
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
 <20220419110038.3728406-5-damien.lemoal@opensource.wdc.com>
 <03583c5a-00fb-a6a0-9021-592f61c17d91@kernel.dk>
 <c25455bf-a929-95cb-41f8-c8ee4f6b0d62@opensource.wdc.com>
 <b752fcdd-9be4-549c-39b2-9c1034a97a39@opensource.wdc.com>
 <82e7beea-1ce9-7bec-5d75-577614564bca@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <82e7beea-1ce9-7bec-5d75-577614564bca@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/22 09:17, Jens Axboe wrote:
> On 4/19/22 5:13 PM, Damien Le Moal wrote:
>> On 4/20/22 05:58, Damien Le Moal wrote:
>>> On 4/19/22 20:55, Jens Axboe wrote:
>>>> On 4/19/22 5:00 AM, Damien Le Moal wrote:
>>>>> Currently, the directory name used to create a nullb device through
>>>>> sysfs is not used as the device name, potentially causing headaches for
>>>>> users if devices are already created through the modprobe operation
>>>>> withe the nr_device module parameter not set to 0. E.g. a user can do
>>>>> "mkdir /sys/kernel/config/nullb/nullb0" to create a nullb device while
>>>>> /dev/nullb0 wasalready created from modprobe. In this case, the configfs
>>>>                 ^^^
>>>>
>>>> space
>>>
>>> Re-sending to fix this. Also realized that using "#define pr_fmt" would
>>> simplify patch 3. Updating that.
>>>
>>>>
>>>>> nullb device will be named nullb1, causing confusion for the user.
>>>>>
>>>>> Simplify this by using the configfs directory name as the nullb device
>>>>> name, always, unless another nullb device is already using the same
>>>>> name. E.g. if modprobe created nullb0, then:
>>>>>
>>>>> $ mkdir /sys/kernel/config/nullb/nullb0
>>>>> mkdir: cannot create directory '/sys/kernel/config/nullb/nullb0': File
>>>>> exists
>>>>>
>>>>> will be reported to th user.
>>>>>
>>>>> To implement this, the function null_find_dev_by_name() is added to
>>>>> check for the existence of a nullb device with the name used for a new
>>>>> configfs device directory. nullb_group_make_item() uses this new
>>>>> function to check if the directory name can be used as the disk name.
>>>>> Finally, null_add_dev() is modified to use the device config item name
>>>>> as the disk name for new nullb device, for devices created using
>>>>> configfs. The naming of devices created though modprobe remains
>>>>> unchanged.
>>>>>
>>>>> Of note is that it is possible for a user to create through configfs a
>>>>> nullb device with the same name as an existing device. E.g.
>>>>
>>>> This is nice, and solves both the confusing part of having
>>>> pre-configured devices, but also using the actual directory name as the
>>>> device name even if they are not ordered.
>>>>
>>>> Only odd bit is you can create a device name where a special file of
>>>> that name already exists, but I don't think that's solvable in a clean
>>>> way and we just need to ignore that. That's arguably a user error, don't
>>>> pick names that already exist.
>>>
>>> Yes. add_disk() will fail if the device name already exist within the
>>> "block" device class, but will not complain about anything if the existing
>>> device belongs to another class.
>>>
>>> I could add a "block" class wide check for device name existence in
>>> null_find_dev_by_name() instead of only checking the nullb list ?
>>
>> Looked into this, but I do not see any easy ready-to-use way to do it
>> since "struct class block_class" is not exported. And I would not wnat
>> to export this block/dev internal symbol.
>>
>> We could play with vfs_stat() to test for device existence, but that
>> is a little ugly...
> 
> Eek no, let's not go that far!
> 
>> What about simply enforcing a name pattern like "nullb*" for the
>> configfs directory/device names ? That is simple and the current
>> nullb_find_dev_by_name() will keep working as is.
> 
> That might break existing use cases. I say just leave it alone. If you
> pick a name that already exists in /dev, then too bad for you.
> 
> What I cared most about fixing here was situation of having an empty
> directory and being able to mkdir nullb0 when that was already assigned.
> And that's fixed with your patches.
> 

OK. Works for me.
Sending v2 with the cleanups in path 3 and patch 4 commit message.
Thanks.

-- 
Damien Le Moal
Western Digital Research
