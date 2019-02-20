Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11A2C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 11:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA40E205F4
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 11:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uacPPjWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfBTLOD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:14:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34647 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfBTLOD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 06:14:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so11729987pgd.1;
        Wed, 20 Feb 2019 03:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=myn5gAD5JIQ8D5KQbKA25T6rmpNeqgEG2bdsRhFufTs=;
        b=uacPPjWmxnxG6lrs9v2BFK2IOjI1vwAGps7XJVmskBTf3x+B/ZCv0YFEt1J6esjaI3
         IlCgI7l6Hobk6o9GTHrIzoXXe24yevqxJHIyQWdNH1H+rkfak1+WI5D95pY9rNdv3mg+
         l5eeC2rnlOD0Vqb5cmYwu9ex9EEJi8GC9y++cwR98271Xz02WLwEyssL9SO/c/vBfSKO
         dzoFJD51b6lC+YHxV7OaU/NA1TSjmAFzikTgtTx/L7UpNTdYdnk4HmCLhElqSvmC0zJk
         5fWwn65q/H1jUY39HkfJu8lPe4Nge/Gz99plnTx2ImGXqsMePKkbwNFZn81HkWRPCLY+
         n8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=myn5gAD5JIQ8D5KQbKA25T6rmpNeqgEG2bdsRhFufTs=;
        b=Wwi036L17ApA+o374nylKGbWmzmPyG93xKS/7Fdnqm+5SKNhf8wnaQrW1vrUga0BrY
         U6tIW2Z/4cuZFBLuiOodEKGDfDCLquEykm1v+lYE6mUKGio4N0C3JVWWFVL38aLJdygl
         4HT+YKJFUilm/OhBN8CWSpIr8rr1UzMZeDNdUcGYfajjTvlVDrtebR3QILOOmp67asRo
         gT8BSiiCjBrXFagqz9CZqZmNsvIHlHkP06EAazqcdhr86aJyHgAMx8gTXW6ABriT7Nz8
         j7YX5ai29dkFj/GjAbcndmWZ8qXiBVs6csnx8m9M6lCXnAhMhuFNsJpNy1mDOUKrUNHD
         QjzQ==
X-Gm-Message-State: AHQUAuYgcI7YYkGo+PkkxNVBwYABSOSHnnqwNk0lXDmk0mzRaobUw/Nd
        r3dJ6Wz05o+I3426cUUHypZrGnms
X-Google-Smtp-Source: AHgI3IYUd4leyXpunK80hsrOPkQ0kZD56dJ6LkGgyzW9sQ+wkHrnl+s9NWLJyeCcOgYNECS3mqpHKg==
X-Received: by 2002:a63:5f0f:: with SMTP id t15mr28602670pgb.272.1550661241719;
        Wed, 20 Feb 2019 03:14:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s71sm36054084pfa.122.2019.02.20.03.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:14:01 -0800 (PST)
Subject: Re: [PATCH] xsysace: Fix error handling in ace_setup
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1550594996-11453-1-git-send-email-linux@roeck-us.net>
 <0e62ae52-9aec-dff9-4fdb-51c3dd0568c5@xilinx.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6311041f-607b-4232-feb4-3644c36c64c5@roeck-us.net>
