Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E61C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 11:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E57206B7
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 11:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E57206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeK3WfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:35:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44291 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726459AbeK3WfY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 17:35:24 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E619E8E6979A4;
        Fri, 30 Nov 2018 19:26:21 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 30 Nov 2018
 19:26:12 +0800
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
To:     Ming Lei <ming.lei@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
 <20181127130811.GA2780@ming.t460p>
 <6c573f36-60d8-0631-e9ac-dacd72f6c8ad@hisilicon.com>
 <20181130011935.GA7573@ming.t460p>
CC:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Steffen Maier <maier@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e0e07583-98ca-4fc5-e60d-055e5474c084@huawei.com>
Date:   Fri, 30 Nov 2018 11:26:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181130011935.GA7573@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+

On 30/11/2018 01:19, Ming Lei wrote:
> On Wed, Nov 28, 2018 at 10:50:11AM +0800, chenxiang (M) wrote:
>> Hi  Lei Ming,
>>
>> 在 2018/11/27 21:08, Ming Lei 写道:
>>> On Tue, Nov 27, 2018 at 05:55:45PM +0800, chenxiang (M) wrote:
>>>> Hi all,
>>>>
>>>> There is a issue which may be related to CONFIG_SCSI_MQ_DEFAULT: before we
>>>> developed DIF/DIX feature on kernel 4.18 (disable CONFIG_SCSI_MQ_DEFAULT
>>>> default), and
>>>> it works well.
>>> I guess you are testing hisi_sas_v3_hw, does 4.18 work with
>>> 'scsi_mod.use_blk_mq=Y'? If yes, you may run 'git bisect' to figure out
>>> which commit is the 1st bad one.
>>
>> Yes, i am testing hisi_sas_v3_hw, if 4.18 with 'scsi_mod.use_blk_mq=Y' ,
>> there is still a issue, and
>> the log is as attached ;
>>
>>>
>>>> But when we switch to kernel 4.19-rc1 and 4.20-rc1, Call
>>>> trace as follow occurs when running fio and if disable config
>>>> CONFIG_SCSI_MQ_DEFAULT,
>>>> then it works well. Also if switch ioengine=libaio to ioengine=psync, it
>>>> seems also work well. Do you have any idea or encounter similar issue?
>>> I tested scsi-debug via 'dix=1 dif=1', looks everything is fine, are you
>>> using direct io or not?
>> Yes, i use direct io.
>> I also test scsi-debug on kernel 4.19, and there seems be some other issue,
>> and i am not sure
>> whethere there is something wrong my operation:
>>
>> root@(none)$ insmod scsi_debug.ko dif=1 dix=1 virtual_gb=120
>
> Hi chenxiang,
>
> For DIX/DIF test, I think you need to pass 'dev_size_mb=XXX' instead of
> 'virtual_gb'.
>
> I just run FIO over 'scsi_debug dev_size_mb=896 max_luns=1 dif=1 dix=1'
> on one apm-mustang-ev3 board, and looks everything is fine. You may run
> the same test on your D06 and see if it is fine.
>
> Please check if you may reproduce the list corruption issue on v4.18 with
> hisi_sas_v3_hw.
>

Hi Ming,

Thanks for your support.

We have also noticed that if we just enable DIF in hisi_sas (with MQ), 
and not DIX, then no issue.

I did also noticed mail "[PATCH v2 01/23] zfcp: make DIX experimental, 
disabled, and independent of DIF", where DIX is made experimental.

For now we may not support DIX. It seems to have issues. We wanted to 
try 3008 card on our system, but it does not seem to support DIX 0-3.

BTW, chen xiang said your commnand works ok on our HW. He can confirm.

Thanks again,
John

> Thanks,
> Ming
>
> .
>


