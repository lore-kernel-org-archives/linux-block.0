Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8107AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 08:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbiD0InD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 04:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiD0InC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 04:43:02 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548E073069
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651048790; x=1682584790;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BBQFsViULJsmXc7pr1BgoYOe45lZHCaliutv8MGXYyA=;
  b=pPed2QjgPEkMTjVQMEScr696TIJjJoihAQQ50oPMrmzI87FsIz8rgA2Q
   GLOoILt520kwlIMz8YRrNqpEBqcOvKwf+TUzkx/cNqzdmqKL2ldP8TrA6
   m/RxzMq9pERLpOheVJCO8i4NbYAds4h6WcIfctxOjvy2mfiaG/74MINxQ
   Gjxf8sUZ82UOpumwjI0v8+hfutDitT9KFipJkevZKBUsq9cT7JADco8jA
   V6DHHivdqtgNgRy/lXwkN3QaZIV9V4BtQZpQwMzqJHOSAt2KOOz1C2b6z
   NOt2Fdahl4uJXd1Jil+kJO9m8mlDwDgw9xbXeKFb7D1IYRmqvX8Evq1lR
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="198937689"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 16:39:50 +0800
IronPort-SDR: 5dHexSSn+7udcUdHSY66E/o5pPBneP8tbitG7dftSdURBxleHuKYWTIZPcsN7VoCw1yAwHykBQ
 BT+HL2k6fZgfz5p/YMFMHrv14rpsR8ULjGMBdbJ5lNhi91zRc9opGQIUmCTwH1GHzhPRrEr8EX
 KMtwbqZlFLvEWkMa5oqnfLimMRxBhxqQvEwMvbHLai1Dq12IgQ2CDvxWL0QsR4FAec3h3y6TAx
 +N92/Zt/P1OEzT32dmaUtrnMurC0fMWk2WrD9uEj46e7So4lJ+R5K/+RqMiA47WGea71RWH+Ef
 m1qXfFnk9izHTIqJJ+iySJ1K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 01:10:44 -0700
IronPort-SDR: Jkyda33M2lESRE0PAxerBzCYIJOCZ2xjm9j7a9a+p2fpRbJtnXTsgrs13yiyRTiug1Zr+NioO8
 27Z6njufk+W2o2g7NYqcm2Ecwch/Xq6bZhgoxh4ACaTMtv8vlvZIVMkrOmQi2CO4ee0h0VpPp9
 3boUwRWYqKDRZG72nreUoOG6BXXYduTGmDjpxgQlyAaOFOXv9asHsEWGZH6/cktVLWsyfjkcwZ
 9POgKscIRoV51jxbck1y77qLKiXiAbqqtLi9m44cir4GFP/NUae0/orTobWQisgRngL3FCCMIL
 rNI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 01:39:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpByH0p8nz1SVp0
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 01:39:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651048789; x=1653640790; bh=BBQFsViULJsmXc7pr1BgoYOe45lZHCaliut
        v8MGXYyA=; b=mZIoBi2F/Yp+cyQd0ejAzFMb5CLoEixIXc54FZriL3fIkuwlzyt
        Il/IEnBZlLDiQI/X2cg0RKbq5OUs3C1hoO/c835pQbEbrIEiqcDEzcOUhxbu1Emj
        Tqlghi7wemFnxfZONhWD2qSYkFCNt+Acfy5Nhu/wnZgoLXO0CrTL9Vz0VSQbjRrj
        Pyt7YuEYU+Q3dzTTt2B5Ss7/UMEexNFNO2AMACPiNTj26YR6W61c45K5aZLMWQKu
        raVAmYOrbMLPANKWBAnNrKtXyuTS5YxlvTIaItSx7cr/tLmDnY77WucYubjE2D/F
        Q3AdWxum3DD2x262z4+gYtka9wAF7kIZ6OQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iFOE7NkVPyjR for <linux-block@vger.kernel.org>;
        Wed, 27 Apr 2022 01:39:49 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpByD2vBYz1Rvlc;
        Wed, 27 Apr 2022 01:39:48 -0700 (PDT)
