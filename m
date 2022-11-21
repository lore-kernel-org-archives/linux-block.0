Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D92EC433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 22:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiKUWtw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 17:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKUWtv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 17:49:51 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E09B8561
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 14:49:50 -0800 (PST)
Message-ID: <7dcb9e3c-aa3e-b7b9-fc30-59281d581fd0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669070988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vjlz97aL/TKdxSLuP55Wz1sOalHXhaCNvKjwbOHrxzo=;
        b=LYfiAROylvJXRVvUOuIzB1CCRPF0ff5n7vAs47qvW+HCOcrbiTpy4sBp7Ht0Z/fzkTUopy
        ywgg4JxRajmW2pTYPcyKvxitl0QandnPQ288efyH1EZTL6OJS5DvnT7Rhgm2dFdflLm3wn
        MIsFh2zZtWncLlTaRJ0xf6OmJLROhrU=
Date:   Mon, 21 Nov 2022 15:49:45 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
 <Y3vlsF7KcRrY7vCW@kbusch-mbp>
 <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
In-Reply-To: <e99fef7c-1b48-61e2-b503-a2363968d5fc@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/21/2022 3:34 PM, Jonathan Derrick wrote:
> 
> 
> On 11/21/2022 1:55 PM, Keith Busch wrote:
>> On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
>>> I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
>>> reliably segfaults my QEMU instance (something else to look into) and I don't
>>> have any 'real' hardware to test this on at the moment. It looks like several
>>> passthru commands are able to enqueue prior/during/after resetting/connecting.
>>
>> I'm not seeing any problem with the latest nvme-qemu after several dozen
>> iterations of this test case. In that environment, the formats and
>> resets complete practically synchronously with the call, so everything
>> proceeds quickly. Is there anything special I need to change?
>>  
> I can still repro this with nvme-fixes tag, so I'll have to dig into it myself
Here's a backtrace:

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffff7554400 (LWP 531154)]
0x000055555597a9d5 in nvme_ctrl (req=0x7fffec892780) at ../hw/nvme/nvme.h:539
539         return sq->ctrl;
(gdb) backtrace
#0  0x000055555597a9d5 in nvme_ctrl (req=0x7fffec892780) at ../hw/nvme/nvme.h:539
#1  0x0000555555994360 in nvme_format_bh (opaque=0x5555579dd000) at ../hw/nvme/ctrl.c:5852
#2  0x0000555555f4db15 in aio_bh_call (bh=0x7fffec279910) at ../util/async.c:150
#3  0x0000555555f4dc24 in aio_bh_poll (ctx=0x55555688fa00) at ../util/async.c:178
#4  0x0000555555f34df0 in aio_dispatch (ctx=0x55555688fa00) at ../util/aio-posix.c:421
#5  0x0000555555f4e083 in aio_ctx_dispatch (source=0x55555688fa00, callback=0x0, user_data=0x0) at ../util/async.c:320
#6  0x00007ffff7bd717d in g_main_context_dispatch () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x0000555555f600c2 in glib_pollfds_poll () at ../util/main-loop.c:297
#8  0x0000555555f60140 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:320
#9  0x0000555555f60251 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:596
#10 0x0000555555a8f27c in qemu_main_loop () at ../softmmu/runstate.c:739
#11 0x000055555582b77a in qemu_default_main () at ../softmmu/main.c:37
#12 0x000055555582b7b4 in main (argc=53, argv=0x7fffffffdf88) at ../softmmu/main.c:48



> Does the tighter loop in the test comment header produce results?
> 
> 
>>> The issue seems to be very heavily timing related, so the loop in the header is
>>> a lot more forceful in this approach.
>>>
>>> As far as the loop goes, I've noticed it will typically repro immediately or
>>> pass the whole test.
>>
>> I can only get possible repro in scenarios that have multi-second long,
>> serialized format times. Even then, it still appears that everything
>> fixes itself after a waiting. Are you observing the same, or is it stuck
>> forever in your observations?
> In 5.19, it gets stuck forever with lots of formats outstanding and
> controller stuck in resetting. I'll keep digging. Thanks Keith
> 
>>
>>> +remove_and_rescan() {
>>> +	local pdev=$1
>>> +	echo 1 > /sys/bus/pci/devices/"$pdev"/remove
>>> +	echo 1 > /sys/bus/pci/rescan
>>> +}
>>
>> This function isn't called anywhere.
