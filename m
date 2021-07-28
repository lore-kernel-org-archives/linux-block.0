Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5ADC4320A
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 05:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E23600EF
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 05:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhG1Fqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 01:46:30 -0400
Received: from cmyk.emenem.pl ([217.79.154.63]:36338 "EHLO smtp.emenem.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233553AbhG1Fq2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 01:46:28 -0400
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (50-78-106-33-static.hfc.comcastbusiness.net [50.78.106.33])
        (authenticated bits=0)
        by cmyk.emenem.pl (8.16.1/8.16.1) with ESMTPSA id 16S5k7Op021289
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 28 Jul 2021 07:46:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
        t=1627451171; bh=TJ7c9I/1mr+DlYx8Sem/2e6n5bqiwg1Bd1VWkY3ZkXY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HzK8YeKPZftNQTnN0ktRRM12q3zhgxnBjfWOOisDekMG4dn8tgabjmtMypnATH8yf
         LVSwiL3xpthXLJzhN1rx860w8zQfTfQsTEaPQwtugNischhqEE3Cq1wu7Fr0ic2cgv
         TaFXvm4ncbkkhpeGTyVAdIw8mbg8SAlMu7+iu67o=
Subject: Re: Commit d5fd456c88aba4fcf77d35fe38024a8d5c814686 - "loopdev: use
 LOOP_CONFIG ioctl" broke loop on x86-64 w/ 32 bit userspace
To:     Jens Axboe <axboe@kernel.dk>,
        Sinan Kaya <sinan.kaya@microsoft.com>,
        Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <a797f527-4599-e986-a326-4bb141487f2c@ans.pl>
 <e7f64d43-2a26-e386-b208-5c35d6a56ed4@ans.pl>
 <7de1bd0b-b8ea-daf0-b677-f92db1c1cdff@ans.pl>
 <c1c9d728-c4d9-eaf4-63c3-d13b99da3a3d@kernel.dk>
From:   =?UTF-8?Q?Krzysztof_Ol=c4=99dzki?= <ole@ans.pl>
Message-ID: <72947cba-6a12-d54f-c9c8-588729631306@ans.pl>
Date:   Tue, 27 Jul 2021 22:46:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c1c9d728-c4d9-eaf4-63c3-d13b99da3a3d@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-07-27 at 18:24, Jens Axboe wrote:
> On 7/27/21 4:56 PM, Krzysztof Olędzki wrote:
>> On 2021-07-27 at 15:39, Krzysztof Olędzki wrote:
>>> On 2021-07-27 at 14:53, Krzysztof Olędzki wrote:
>>>> Hi,
>>>>
>>>> I have a number of (older) systems that are still based on 32 bit
>>>> userspace but are running a relatively modern 64 bit kernel -
>>>> 5.4-stable, where BTW - LOOP_CONFIGURE is not yet available.
>>>>
>>>> I noticed that starting with util-linux-2.37 it is no longer possible to
>>>> mount images using loop:
>>>>
>>>> # mount /usr/install/iso/systemrescue-8.04-amd64.iso /mnt/cdrom
>>>> mount: /mnt/cdrom: failed to setup loop device for
>>>> /usr/install/iso/systemrescue-8.04-amd64.iso.
>>>>
>>>> Reverting d5fd456c88aba4fcf77d35fe38024a8d5c814686 fixes the problem:
>>>>
>>>> /tmp/util-linux-2.37# ./mount
>>>> /usr/install/iso/systemrescue-8.04-amd64.iso /mnt/cdrom
>>>> mount: /mnt/cdrom: WARNING: source write-protected, mounted read-only.
>>>>
>>>> I have not tested if 32 bit kernel + 32 bit userspace is also affected,
>>>> but 64 bit kernel + 64 bit userspace works.
>>>
>>> Some debugging data:
>>>
>>> 30399: loopdev:      CXT: [0xff8d0f98]: using loop-control
>>> 30399: loopdev:      CXT: [0xff8d0f98]: loop0 name assigned
>>> 30399: loopdev:      CXT: [0xff8d0f98]: find_unused by loop-control [rc=0]
>>> 30399: libmount:     LOOP: [0x57cbbcb0]: trying to use /dev/loop0
>>> 30399: loopdev:      CXT: [0xff8d0f98]: set backing file=/usr/install/iso/systemrescue-8.04-amd64.iso
>>> 30399: loopdev:      CXT: [0xff8d0f98]: set flags=4
>>> 30399: loopdev:    SETUP: [0xff8d0f98]: device setup requested
>>> 30399: loopdev:    SETUP: [0xff8d0f98]: backing file open: OK
>>> 30399: loopdev:      CXT: [0xff8d0f98]: open /dev/loop0 [rw]: Success
>>> 30399: loopdev:    SETUP: [0xff8d0f98]: device open: OK
>>> 30399: loopdev:    SETUP: [0xff8d0f98]: LOOP_CONFIGURE failed: Inappropriate ioctl for device
>>> 30399: loopdev:    SETUP: [0xff8d0f98]: failed [rc=-25]
>>> 30399: libmount:     LOOP: [0x57cbbcb0]: failed to setup device
>>> 30399: loopdev:      CXT: [0xff8d0f98]: de-initialize
>>> 30399: loopdev:      CXT: [0xff8d0f98]: closing old open fd
>>> 30399: loopdev:     ITER: [0xff8d1168]: de-initialize
>>> 30399: libmount:      CXT: [0x57cbbcb0]: mount: preparing failed
>>> 30399: libmount:      CXT: [0x57cbbcb0]: excode: rc=32 message="failed to setup loop device for /usr/install/iso/systemrescue-8.04-amd64.iso"
>>> mount: /mnt/cdrom: failed to setup loop device for /usr/install/iso/systemrescue-8.04-amd64.iso.
>>> 30399: libmount:      CXT: [0x57cbbcb0]: <---- reset [status=0] ---->
>>>
>>> Seems like the code expects EINVAL (-22) but gets ENOTTY (-25), confirmed with strace:
>>> ioctl(4, LOOP_CONFIGURE, {fd=3, block_size=0, info={lo_offset=0, lo_number=0, lo_flags=LO_FLAGS_AUTOCLEAR, lo_file_name="/usr/install/iso/systemrescue-8.04-amd64.iso", ...}}) = -1 ENOTTY (Inappropriate ioctl for device)
>>>
>>> Indeed, changing the code from:
>>>      if (errno != EINVAL)
>>> to:
>>>      if (errno != EINVAL && errno != ENOTTY)
>>> allows it to work.
>>>
>>> Not that with 64-bit userspace, kernel returns EINVAL:
>>>
>>> ioctl(4, LOOP_CONFIGURE, {fd=3, block_size=0, info={lo_offset=0, lo_number=0, lo_flags=LO_FLAGS_AUTOCLEAR, lo_file_name="/usr/src/PACKAGES/systemrescue-8.04-amd64.iso", ...}}) = -1 EINVAL (Invalid argument)
>>
>> ... which is because lo_compat_ioctl returns -ENOIOCTLCMD for
>> unsupported cmds, while lo_ioctl returns -EINVAL via lo_simple_ioctl.
>>
>> And vfs_ioctl returns -ENOTTY for -ENOIOCTLCMD.
>>
>> Now the question is if this inconsistency is intended? :)
> 
> That's unfortunate, but probably not something that can get corrected at
> this time. The correct return value for an unknown ioctl is -ENOTTY
> (ENOIOCTLCMD isn't user visible, should get turned into that).

Yes, it does - as I said, vfs_ioctl handles this properly. However, this 
only works for .compat_ioctl (via mentioned lo_compat_ioctl which 
returns -ENOIOCTLCMD) but not for .ioctl (via lo_ioctl, which returns 
-EINVAL).


> But
> current behavior is set in stone at this point, even if it is
> technically incorrect.

Agreed. And even if this could be somehow fixed in further kernels, I 
believe we still need to fix the userspace to support and properly 
handle all the existing kernels.

So, to confirm - checking for both EINVAL and ENOTTY after 
LOOP_CONFIGURE is the proper way of taking care this?

https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/lib/loopdev.c?id=d4423cce9b9001c9de7ebc6f64f6cc2bb854944c#n1362

Thanks,
  Krzysztof

