Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED507C432BE
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED7360F4F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 16:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbhGZPx4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 11:53:56 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37747 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbhGZPxw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 11:53:52 -0400
Received: by mail-lf1-f42.google.com with SMTP id h2so16598757lfu.4;
        Mon, 26 Jul 2021 09:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LnHiHae/DOkmV8+shvtr034F1Gbgd/npIOdTggk1G2k=;
        b=JMjmrwD3DJMmOsiEyhSpYKcs0UESc2w/APak4e/8biojxvv0Dabfp1HGslMAKVhkbM
         j+61PB7GIck0rdaZGhNe2ll0tUJpgpghei3kPgQvyke6QIkCvbfSDZsj84p4MfvxwuuO
         A702/pa2z34GNCv9UexWFJUe3utjxxbas7Kogv4nxvHAEplE1vucLiunBy57wuyngBWK
         H6pzT1ccpZ0/QBttAJFY2O0kixX4pG0Jan6EY9GeZa0urHVnfOKT5vvdf2lqcHorDnUG
         XGNv2H4rJ4KaEq96//dB0KdgL7m93siw7KKcX0MVK+k2osCrarnj5QJ2n4MLpM3FlteK
         zEKA==
X-Gm-Message-State: AOAM5331+0wDKbikHwEoo/z+7FOrAhkjyLXe0Ajnz/qhk40CxmQ4ouOJ
        QSACNV0ANCS7CAvFMn2KjF0=
X-Google-Smtp-Source: ABdhPJwWjYAKA6TRQMqAk7sVTaveeg6wZ4JAkWWWHSTmWBkloEWSw+e5VL/dJ8w6tqdhHhqVCYsWEw==
X-Received: by 2002:a05:6512:211:: with SMTP id a17mr10105723lfo.485.1627317258417;
        Mon, 26 Jul 2021 09:34:18 -0700 (PDT)
Received: from [192.168.140.89] ([46.175.31.194])
        by smtp.gmail.com with ESMTPSA id y28sm49265lfk.140.2021.07.26.09.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 09:34:17 -0700 (PDT)
Subject: Re: [BUG] FLOPPY DRIVER since 5.10.20
To:     markh@compro.net, dmarkh@cfl.rr.com, linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        Wim Osterholt <wim@djo.tudelft.nl>,
        Jiri Kosina <jkosina@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <de10cb47-34d1-5a88-7751-225ca380f735@compro.net>
 <e49603c2-ac36-12b0-57cf-ff5ab30115bc@linux.com>
 <f5501a7c-4387-259d-66d2-f10db0cf36ff@cfl.rr.com>
 <f1277dcb-6bf8-b149-ad4e-68a4109d4e67@linux.com>
 <1cf8e751-db77-441e-53b4-d6e979bbe046@compro.net>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <751150dd-251f-bc68-0cd0-4a10b70ab79a@linux.com>
Date:   Mon, 26 Jul 2021 19:34:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1cf8e751-db77-441e-53b4-d6e979bbe046@compro.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 7/26/21 3:23 PM, Mark Hounschell wrote:
> On 7/26/21 7:37 AM, Denis Efremov wrote:
>>
>>
>> On 7/26/21 2:17 PM, Mark Hounschell wrote:
>>> On 7/26/21 3:57 AM, Denis Efremov wrote:
>>>> Hi,
>>>>
>>>> On 7/23/21 9:47 PM, Mark Hounschell wrote:
>>>>>
>>>>> These 2 incremental patches, patch-5.10.19-20 and patch-5.11.2-3 have broken the user land fd = open("/dev/fd0", (O_RDWR | O_NDELAY)); functionality.
>>>>
>>>> Thank you for the report, I'm looking into this.
>>>>
>>>>> Since FOREVER before the patch, when using O_NDELAY, one could open the floppy device with no media inserted or even with write protected media without error. "Read-only file system" status is returned only when we actually tried to write to it. We have software still in use today that relies on this functionality.
>>>>
>>>> If it's a project with open sources could you please give a link?
>>>>
>>>> Regards,
>>>> Denis
>>>>
>>> This is immaterial but fdutils and libdsk both use rely on this flag. Who can know who else does. The point is it should NOT have been changed.
>>
>> Yes, I asked this only to add utils and this behavior to the tests.
>> And be more specific about why we should preserve this behavior in
>> next commit messages.
>>
> 
> Well, first thing is now you can't open a floppy with a write protected floppy installed. I don't think that was intended but that is now how it is.
> 
> Next there are commands that can be sent to the floppy via "ioctl(fd, FDRAWCMD,  &raw_cmd);" that do NOT require a floppy diskette to be installed.
> 
> All commands issued to the device that require a floppy diskette without a diskette installed fail with the proper status letting you know the device is not ready / no diskette installed. That goes for write protected floppies too.
> 
> There is no reason to force a user to only be able to operate on Linux fdformat formatted floppies.
> 

It appears that the story behind the issue is long enough.
I'll try to sum up the things:
[1] 09954bad4487 floppy: refactor open() flags handling
[2] ff06db1efb2a floppy: fix open(O_ACCMODE) for ioctl-only open
[3] 468c298ad3ed Revert "floppy: fix open(O_ACCMODE) for ioctl-only open"
[4] f2791e7eadf4 Revert "floppy: refactor open() flags handling"
[5] 8a0c014cd205 floppy: reintroduce O_NDELAY fix

In [1] we tried to fix O_NDELAY behavior because it's hard to define
proper non-blocking behavior for floppies. We also added
"!(mode & (FMODE_READ|FMODE_WRITE))" sanity check for open in that patch.
Motivation for the changes was that it's easy to livelock the system with
floppy's O_NDELAY and syzkaller spotted it. Just for the record, /dev/fd0
is only accessible by the root user in recent distros. 

Patch [1] broke ioctl-only opens in fdutils because:
$ grep -nre open ./setfdprm.c 
60:     if ((fd = open(argv[0],3)) < 0) { /* 3 == no access at all */
Patch [2] reverted "!(mode & (FMODE_READ|FMODE_WRITE))" to fix ioctls.
I guess [2] was not enough and Jens completely reverted [1] with [3] [4].

The last [5] patch restores the open function to the [2] state (it's possible
to use ioctl with open O_ACCMODE). [5] was added because libblkid use O_NONBLOCK
for probing devices, and floppy driver prints many I/O errors to the kernel log.
There are also problems with mounts after. I'm afraid simple revert for [5] is
not enough, otherwise we will face libblkid issues once again.I'll try to test the things and find a more elegant solution.

Denis

