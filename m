Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8484FC4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 01:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A0C60F91
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 01:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhG1BYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 21:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhG1BYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 21:24:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B095C061760
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:24:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n10so730024plf.4
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fYGwSTr6ccg+6XJVgKogWtecCYirHUHK2PK/K0gKM7I=;
        b=ipZjYKlLRwrbxtuaEbJySLZrE8u7necIFXb1T+GQ+cVmi1XjrcxKLDXZWy2ZK1ln5Z
         iXooQt2But+7PFWRiXjtmkV++D6ajj9Fg7sbnF9wtnnvZqNwkp8Ch+lU0d5EOtnZhoUv
         9q9MuAR3LULbOMFuOJ/pqVVegIeI/IKFMYd6eJiEyM5ByD70XbjeHc8DkB3cPTyRWx7+
         29mCUdWCfbwwivxnASAwIRM1cQpKu0JpuLQgkX/Z00JCZ9v4ScdHktnloNe2aV/hb9ug
         AxsULN0IFDVvZGFLoH64b72xge2eLu8gzcTKq12FzPXSgtGIB0z5pjJtWLbgtndQPObu
         OzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYGwSTr6ccg+6XJVgKogWtecCYirHUHK2PK/K0gKM7I=;
        b=TItNn2xFfElRUpmDcyv5HqQz/YRYpAqoxgZxuzQcn+2GqFYNZd+pK+XgKVHcX/PaeX
         T+cURxcbUaHuHsqGv2Eitei6+ehvX54Nd5NkqfxPdxvrtK/zueBD/czQ3ak8gy2sIPhW
         Jw/S5C14Akx4tlm1S6b8EjYDNRMkDbL7kLK7RHj8aqrLIEO7dTOwwf0P23ABmZwErIvM
         rfxDYz7n3lXHH9ni6GuO2SJifG4ox+W2prLN7Y24jioNXfXYd+CHh5njN+bZBdb/59kU
         M5Ra5mCpW7A+CVRIH4bF/xbUgn8VuWTjP5lWuC9caNH4yR/z7k1IANQxIAcvREhcI7K0
         QrYA==
X-Gm-Message-State: AOAM531Lm2GczPENiSsP6/RPIIbcTtLKrs4hBNGRVXgga3fnf/F4JeqZ
        Of+8kjKmZwUFtl+MsMqFzwGSSg==
X-Google-Smtp-Source: ABdhPJw7bwWKM4mz64JpYjWPqii8We0O0thyOnvf/9s8gAnsnp6bNyNqy0I2JPTbxQpaDjEkUqe4ng==
X-Received: by 2002:aa7:8246:0:b029:39a:1e0a:cd48 with SMTP id e6-20020aa782460000b029039a1e0acd48mr12054588pfn.14.1627435461843;
        Tue, 27 Jul 2021 18:24:21 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id l10sm4188459pjg.11.2021.07.27.18.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 18:24:21 -0700 (PDT)
Subject: Re: Commit d5fd456c88aba4fcf77d35fe38024a8d5c814686 - "loopdev: use
 LOOP_CONFIG ioctl" broke loop on x86-64 w/ 32 bit userspace
To:     =?UTF-8?Q?Krzysztof_Ol=c4=99dzki?= <ole@ans.pl>,
        Sinan Kaya <sinan.kaya@microsoft.com>,
        Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <a797f527-4599-e986-a326-4bb141487f2c@ans.pl>
 <e7f64d43-2a26-e386-b208-5c35d6a56ed4@ans.pl>
 <7de1bd0b-b8ea-daf0-b677-f92db1c1cdff@ans.pl>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c1c9d728-c4d9-eaf4-63c3-d13b99da3a3d@kernel.dk>