Date:   Wed, 20 Feb 2019 03:13:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0e62ae52-9aec-dff9-4fdb-51c3dd0568c5@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/19/19 11:09 PM, Michal Simek wrote:
> On 19. 02. 19 17:49, Guenter Roeck wrote:
>> If xace hardware reports a bad version number, the error handling code
>> in ace_setup() calls put_disk(), followed by queue cleanup. However, since
>> the disk data structure has the queue pointer set, put_disk() also
>> cleans and releases the queue. This results in blk_cleanup_queue()
>> accessing an already released data structure, which in turn may result
>> in a crash such as the following.
>>
>> [   10.681671] BUG: Kernel NULL pointer dereference at 0x00000040
>> [   10.681826] Faulting instruction address: 0xc0431480
>> [   10.682072] Oops: Kernel access of bad area, sig: 11 [#1]
>> [   10.682251] BE PAGE_SIZE=4K PREEMPT Xilinx Virtex440
>> [   10.682387] Modules linked in:
>> [   10.682528] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.0.0-rc6-next-20190218+ #2
>> [   10.682733] NIP:  c0431480 LR: c043147c CTR: c0422ad8
>> [   10.682863] REGS: cf82fbe0 TRAP: 0300   Tainted: G        W          (5.0.0-rc6-next-20190218+)
>> [   10.683065] MSR:  00029000 <CE,EE,ME>  CR: 22000222  XER: 00000000
>> [   10.683236] DEAR: 00000040 ESR: 00000000
>> [   10.683236] GPR00: c043147c cf82fc90 cf82ccc0 00000000 00000000 00000000 00000002 00000000
>> [   10.683236] GPR08: 00000000 00000000 c04310bc 00000000 22000222 00000000 c0002c54 00000000
>> [   10.683236] GPR16: 00000000 00000001 c09aa39c c09021b0 c09021dc 00000007 c0a68c08 00000000
>> [   10.683236] GPR24: 00000001 ced6d400 ced6dcf0 c0815d9c 00000000 00000000 00000000 cedf0800
>> [   10.684331] NIP [c0431480] blk_mq_run_hw_queue+0x28/0x114
>> [   10.684473] LR [c043147c] blk_mq_run_hw_queue+0x24/0x114
>> [   10.684602] Call Trace:
>> [   10.684671] [cf82fc90] [c043147c] blk_mq_run_hw_queue+0x24/0x114 (unreliable)
>> [   10.684854] [cf82fcc0] [c04315bc] blk_mq_run_hw_queues+0x50/0x7c
>> [   10.685002] [cf82fce0] [c0422b24] blk_set_queue_dying+0x30/0x68
>> [   10.685154] [cf82fcf0] [c0423ec0] blk_cleanup_queue+0x34/0x14c
>> [   10.685306] [cf82fd10] [c054d73c] ace_probe+0x3dc/0x508
>> [   10.685445] [cf82fd50] [c052d740] platform_drv_probe+0x4c/0xb8
>> [   10.685592] [cf82fd70] [c052abb0] really_probe+0x20c/0x32c
>> [   10.685728] [cf82fda0] [c052ae58] driver_probe_device+0x68/0x464
>> [   10.685877] [cf82fdc0] [c052b500] device_driver_attach+0xb4/0xe4
>> [   10.686024] [cf82fde0] [c052b5dc] __driver_attach+0xac/0xfc
>> [   10.686161] [cf82fe00] [c0528428] bus_for_each_dev+0x80/0xc0
>> [   10.686314] [cf82fe30] [c0529b3c] bus_add_driver+0x144/0x234
>> [   10.686457] [cf82fe50] [c052c46c] driver_register+0x88/0x15c
>> [   10.686610] [cf82fe60] [c09de288] ace_init+0x4c/0xac
>> [   10.686742] [cf82fe80] [c0002730] do_one_initcall+0xac/0x330
>> [   10.686888] [cf82fee0] [c09aafd0] kernel_init_freeable+0x34c/0x478
>> [   10.687043] [cf82ff30] [c0002c6c] kernel_init+0x18/0x114
>> [   10.687188] [cf82ff40] [c000f2f0] ret_from_kernel_thread+0x14/0x1c
>> [   10.687349] Instruction dump:
>> [   10.687435] 3863ffd4 4bfffd70 9421ffd0 7c0802a6 93c10028 7c9e2378 93e1002c 38810008
>> [   10.687637] 7c7f1b78 90010034 4bfffc25 813f008c <81290040> 75290100 4182002c 80810008
>> [   10.688056] ---[ end trace 13c9ff51d41b9d40 ]---
>>
>> Fix the problem by setting the disk queue pointer to NULL before calling
>> put_disk(). A more comprehensive fix might be to rearrange the code
>> to check the hardware version before initializing data structures,
>> but I don't know if this would have undesirable side effects, and
>> it would increase the complexity of backporting the fix to older kernels.
>>
>> Fixes: 74489a91dd43a ("Add support for Xilinx SystemACE CompactFlash interface")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/block/xsysace.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
>> index 87ccef4bd69e..32a21b8d1d85 100644
>> --- a/drivers/block/xsysace.c
>> +++ b/drivers/block/xsysace.c
>> @@ -1090,6 +1090,8 @@ static int ace_setup(struct ace_device *ace)
>>   	return 0;
>>   
>>   err_read:
>> +	/* prevent double queue cleanup */
>> +	ace->gd->queue = NULL;
>>   	put_disk(ace->gd);
>>   err_alloc_disk:
>>   	blk_cleanup_queue(ace->queue);
>>
> 
> This driver is quite old and we are not actively using/testing it.
> Are you wiring that up with qemu?
> 

Not specifically; it may be wired up as uninitialized device.
Presumably that is why it reports version 0, which causes the driver
to bail out. It is instantiated by the devicetree file (I think).

Guenter

> Maybe it should be labeled differently in MAINTAINERS file.
> 
> Anyway whatever fix is fine for me.
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> Thanks,
> Michal
> 

