Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BABC352A4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 09:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF859208C4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 09:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgBJJPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:15:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbgBJJPU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 04:15:20 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AEEC67CCB37944FB8949;
        Mon, 10 Feb 2020 17:15:17 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Feb 2020
 17:15:12 +0800
Subject: Re: [PATCH] nbd: fix potential NULL pointer fault in connect and
 disconnect process
To:     Mike Christie <mchristi@redhat.com>, <josef@toxicpanda.com>,
        <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>
References: <20200117115005.37006-1-sunke32@huawei.com>
 <5E21EF96.1010204@redhat.com>
 <c15baa64-ef8d-970f-f4e0-ecd10cc0b0a0@huawei.com>
 <5E40CB1F.7070301@redhat.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <a35ac207-86e3-51d7-4f21-9fcc6ee63e4e@huawei.com>
Date:   Mon, 10 Feb 2020 17:15:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5E40CB1F.7070301@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Mike

Your idea looks good.

Thanks,
Sun Ke

在 2020/2/10 11:16, Mike Christie 写道:
> On 01/19/2020 01:10 AM, sunke (E) wrote:
>>
>> Thanks for your detailed suggestions.
>>
>> 在 2020/1/18 1:32, Mike Christie 写道:
>>> On 01/17/2020 05:50 AM, Sun Ke wrote:
>>>> Connect and disconnect a nbd device repeatedly, will cause
>>>> NULL pointer fault.
>>>>
>>>> It will appear by the steps:
>>>> 1. Connect the nbd device and disconnect it, but now nbd device
>>>>      is not disconnected totally.
>>>> 2. Connect the same nbd device again immediately, it will fail
>>>>      in nbd_start_device with a EBUSY return value.
>>>> 3. Wait a second to make sure the last config_refs is reduced
>>>>      and run nbd_config_put to disconnect the nbd device totally.
>>>> 4. Start another process to open the nbd_device, config_refs
>>>>      will increase and at the same time disconnect it.
>>>
>>> Just to make sure I understood this, for step 4 the process is doing:
>>>
>>> open(/dev/nbdX);
>>> ioctl(NBD_DISCONNECT, /dev/nbdX) or nbd_genl_disconnect(for /dev/nbdX)
>>>
>>> ?
>>>
>> do nbd_genl_disconnect(for /dev/nbdX)；
>> I tested it. Connect /dev/nbdX
>> through ioctl interface by nbd-client -L -N export localhost /dev/nbdX and
>> through netlink interface by nbd-client localhost XXXX /dev/nbdX,
>> disconnect /dev/nbdX by nbd-client -d /dev/nbdX.
>> Both call nbd_genl_disconnect(for /dev/nbdX) and both contain the same
>> null pointer dereference.
>>> There is no successful NBD_DO_IT / nbd_genl_connect between the open and
>>> disconnect calls at step #4, because it would normally be done at #2 and
>>> that failed. nbd_disconnect_and_put could then reference a null
>>> recv_workq. If we are also racing with a close() then that could free
>>> the device/config from under nbd_disconnect_and_put.
>>>
>> Yes, nbd_disconnect_and_put could then reference a null recv_workq.
> 
> Hey Sunke
> 
> How about the attached patch. I am still testing it. The basic idea is
> that we need to do a flush whenever we have done a sock_shutdown and are
> in the disconnect/connect/clear sock path, so it just adds the flush in
> that function. We then do not need to keep adding these flushes everywhere.
> 