Date:   Tue, 27 Jul 2021 19:24:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7de1bd0b-b8ea-daf0-b677-f92db1c1cdff@ans.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/21 4:56 PM, Krzysztof Olędzki wrote:
> On 2021-07-27 at 15:39, Krzysztof Olędzki wrote:
>> On 2021-07-27 at 14:53, Krzysztof Olędzki wrote:
>>> Hi,
>>>
>>> I have a number of (older) systems that are still based on 32 bit
>>> userspace but are running a relatively modern 64 bit kernel -
>>> 5.4-stable, where BTW - LOOP_CONFIGURE is not yet available.
>>>
>>> I noticed that starting with util-linux-2.37 it is no longer possible to
>>> mount images using loop:
>>>
>>> # mount /usr/install/iso/systemrescue-8.04-amd64.iso /mnt/cdrom
>>> mount: /mnt/cdrom: failed to setup loop device for
>>> /usr/install/iso/systemrescue-8.04-amd64.iso.
>>>
>>> Reverting d5fd456c88aba4fcf77d35fe38024a8d5c814686 fixes the problem:
>>>
>>> /tmp/util-linux-2.37# ./mount
>>> /usr/install/iso/systemrescue-8.04-amd64.iso /mnt/cdrom
>>> mount: /mnt/cdrom: WARNING: source write-protected, mounted read-only.
>>>
>>> I have not tested if 32 bit kernel + 32 bit userspace is also affected,
>>> but 64 bit kernel + 64 bit userspace works.
>>
>> Some debugging data:
>>
>> 30399: loopdev:      CXT: [0xff8d0f98]: using loop-control
>> 30399: loopdev:      CXT: [0xff8d0f98]: loop0 name assigned
>> 30399: loopdev:      CXT: [0xff8d0f98]: find_unused by loop-control [rc=0]
>> 30399: libmount:     LOOP: [0x57cbbcb0]: trying to use /dev/loop0
>> 30399: loopdev:      CXT: [0xff8d0f98]: set backing file=/usr/install/iso/systemrescue-8.04-amd64.iso
>> 30399: loopdev:      CXT: [0xff8d0f98]: set flags=4
>> 30399: loopdev:    SETUP: [0xff8d0f98]: device setup requested
>> 30399: loopdev:    SETUP: [0xff8d0f98]: backing file open: OK
>> 30399: loopdev:      CXT: [0xff8d0f98]: open /dev/loop0 [rw]: Success
>> 30399: loopdev:    SETUP: [0xff8d0f98]: device open: OK
>> 30399: loopdev:    SETUP: [0xff8d0f98]: LOOP_CONFIGURE failed: Inappropriate ioctl for device
>> 30399: loopdev:    SETUP: [0xff8d0f98]: failed [rc=-25]
>> 30399: libmount:     LOOP: [0x57cbbcb0]: failed to setup device
>> 30399: loopdev:      CXT: [0xff8d0f98]: de-initialize
>> 30399: loopdev:      CXT: [0xff8d0f98]: closing old open fd
>> 30399: loopdev:     ITER: [0xff8d1168]: de-initialize
>> 30399: libmount:      CXT: [0x57cbbcb0]: mount: preparing failed
>> 30399: libmount:      CXT: [0x57cbbcb0]: excode: rc=32 message="failed to setup loop device for /usr/install/iso/systemrescue-8.04-amd64.iso"
>> mount: /mnt/cdrom: failed to setup loop device for /usr/install/iso/systemrescue-8.04-amd64.iso.
>> 30399: libmount:      CXT: [0x57cbbcb0]: <---- reset [status=0] ---->
>>
>> Seems like the code expects EINVAL (-22) but gets ENOTTY (-25), confirmed with strace:
>> ioctl(4, LOOP_CONFIGURE, {fd=3, block_size=0, info={lo_offset=0, lo_number=0, lo_flags=LO_FLAGS_AUTOCLEAR, lo_file_name="/usr/install/iso/systemrescue-8.04-amd64.iso", ...}}) = -1 ENOTTY (Inappropriate ioctl for device)
>>
>> Indeed, changing the code from:
>>     if (errno != EINVAL)
>> to:
>>     if (errno != EINVAL && errno != ENOTTY)
>> allows it to work.
>>
>> Not that with 64-bit userspace, kernel returns EINVAL:
>>
>> ioctl(4, LOOP_CONFIGURE, {fd=3, block_size=0, info={lo_offset=0, lo_number=0, lo_flags=LO_FLAGS_AUTOCLEAR, lo_file_name="/usr/src/PACKAGES/systemrescue-8.04-amd64.iso", ...}}) = -1 EINVAL (Invalid argument)
> 
> ... which is because lo_compat_ioctl returns -ENOIOCTLCMD for 
> unsupported cmds, while lo_ioctl returns -EINVAL via lo_simple_ioctl.
> 
> And vfs_ioctl returns -ENOTTY for -ENOIOCTLCMD.
> 
> Now the question is if this inconsistency is intended? :)

That's unfortunate, but probably not something that can get corrected at
this time. The correct return value for an unknown ioctl is -ENOTTY
(ENOIOCTLCMD isn't user visible, should get turned into that). But
current behavior is set in stone at this point, even if it is
technically incorrect.

-- 
Jens Axboe

