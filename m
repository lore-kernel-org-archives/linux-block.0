Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36627C4338F
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 05:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BFCB603E7
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 05:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhG3FQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jul 2021 01:16:04 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]:39816 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhG3FPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jul 2021 01:15:13 -0400
Received: by mail-qv1-f52.google.com with SMTP id d3so4610105qvq.6;
        Thu, 29 Jul 2021 22:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bAVnIwvX8e+qAileedKRPA1lXMF1MMPyPKuAP+v6VTE=;
        b=k36FmHnHnGxnGkctuvPT42ARDcdeYPraICBZ1t767HY9xnE6VExUQ3znh8YVZOlfKg
         A/MGQgwvrvN2lZ+psMYtWttD/8NgDXk6KF9WE9OxCadruWF4CLduUw/UCyrdgFuv383c
         Htk4HVyXeJX6O25jgyHVkKjCmNWzdXTEl/RZOscYfnwTLlR7RvKuRHFy6QnminEgaQTV
         3+XEnPxRbUM0YGlEEYjfCJfjrgiTZyylTdRWyotGUgW/I8sByj4K0fuz7NHA2Nh4Ich6
         lCTw+TRM7r+EoRHrmhrlee+kqp+069pQQWmgbNHLz8MAkP8S8sH4TohxGeOft2viQMkp
         W73w==
X-Gm-Message-State: AOAM531fdxMvLn8641u+wnBUWHPFxoAmFX7JH8IBroKs79Y/9Zo39Ywt
        W2q9xbO5QJGgfX7qe6cGrutuYXqNQqnhaw==
X-Google-Smtp-Source: ABdhPJxfBdhJhTrTWdy4gWRNXEwFjtq6eNZPUAhNjMDAUyNYnoe5sjL7JjoSQDxVxlxXDp+idDp9KQ==
X-Received: by 2002:a0c:fa44:: with SMTP id k4mr922937qvo.59.1627622107267;
        Thu, 29 Jul 2021 22:15:07 -0700 (PDT)
Received: from [10.68.32.40] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id bl40sm343832qkb.64.2021.07.29.22.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 22:15:06 -0700 (PDT)
Subject: Re: [BUG] FLOPPY DRIVER since 5.10.20
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, Kurt Garloff <kurt@garloff.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Osterholt <wim@djo.tudelft.nl>, dmarkh@cfl.rr.com,
        markh@compro.net
References: <de10cb47-34d1-5a88-7751-225ca380f735@compro.net>
 <e49603c2-ac36-12b0-57cf-ff5ab30115bc@linux.com>
 <f5501a7c-4387-259d-66d2-f10db0cf36ff@cfl.rr.com>
 <f1277dcb-6bf8-b149-ad4e-68a4109d4e67@linux.com>
 <1cf8e751-db77-441e-53b4-d6e979bbe046@compro.net>
 <751150dd-251f-bc68-0cd0-4a10b70ab79a@linux.com>
