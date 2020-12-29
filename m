Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1477CC433DB
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2C8207B2
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 19:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgL2TTA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 14:19:00 -0500
Received: from mx.rz.hs-furtwangen.de ([141.28.2.11]:58442 "EHLO
        mx.rz.hs-furtwangen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2TTA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 14:19:00 -0500
Received: from mx.rz.hs-furtwangen.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id EE2F461944;
        Tue, 29 Dec 2020 20:18:18 +0100 (CET)
Received: from mail.rz.hs-furtwangen.de (mail.rz.hs-furtwangen.de [141.28.2.16])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.rz.hs-furtwangen.de (Postfix) with ESMTPS;
        Tue, 29 Dec 2020 20:18:18 +0100 (CET)
Received: from [192.168.11.84] (p4ffb2d34.dip0.t-ipconnect.de [79.251.45.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.rz.hs-furtwangen.de (Postfix) with ESMTPSA id B563C2608A2;
        Tue, 29 Dec 2020 20:18:18 +0100 (CET)
Subject: Re: How to utilize a PCIE4.0 SSD?
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org
References: <eeaa8871-59f5-a56a-f4e5-723c91ac8d5a@hs-furtwangen.de>
 <20201229161941.GA1018362@dhcp-10-100-145-180.wdc.com>
 <ee5f9acf-4239-cbfc-eb5a-d6ff837b6d94@kernel.dk>
From:   Stefan Lederer <lederers@hs-furtwangen.de>
Message-ID: <a855d480-0eae-d277-0192-c692b4f94a53@hs-furtwangen.de>
Date:   Tue, 29 Dec 2020 21:18:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ee5f9acf-4239-cbfc-eb5a-d6ff837b6d94@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2020.12.29.190919, AntiVirus-Engine: 5.79.0, AntiVirus-Data: 2020.12.29.5790001
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sorry for the noise!

I didn't use O_DIRECT. Now it looks much better at >5GB/s in our
program. Unbelievable how fast SSDs have become.

Thanks for the cool new interface BTW :)


On 29.12.20 19:48, Jens Axboe wrote:
> On 12/29/20 9:19 AM, Keith Busch wrote:
>> On Tue, Dec 29, 2020 at 02:40:57PM +0100, Stefan Lederer wrote:
>>> Hello dear list,
>>>
>>> (I hope I do not annoy you as a simple application programmer)
>>>
>>> for a seminar paper at my university we reproduced the 2009 paper
>>> "Pathologies of big data" by Jacobs, where he basically reads a
>>> 100GB file sequentially from a HDD with some light processing.
>>>
>>> We have a PCIE4.0 SSD with up to 7GB/s reading (Samsung 980) but
>>> nothing we programmed so far comes even close to that speed (regular
>>> read(), mmap() with optional threads, io_uring, multi-process) so we
>>> wonder if it is possible at all?
>>>
>>> According to iostat mmap is the fastest with 4GB/s and a queue depth
>>> of ~3. All other approaches do not go beyond 2.5GB/s.
>>>
>>> Also we get some strange effects like sequential read() with 16KB
>>> buffers being faster than one with 16MB and io_uring being alot
>>> slower than mmap (all tested on Manjaro with kernel 5.8/5.10 and ext4).
>>>
>>> So, now we are quite lost and would appreciate a hint into the right
>>> direction :)
>>>
>>> What is neccesary to simply read 100GB of data at 7GB/s?
>>
>> Is your device running at gen4 speed? Easiest way to tell with an nvme
>> ssd (assuming you're reading from /dev/nvme0n1) is something like:
>>
>>   # cat /sys/block/nvme0n1/device/device/current_link_speed
>>
>> If it says less than 16GT/s, then it can't read at 7GB/s.
> 
> Does sound like that a lot. Simple test here on a gen4 device:
> 
> # cat /sys/block/nvme3n1/device/device/current_link_speed
> 16.0 GT/s PCIe
> 
> # ~axboe/git/fio/fio --name=bw --filename=/dev/nvme3n1 --direct=1 --bs=32k --ioengine=io_uring --iodepth=16 --rw=randread --norandommap
> [snip]
>     READ: bw=6630MiB/s (6952MB/s), 6630MiB/s-6630MiB/s (6952MB/s-6952MB/s), io=36.4GiB (39.1GB), run=5621-5621msec
> 
