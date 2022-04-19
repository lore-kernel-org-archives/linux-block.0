Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C22CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 23:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355423AbiDSXQf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 19:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiDSXQe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 19:16:34 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09202E082
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650410029; x=1681946029;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=7wLQ0a2FLwAooVGa4Vz8X9/mIdSf34uTpY8paj9VBuY=;
  b=IX9wWg2pY1krEy5Xd9SeHVjWOf9+70IcPM8YS6kXw6JC0SU8hn2s3WEi
   sLgn35DYohQIykg5L9K75NzakHK85ZjX9wdZotvG3p7pp22If/JaK1vBa
   o0hqdI6ykrha9zNssuXj1bgO8gyvfIQ1e0dwtGR7DUsphY/QAcM/QmN0c
   FTmjze3hnwZOVvxAR1mDxUTOpujVmw5Dibi5jDhWvea34RyMKYjYY5bxc
   qY3x0nvHitt69s4bZmALLD2MhK4zvt3nAg4Apyl06wEfvZtSHbqwOqA+Z
   SAeBONpXmaVTvgtmtMpWBCA486evxYqhy1ZRxpQ8Wnl4YyjN3nlX66MfM
   g==;
X-IronPort-AV: E=Sophos;i="5.90,273,1643644800"; 
   d="scan'208";a="197163278"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 07:13:48 +0800
IronPort-SDR: gFpwwjogF7lInkzdGasR1GdXdMK4RXp94nbiiia/ZGYxWceIB9V6pT7caAN+Foz3ppWvk0GFCN
 ci1bfC99OFnOHZCE3gKp5ec96u2GMDTxkAx4zY5EbiKcxXlnG3E/37PQYn5oJauShtR7nnx6d0
 n+I2mRuYRsaSKBZwmAW3Suvk4/6b9fUKDDTXlJ8kyoto7pd/7YETIe58TuAN5bGORSrY8q7fC4
 /lt1o92sMtLL3WsWOwkKc5CxaCFRhQMQUu+TOYBGsn1QrOb7MiLfinZg4mDLyuc9VbX/2RmVCc
 8/4yXnyy/heIil6okDEqqivx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 15:44:07 -0700
IronPort-SDR: mA/Bqo0VKNCx97DD0H0K15gmCfa+fvmXNc/r1Ag2KfI7hFpHl85EQqgxLeQnxvBT3vJWml+jq+
 rGY0V3o12V0rLyFnbELbYYSW4Kc9RjUP172x7Ig45FjiROmXEoVZHeJkBl8jmBH2GItsMxddXW
 DkfH0Xj8Me0PyZdhxj618g3qjv13/fQ4k3slC0yOfb5pPv59PVbNXSjusnkHPWLpYmgxNkhieV
 iNKZ9wCDHITkTgRea5dEuL5H+YNHzRRke0ql3u6ewDEOwEiDFd6Kyid2aft0NdCjileUYtwrUa
 rmU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 16:13:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjfkN3ZBpz1SHwl
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 16:13:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650410028; x=1653002029; bh=7wLQ0a2FLwAooVGa4Vz8X9/mIdSf34uTpY8
        paj9VBuY=; b=sofYTR5HC7j0HW3UeE7OFIMcm3cJQxJ1Yw0SlA/AWjnAXY6yCeR
        MHk41/fKKlhunOE3XRn0QHyxmZBUD2wGWiefE2PL3EGG/kdGOkUG8Rpsi4myyD2X
        Ld0BwDsMGpGilfB629oFrnFVMSzGZLffZfHI4wTs+Q8zMsuYoN9vi/slJRmmuW2i
        gq/GLl4hqAB69bKnRJ7bJqztyXe0txVUYyl0w9rg+vdhwQhgqlOUKYVFjsRJAuY9
        6FPgVNypWbMT8QVzbLWatmFI0wR8do4c5PVyNVt8SLikLLf41E0dwaL/YzLrOx6x
        oUHYELdiNDjzBxuY4A1zUyYBOOI1b3TJXEQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Af96jYziSI-z for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 16:13:48 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjfkM170Jz1Rvlx;
        Tue, 19 Apr 2022 16:13:46 -0700 (PDT)
Message-ID: <b752fcdd-9be4-549c-39b2-9c1034a97a39@opensource.wdc.com>
Date:   Wed, 20 Apr 2022 08:13:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] block: null_blk: Improve device creation with
 configfs
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
 <20220419110038.3728406-5-damien.lemoal@opensource.wdc.com>
 <03583c5a-00fb-a6a0-9021-592f61c17d91@kernel.dk>
 <c25455bf-a929-95cb-41f8-c8ee4f6b0d62@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c25455bf-a929-95cb-41f8-c8ee4f6b0d62@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/22 05:58, Damien Le Moal wrote:
> On 4/19/22 20:55, Jens Axboe wrote:
>> On 4/19/22 5:00 AM, Damien Le Moal wrote:
>>> Currently, the directory name used to create a nullb device through
>>> sysfs is not used as the device name, potentially causing headaches for
>>> users if devices are already created through the modprobe operation
>>> withe the nr_device module parameter not set to 0. E.g. a user can do
>>> "mkdir /sys/kernel/config/nullb/nullb0" to create a nullb device while
>>> /dev/nullb0 wasalready created from modprobe. In this case, the configfs
>>                 ^^^
>>
>> space
> 
> Re-sending to fix this. Also realized that using "#define pr_fmt" would
> simplify patch 3. Updating that.
> 
>>
>>> nullb device will be named nullb1, causing confusion for the user.
>>>
>>> Simplify this by using the configfs directory name as the nullb device
>>> name, always, unless another nullb device is already using the same
>>> name. E.g. if modprobe created nullb0, then:
>>>
>>> $ mkdir /sys/kernel/config/nullb/nullb0
>>> mkdir: cannot create directory '/sys/kernel/config/nullb/nullb0': File
>>> exists
>>>
>>> will be reported to th user.
>>>
>>> To implement this, the function null_find_dev_by_name() is added to
>>> check for the existence of a nullb device with the name used for a new
>>> configfs device directory. nullb_group_make_item() uses this new
>>> function to check if the directory name can be used as the disk name.
>>> Finally, null_add_dev() is modified to use the device config item name
>>> as the disk name for new nullb device, for devices created using
>>> configfs. The naming of devices created though modprobe remains
>>> unchanged.
>>>
>>> Of note is that it is possible for a user to create through configfs a
>>> nullb device with the same name as an existing device. E.g.
>>
>> This is nice, and solves both the confusing part of having
>> pre-configured devices, but also using the actual directory name as the
>> device name even if they are not ordered.
>>
>> Only odd bit is you can create a device name where a special file of
>> that name already exists, but I don't think that's solvable in a clean
>> way and we just need to ignore that. That's arguably a user error, don't
>> pick names that already exist.
> 
> Yes. add_disk() will fail if the device name already exist within the
> "block" device class, but will not complain about anything if the existing
> device belongs to another class.
> 
> I could add a "block" class wide check for device name existence in
> null_find_dev_by_name() instead of only checking the nullb list ?

Looked into this, but I do not see any easy ready-to-use way to do it
since "struct class block_class" is not exported. And I would not wnat to
export this block/dev internal symbol.

We could play with vfs_stat() to test for device existence, but that is a
little ugly...

What about simply enforcing a name pattern like "nullb*" for the configfs
directory/device names ? That is simple and the current
nullb_find_dev_by_name() will keep working as is.


-- 
Damien Le Moal
Western Digital Research