Message-ID: <a57a8b0a-f5fd-6925-89e4-68b90ea5d387@opensource.wdc.com>
Date:   Wed, 27 Apr 2022 17:39:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Content-Language: en-US
To:     Klaus Jensen <its@irrelevant.dk>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220420055429.t5ni7yah4p4yxgsq@shindev>
 <YmGbo5Pvv9bOMqmt@bombadil.infradead.org>
 <20220427050825.rkn633nevijh3ux5@shindev> <YmjzrLo0/zW3Ou03@apples>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YmjzrLo0/zW3Ou03@apples>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/22 16:41, Klaus Jensen wrote:
> On Apr 27 05:08, Shinichiro Kawasaki wrote:
>> On Apr 21, 2022 / 11:00, Luis Chamberlain wrote:
>>> On Wed, Apr 20, 2022 at 05:54:29AM +0000, Shinichiro Kawasaki wrote:
>>>> On Apr 14, 2022 / 15:02, Luis Chamberlain wrote:
>>>>> Hey folks,
>>>>>
>>>>> While enhancing kdevops [0] to embrace automation of testing with
>>>>> blktests for ZNS I ended up spotting a possible false positive RCU stall
>>>>> when running zbd/006 after zbd/005. The curious thing though is that
>>>>> this possible RCU stall is only possible when using the qemu
>>>>> ZNS drive, not when using nbd. In so far as kdevops is concerned
>>>>> it creates ZNS drives for you when you enable the config option
>>>>> CONFIG_QEMU_ENABLE_NVME_ZNS=y. So picking any of the ZNS drives
>>>>> suffices. When configuring blktests you can just enable the zbd
>>>>> guest, so only a pair of guests are reated the zbd guest and the
>>>>> respective development guest, zbd-dev guest. When using
>>>>> CONFIG_KDEVOPS_HOSTS_PREFIX="linux517" this means you end up with
>>>>> just two guests:
>>>>>
>>>>>   * linux517-blktests-zbd
>>>>>   * linux517-blktests-zbd-dev
>>>>>
>>>>> The RCU stall can be triggered easily as follows:
>>>>>
>>>>> make menuconfig # make sure to enable CONFIG_QEMU_ENABLE_NVME_ZNS=y and blktests
>>>>> make
>>>>> make bringup # bring up guests
>>>>> make linux # build and boot into v5.17-rc7
>>>>> make blktests # build and install blktests
>>>>>
>>>>> Now let's ssh to the guest while leaving a console attached
>>>>> with `sudo virsh vagrant_linux517-blktests-zbd` in a window:
>>>>>
>>>>> ssh linux517-blktests-zbd
>>>>> sudo su -
>>>>> cd /usr/local/blktests
>>>>> export TEST_DEVS=/dev/nvme9n1
>>>>> i=0; while true; do ./check zbd/005 zbd/006; if [[ $? -ne 0 ]]; then echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=$i+1; done;
>>>>>
>>>>> The above should never fail, but you should eventually see an RCU
>>>>> stall candidate on the console. The full details can be observed on the
>>>>> gist [1] but for completeness I list some of it below. It may be a false
>>>>> positive at this point, not sure.
>>>>>
>>>>> [493272.711271] run blktests zbd/005 at 2022-04-14 20:03:22
>>>>> [493305.769531] run blktests zbd/006 at 2022-04-14 20:03:55
>>>>> [493336.979482] nvme nvme9: I/O 192 QID 5 timeout, aborting
>>>>> [493336.981666] nvme nvme9: Abort status: 0x0
>>>>> [493367.699440] nvme nvme9: I/O 192 QID 5 timeout, reset controller
>>>>> [493388.819341] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>>
>>>> Hello Luis,
>>>>
>>>> I run blktests zbd group on several QEMU ZNS emulation devices for every rcX
>>>> kernel releases. But, I have not ever observed the symptom above. Now I'm
>>>> repeating zbd/005 and zbd/006 using v5.18-rc3 and a QEMU ZNS device, and do
>>>> not observe the symptom so far, after 400 times repeat.
>>>
>>> Did you try v5.17-rc7 ?
>>
>> I hadn't tried it. Then I tried v5.17-rc7 and observed the same symptom.
>>
>>>
>>>> I would like to run the test using same ZNS set up as yours. Can you share how
>>>> your ZNS device is set up? I would like to know device size and QEMU -device
>>>> options, such as zoned.zone_size or zoned.max_active.
>>>
>>> It is as easy as the above make commands, and follow up login commands.
>>
>> I managed to run kdevops on my machine, and saw the I/O timeout and abort
>> messages. Using similar QEMU ZNS set up as kdevops, the messages were recreated
>> in my test environment also (the reset controller message and RCU relegated
>> error were not observed).
>>
> 
> Can you extract the relevant part of the QEMU parameters? I tried to
> reproduce this, but could not with a 10G, neither with discard=on or
> off, qcow2 or raw.
> 
>> [  214.134083][ T1028] run blktests zbd/005 at 2022-04-22 21:29:54
>> [  246.383978][ T1142] run blktests zbd/006 at 2022-04-22 21:30:26
>> [  276.784284][  T386] nvme nvme6: I/O 494 QID 4 timeout, aborting
>> [  276.788391][    C0] nvme nvme6: Abort status: 0x0
>>
>> The conditions to recreate the I/O timeout error are as follows:
>>
>> - Larger size of QEMU ZNS drive (10GB)
>>     - I use QEMU ZNS drives with 1GB size for my test runs. With this smaller
>>       size, the I/O timeout is not observed.
>>
>> - Issue zone reset command for all zones (with 'blkzone reset' command) just
>>   after zbd/005 completion to the drive.
>>     - The test case zbd/006 calls the zone reset command. It's enough to repeat
>>       zbd/005 and zone reset command to recreate the I/O timeout.
>>     - When 10 seconds sleep is added between zbd/005 run and zone reset command,
>>       the I/O timeout was not observed.
>>     - The data write pattern of zbd/005 looks important. Simple dd command to
>>       fill the device before 'blkzone reset' did not recreate the I/O timeout.
>>
>> I dug into QEMU code and found that it takes long time to complete zone reset
>> command with all zones flag. It takes more than 30 seconds and looks triggering
>> the I/O timeout in the block layer. The QEMU calls fallocate punch hole to the
>> backend file for each zone, so that data of each zone is zero cleared. Each
>> fallocate call is quick but between the calls, 0.7 second delay was observed
>> often. I guess some fsync or fdatasync operation would be running and causing
>> the delay.
>>
> 
> QEMU uses a write zeroes for zone reset. This is because of the
> requirement that block in empty zones must be considered deallocated.
> 
> When the drive is configured with `discard=on`, these write zeroes
> *should* turn into discards. However, I also tested with discard=off and
> I could not reproduce it.
> 
> It might make sense to force QEMU to use a discard for zone reset in all
> cases, and then change the reported DLFEAT appropriately, since we
> cannot guarantee zeroes then.

Why not punch a hole in the backing store file with fallocate() with mode
set to FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE ? That would be way
faster than a write zeroes which potentially actually do the writes,
leading to large command processing times. Reading in a hole in a file is
guaranteed to return zeroes, at least on Linux.

If the backingstore is a block device, then sure, write zeroes is the only
solution. Discard should be used with caution since that is a hint only
and some drives may actually do nothing.

> 
>> In other words, QEMU ZNS zone reset for all zones is so slow depending on the
>> ZNS drive's size and status. Performance improvement of zone reset is desired in
>> QEMU. I will seek for the chance to work on it.
>>
> 
> Currently, each zone is a separate discard/write zero call. It would be
> fair to special case all zones and do it in much larger chunks.

Yep, for a backing file, a full file fallocate(FALLOC_FL_PUNCH_HOLE) would
do nicely. Or truncate(0) + truncate(storage size) would do too.

Since resets are always all zones or one zone, special optimized handling
of the reset all case will definitely have huge benefits for that command.


-- 
Damien Le Moal
Western Digital Research
