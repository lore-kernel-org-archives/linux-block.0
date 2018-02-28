Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:5717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751646AbeB1GSF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Feb 2018 01:18:05 -0500
Subject: Re: [bug report] Don't enter SCSI error handler on kernel 4.16-rc1
To: Bart Van Assche <Bart.VanAssche@wdc.com>
References: <e8bba22c-a02b-f449-c67a-d4a7ae8482df@hisilicon.com>
 <1519658706.3975.2.camel@wdc.com>
 <75f77913-41a7-98fd-f4a1-0301ff4d6e2b@hisilicon.com>
 <1519743443.21815.2.camel@wdc.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <0e03cf3a-9b96-d41e-5896-1e4c6bdf81d9@hisilicon.com>
Date: Wed, 28 Feb 2018 14:17:03 +0800
MIME-Version: 1.0
In-Reply-To: <1519743443.21815.2.camel@wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

在 2018/2/27 22:57, Bart Van Assche 写道:
> On Tue, 2018-02-27 at 15:09 +0800, chenxiang (M) wrote:
>> 在 2018/2/26 23:25, Bart Van Assche 写道:
>>> On Mon, 2018-02-26 at 17:37 +0800, chenxiang (M) wrote:
>>>> When i have a test on kernel 4.16-rc1, find a issue: running IO on SATA disk, then disable the disk through
>>>> sysfs interface(echo 0 > /sys/class/sas_phy/phy-1:0:0/enable), IO will hang and never enter SCSI EH. The issue
>>>> appears every time.
>>>>
>>>> I add some prints on code and find that  those IOs will be timeout after 30s, and they all enter
>>>> function scsi_eh_scmd_add, but only some of them can enter function scsi_eh_inc_host_failed. So it will never
>>>> enter SCSI EH.  I suspect it is related to the patch ("commit 3bd6f43f5cb371" scsi: core: Ensure that the
>>>> SCSI error handler gets woken up ). Please have a check.
>>> Hello chenxiang,
>>>
>>> Had you already noticed patch "[PATCH v2] Avoid that ATA error handling can
>>> trigger a kernel hang or oops"? If not, can you apply that patch to your
>>> kernel and verify whether it fixes this behavior? See also
>>> https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg71189.html or
>>> https://patchwork.kernel.org/patch/10236213/.
>> After applied your patch, the issue i reported seems be solved.
> Thanks for having testing that patch!
>
>> But when i have long time test(disable/enable disk when running IO) on
>> the testcase, Null pointer occurs.
>> It seems not related to current issue but i am not sure.
>> I ran the testcase for long time before in kernel 4.15-rc5, and it was okay.
>>
>> Part of log is as follows, and i add attachment of log in the email :
>>
>> [  485.716578] pc : blk_abort_request+0x14/0x68
> (+Tejun)
>
> Hello chenxiang,
>
> Please check whether the following patch fixes the kernel crash you ran into:
>
> https://marc.info/?l=linux-block&m=151895951207014

It seems the patch is for block mq, but the issue i encount is under 
block legacy as CONFIG_SCSI_MQ_DEFAULT is not enabled.

>
> Thanks,
>
> Bart.
