Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701BFC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1A620873
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1A620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeK1Ohk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:37:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbeK1Ohk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 09:37:40 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0F43EF5130524;
        Wed, 28 Nov 2018 11:37:32 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 28 Nov 2018
 11:37:24 +0800
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
To:     Ming Lei <ming.lei@redhat.com>
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
 <20181127130811.GA2780@ming.t460p>
CC:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <27fa5907-9e50-23ca-c6a7-18ad0151ee19@hisilicon.com>
Date:   Wed, 28 Nov 2018 11:37:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181127130811.GA2780@ming.t460p>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Lei Ming,

在 2018/11/27 21:08, Ming Lei 写道:
> On Tue, Nov 27, 2018 at 05:55:45PM +0800, chenxiang (M) wrote:
>> Hi all,
>>
>> There is a issue which may be related to CONFIG_SCSI_MQ_DEFAULT: before we
>> developed DIF/DIX feature on kernel 4.18 (disable CONFIG_SCSI_MQ_DEFAULT
>> default), and
>> it works well.
> I guess you are testing hisi_sas_v3_hw, does 4.18 work with
> 'scsi_mod.use_blk_mq=Y'? If yes, you may run 'git bisect' to figure out
> which commit is the 1st bad one.
>
>> But when we switch to kernel 4.19-rc1 and 4.20-rc1, Call
>> trace as follow occurs when running fio and if disable config
>> CONFIG_SCSI_MQ_DEFAULT,
>> then it works well. Also if switch ioengine=libaio to ioengine=psync, it
>> seems also work well. Do you have any idea or encounter similar issue?
> I tested scsi-debug via 'dix=1 dif=1', looks everything is fine, are you
> using direct io or not?
>
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
>> fio 2.0.5
>> Starting 12 processes
>> [  629.210506] Unable to handle kernel paging request at virtual address
>> 0000ffff8027e048
>> [  629.210506] Unable to handle kernel paging request at virtual address
>> 0000ffff8027e048
>> [  629.226373] Mem abort info:
>> [  629.226373] Mem abort info:
>> [  629.231952]   ESR = 0x96000006
>> [  629.231952]   ESR = 0x96000006
>> [  629.238052]   Exception class = DABT (current EL), IL = 32 bits
>> [  629.238052]   Exception class = DABT (current EL), IL = 32 bits
>> [  629.249898]   SET = 0, FnV = 0
>> [  629.249898]   SET = 0, FnV = 0
>> [  629.255998]   EA = 0, S1PTW = 0
>> [  629.255998]   EA = 0, S1PTW = 0
>> [  629.262272] Data abort info:
>> [  629.262272] Data abort info:
>> [  629.268023]   ISV = 0, ISS = 0x00000006
>> [  629.268023]   ISV = 0, ISS = 0x00000006
>> [  629.275690]   CM = 0, WnR = 0
>> [  629.275690]   CM = 0, WnR = 0
>> [  629.281617] user pgtable: 4k pages, 48-bit VAs, pgdp = 0000000085c91728
>> [  629.281617] user pgtable: 4k pages, 48-bit VAs, pgdp = 0000000085c91728
>> [  629.294857] [0000ffff8027e048] pgd=00000027a8644003,
>> pud=00000027a85ea003, pmd=0000000000000000
>> [  629.294857] [0000ffff8027e048] pgd=00000027a8644003,
>> pud=00000027a85ea003, pmd=0000000000000000
>> [  629.312278] Internal error: Oops: 96000006 [#1] PREEMPT SMP
>> [  629.312278] Internal error: Oops: 96000006 [#1] PREEMPT SMP
>> [  629.323427] Modules linked in: hisi_sas_v3_hw [last unloaded:
>> hisi_sas_v3_hw]
>> [  629.323427] Modules linked in: hisi_sas_v3_hw [last unloaded:
>> hisi_sas_v3_hw]
>> [  629.337713] CPU: 13 PID: 4465 Comm: fio Not tainted
>> 4.20.0-rc1-15093-ge876dec #1067
>> [  629.337713] CPU: 13 PID: 4465 Comm: fio Not tainted
>> 4.20.0-rc1-15093-ge876dec #1067
>> [  629.353040] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 -
>> B601 (V6.01) 11/08/2018
>> [  629.353040] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 -
>> B601 (V6.01) 11/08/2018
>> [  629.370633] pstate: 80400009 (Nzcv daif +PAN -UAO)
>> [  629.370633] pstate: 80400009 (Nzcv daif +PAN -UAO)
>> [  629.380218] pc : deadline_remove_request+0x2c/0xd0
>> [  629.380218] pc : deadline_remove_request+0x2c/0xd0
> Could you use gdb to find where 'deadline_remove_request+0x2c' points
> to?

 From objdump, 'deadline_remove_request+0x2c' is on the function 
__list_del  -> INIT_LIST_HEAD.

>
> Thanks,
> Ming
>
> .
>