Message-ID: <ffb8ca1c-ac8c-95c4-c05a-1269c4831b0a@linux.com>
Date:   Fri, 30 Jul 2021 08:15:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <751150dd-251f-bc68-0cd0-4a10b70ab79a@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 7/26/21 7:34 PM, Denis Efremov wrote:
> 
> 
> On 7/26/21 3:23 PM, Mark Hounschell wrote:
>> On 7/26/21 7:37 AM, Denis Efremov wrote:
>>>
>>>
>>> On 7/26/21 2:17 PM, Mark Hounschell wrote:
>>>> On 7/26/21 3:57 AM, Denis Efremov wrote:
>>>>> Hi,
>>>>>
>>>>> On 7/23/21 9:47 PM, Mark Hounschell wrote:
>>>>>>
>>>>>> These 2 incremental patches, patch-5.10.19-20 and patch-5.11.2-3 have broken the user land fd = open("/dev/fd0", (O_RDWR | O_NDELAY)); functionality.
>>>>>
>>>>> Thank you for the report, I'm looking into this.
>>>>>
>>>>>> Since FOREVER before the patch, when using O_NDELAY, one could open the floppy device with no media inserted or even with write protected media without error. "Read-only file system" status is returned only when we actually tried to write to it. We have software still in use today that relies on this functionality.
>>>>>
>>>>> If it's a project with open sources could you please give a link?
>>>>>
>>>>> Regards,
>>>>> Denis
>>>>>
>>>> This is immaterial but fdutils and libdsk both use rely on this flag. Who can know who else does. The point is it should NOT have been changed.
>>>
>>> Yes, I asked this only to add utils and this behavior to the tests.
>>> And be more specific about why we should preserve this behavior in
>>> next commit messages.
>>>
>>
>> Well, first thing is now you can't open a floppy with a write protected floppy installed. I don't think that was intended but that is now how it is.
>>
>> Next there are commands that can be sent to the floppy via "ioctl(fd, FDRAWCMD,  &raw_cmd);" that do NOT require a floppy diskette to be installed.
>>
>> All commands issued to the device that require a floppy diskette without a diskette installed fail with the proper status letting you know the device is not ready / no diskette installed. That goes for write protected floppies too.
>>
>> There is no reason to force a user to only be able to operate on Linux fdformat formatted floppies.
>>
> 
> It appears that the story behind the issue is long enough.
> I'll try to sum up the things:
> [1] 09954bad4487 floppy: refactor open() flags handling
> [2] ff06db1efb2a floppy: fix open(O_ACCMODE) for ioctl-only open
> [3] 468c298ad3ed Revert "floppy: fix open(O_ACCMODE) for ioctl-only open"
> [4] f2791e7eadf4 Revert "floppy: refactor open() flags handling"
> [5] 8a0c014cd205 floppy: reintroduce O_NDELAY fix
> 
> In [1] we tried to fix O_NDELAY behavior because it's hard to define
> proper non-blocking behavior for floppies. We also added
> "!(mode & (FMODE_READ|FMODE_WRITE))" sanity check for open in that patch.
> Motivation for the changes was that it's easy to livelock the system with
> floppy's O_NDELAY and syzkaller spotted it. Just for the record, /dev/fd0
> is only accessible by the root user in recent distros. 
> 
> Patch [1] broke ioctl-only opens in fdutils because:
> $ grep -nre open ./setfdprm.c 
> 60:     if ((fd = open(argv[0],3)) < 0) { /* 3 == no access at all */
> Patch [2] reverted "!(mode & (FMODE_READ|FMODE_WRITE))" to fix ioctls.
> I guess [2] was not enough and Jens completely reverted [1] with [3] [4].
> 
> The last [5] patch restores the open function to the [2] state (it's possible
> to use ioctl with open O_ACCMODE). [5] was added because libblkid use O_NONBLOCK
> for probing devices, and floppy driver prints many I/O errors to the kernel log.
> There are also problems with mounts after. I'm afraid simple revert for [5] is
> not enough, otherwise we will face libblkid issues once again.I'll try to test the things and find a more elegant solution.
> 

I performed some tests and here is a small example that can be reproduced
even with qemu.
With O_NDELAY fix:
$ fdlist # no floppy inserted
fdlist (): drive fd0 does not exist

Without O_NDELAY fix:
$ fdlist # no floppy inserted
NAME   TYPE  STATUS
 fd0  2880K  not mounted

That's because of O_RDONLY|O_NDELAY open in probe_drive:
https://sources.debian.org/src/fdutils/5.6-2/src/fdmount.c/#L390

I guess that's why the original patch was reverted
f2791e7eadf4 Revert "floppy: refactor open() flags handling"
We still have software that depends on O_NDELAY in floppies
and this patch will be reverted again.

Meanwhile I can't fully reproduce the issues with libblkid.
I know that systemd-udevd tries to open /dev/fd0 during boot
with O_RDONLY|O_NDELAY. With O_NDELAY implemented we don't call
floppy_revalidate() which result in an attempt to read block 0
https://elixir.bootlin.com/linux/v5.10.20/source/drivers/block/floppy.c#L4127
However, *with* O_NDELAY fix we try to read block 0 and get kernel
log errors if no floppy inserted:
[    1.732360] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[    1.732822] floppy: error 10 while reading block 0
If floppy inserted this results in a boot delay on a
real system.

Jiri, Kurt, can you give more details about test conditions
for O_NDELAY problem or maybe even provide some examples?

Maybe it will cheaper to implement a special probing for
floppies in new software than drop O_NDELAY for all already
written software. Of course, if there is no cheap and obvious
in-kernel fix.

Denis
