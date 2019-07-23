Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D46C76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 21:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3710222387
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 21:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tds.net header.i=@tds.net header.b="rcz7KSWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfGWV4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:56:12 -0400
Received: from smtp.tds.cmh.synacor.com ([64.8.70.105]:60901 "EHLO
        mail.tds.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731354AbfGWV4M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 17:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; d=tds.net; s=20180112; c=relaxed/simple;
        q=dns/txt; i=@tds.net; t=1563918971;
        h=From:Subject:Date:To:MIME-Version:Content-Type;
        bh=V1a4hjIRpHYqJvBSV4HYli3pzJM=;
        b=rcz7KSWZ/I7aOj4Ey6alkmX33RsRIoeFk3Q+zrQIzOrLU4ACFEv1xWdyd8tKOBGe
        UZSXcH1lL/mtDM9kfCSwladDt6JHC1WF3REZCDkToIw6OZcCQLy7fVZ8EZIqXfxZ
        IFvXavi94AJH962/XabpcVVbSurVVlH3QVj49yftXZ+t3jzeBX3ZDXmdXeGNdB0I
        E2w6hNYF6I1SX2q5mLVVUozdtQBbaG3SW3rp3lZ7qiYhf6oh+acm/kdTDqi/KJmJ
        SFi13du0k0Pqp23dzjSksPhZbAgFyppsalwseWBx8IozLDBqFxZE+AeiBII9x/NP
        f8o7ppXrko821Rq0ydkewQ==;
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.2 cv=MI4io4Rl c=1 sm=1 tr=0 a=QQ1z/TRHJLkw7QGu0419XQ==:117 a=QQ1z/TRHJLkw7QGu0419XQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=nHvWMnLLnzEA:10 a=0o9FgrsRnhwA:10 a=C9He5zk_2WUA:10 a=2n64sO5BAAAA:8 a=JfrnYn6hAAAA:8 a=TWMFMMwqqXzE9VEJuPsA:9 a=QEXdDO2ut3YA:10 a=yX3wAsJuk6BbNaD5pWsV:22 a=1CNFftbPRP8L7MoqJWF3:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: ZGF2aWRjNTAyQHRkcy5uZXQ=
Authentication-Results:  smtp02.tds.cmh.synacor.com smtp.user=davidc502; auth=pass (LOGIN)
Received: from [69.21.125.220] ([69.21.125.220:45754] helo=[192.168.2.226])
        by mail.tds.net (envelope-from <davidc502@tds.net>)
        (ecelerity 3.6.5.45644 r(Core:3.6.5.0)) with ESMTPSA (cipher=AES128-SHA) 
        id 91/F2-30811-B72873D5; Tue, 23 Jul 2019 17:56:11 -0400
Subject: Re: fstrim error - AORUS NVMe Gen4 SSD
From:   davidc502 <davidc502@tds.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, ilnux-nvme@lists.infradead.org
References: <fb510e33-5c81-6d62-fcde-a2989b3a1a8f@tds.net>
 <20190723021928.GF30776@ming.t460p>
 <4a7ec7aa-f6ee-f9dc-4a17-38f2b169c721@tds.net>
 <20190723043803.GB13829@ming.t460p>
 <38cf2485-727b-268d-f42c-6c53b971cb87@tds.net>
Message-ID: <5ef41ec4-abb8-90bf-e2eb-8a62f51ad951@tds.net>
Date:   Tue, 23 Jul 2019 16:56:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <38cf2485-727b-268d-f42c-6c53b971cb87@tds.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming,

On 7/23/19 4:38 PM, davidc502 wrote:
> Hello,
>
> On 7/22/19 11:38 PM, Ming Lei wrote:
>> Hi,
>>
>> On Mon, Jul 22, 2019 at 09:39:07PM -0500, davidc502 wrote:
>>> See attached:  nvme_io_trace.log
>>>
>>>
>>> On 7/22/19 9:19 PM, Ming Lei wrote:
>>>> Hi,
>>>>
>>>> On Sat, Jul 20, 2019 at 09:41:24PM -0500, davidc502 wrote:
>>>>>    Hello,
>>>>>
>>>>>    I've assembled a X570 board with a 1TB AORUS NVMe Gen4 SSD.
>>>>>
>>>>>    When attempting to fstrim the NVMe, I receive the following error.
>>>>>    davidc502@Ryzen-3900x:~$ sudo fstrim -a -v
>>>>>    fstrim: /boot/efi: FITRIM ioctl failed: Input/output error
>>>>>    fstrim: /: FITRIM ioctl failed: Input/output error
>>>>>
>>>>>    Anyhow, I have put some details below which might be helpful. 
>>>>> Note that
>>>>> this NVMe is supposed to be TRIM and SMART compliant. The SMART 
>>>>> outputs are
>>>>> available using the utility “nvme-cli”.
>>>>>    I am willing to provide whatever command outputs that are 
>>>>> needed to help
>>>>> solve this issue.
>>>>>
>>>>>    OS= Ubuntu 18.4.2 LTS
>>>>>    Different Kernels I’ve tried = 5.1.16, 5.2 rc7, and 4.18
>>>>>    fstrim version =  fstrim from util-linux 2.31.1
>>>>>    Firmware version for Aorus NVMe = EGFM11.0
>>>>>
>>>> I saw discard timeout on HGST 1.6TB NVMe, not sure if yours is same 
>>>> with
>>>> that one.
>>>>
>>>> Could you collect logs via the following steps?
>>>>
>>>> Suppose your nvme disk name is /dev/nvme0n1:
>>>>
>>>> 1) queue limits log:
>>>>
>>>>     #(cd /sys/block/nvme0n1/queue && find . -type f -exec grep -aH 
>>>> . {} \;)
>>>>
>>>>
>>>> 2) NVMe IO trace
>>>>
>>>> - enable nvme IO trace before running fstrim:
>>>>
>>>>     #echo 1  > /sys/kernel/debug/tracing/events/nvme_setup_cmd/enable
>>>>     #echo 1  > 
>>>> /sys/kernel/debug/tracing/events/nvme_complete_rq/enable
>>>>
>>>> - run fstrim
>>>>
>>>> - after the fstrim failure is triggered, disable the nvme io trace 
>>>> & post the log:
>>>>
>>>>     #echo 0  > /sys/kernel/debug/tracing/events/nvme_setup_cmd/enable
>>>>     #echo 0  > 
>>>> /sys/kernel/debug/tracing/events/nvme_complete_rq/enable
>>>>
>>>>     #cp    /sys/kernel/debug/tracing/trace /root/nvme_io_trace.log
>>>>
>>>>
>>>>
>>>> thanks,
>>>> Ming
>>>
>>> Hello Ming
>>>
>>> Thank you for the quick reply --  See attached
>>  From the IO trace, discard command(nvme_cmd_dsm) is failed:
>>
>>    kworker/15:1H-462   [015] .... 91814.342452: nvme_setup_cmd: 
>> nvme0: disk=nvme0n1, qid=7, cmdid=552, nsid=1, flags=0x0, meta=0x0, 
>> cmd=(nvme_cmd_dsm nr=0, attributes=4)
>>            <idle>-0     [013] d.h. 91814.342708: nvme_complete_rq: 
>> nvme0: disk=nvme0n1, qid=7, cmdid=552, res=0, retries=0, flags=0x0, 
>> status=8198
>>
>> And the returned error code is 0x8198, I am not sure how to parse the
>> 'Command Specific Status Values' of 0x98, maybe Christoph, Keith or 
>> our other
>> NVMe guys can help to understand the failure.
>>
>>
>> Thanks,
>> Ming
>
> Long story short we have 3 new PCI Gen 4 SSD - NVMe drives from 
> Gigabyte. But actually, Gigabyte is just putting their name on it as I 
> believe it is actually from "Phison".
>
> Here is the website where you can see the new drives -- 
> https://www.gigabyte.com/Solid-State-Drive/Gen-4
>
> I have opened a ticket with Gigabyte, and have inquired about any 
> available firmware updates. It will take 3-5 days to hear back from 
> them, but will report back the finding.
>
> Thank you for taking a look at the tracing file, and hopefully that 
> gives enough insight as to what might be happening.
>
> Best Regards,
>
> David
>
>
I have attempted to CC ilnux-nvme@lists.infradead.org, but receive a 
immediate notification " 550 Unknown recipient ".  So it just gets 
bounced back to me.

Thanks,

David



