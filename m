Return-Path: <SRS0=JObX=3C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECC8C33CAB
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 06:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993BC2187F
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 06:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbgAMGdG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:33:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35028 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbgAMGdG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jan 2020 01:33:06 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 66C6FD51B87C901C2D0E;
        Mon, 13 Jan 2020 14:33:00 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.163) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 14:32:50 +0800
Subject: Re: [PATCH] blk-map: add kernel address validation in blk_rq_map_kern
 func
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Bob Liu <bob.liu@oracle.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <jens.axboe@oracle.com>, <namhyung@gmail.com>,
        <bharrosh@panasas.com>, Mingfangsen <mingfangsen@huawei.com>,
        <zhengbin13@huawei.com>, Guiyao <guiyao@huawei.com>,
        <ming.lei@redhat.com>
References: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
 <6b282b91-b157-5260-57d9-774be223998c@huawei.com>
 <91b13d6f-04b5-28b0-ea1b-d99564ecc898@oracle.com>
 <bc469dc8-19b6-d979-c061-075e52a355b0@huawei.com>
 <20200108150738.GB18991@infradead.org>
 <5de25176-88ff-2c2b-7282-fadc0cab2065@acm.org>
From:   renxudong <renxudong1@huawei.com>
Message-ID: <192eac2b-ff16-f6fe-40ea-b1ec3b7aab9e@huawei.com>
Date:   Mon, 13 Jan 2020 14:32:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5de25176-88ff-2c2b-7282-fadc0cab2065@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.163]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/1/12 8:18, Bart Van Assche wrote:
> On 2020-01-08 07:07, Christoph Hellwig wrote:
>> On Tue, Jan 07, 2020 at 02:51:04PM +0800, renxudong wrote:
>>> When we issued scsi cmd, oops occurred. The call stack was as follows.
>>> Call trace:
>>>   __memcpy+0x110/0x180
>>>   bio_endio+0x118/0x190
>>>   blk_update_request+0x94/0x378
>>>   scsi_end_request+0x48/0x2a8
>>>   scsi_io_completion+0xa4/0x6d0
>>>   scsi_finish_command+0xd4/0x138
>>>   scsi_softirq_done+0x13c/0x198
>>>   blk_done_softirq+0xc4/0x108
>>>   __do_softirq+0x120/0x324
>>>   run_ksoftirqd+0x44/0x60
>>>   smpboot_thread_fn+0x1ac/0x1e8
>>>   kthread+0x134/0x138
>>>   ret_from_fork+0x10/0x18
>>>   Since oops is in the process of scsi cmd done, we have not added oops info
>>> to the commit log.
>>
>> What workload is this?  If the address is freed while the I/O is
>> in progress we have much deeper problem than what a virt_addr_valid
>> could paper over.
> 
> Hi Zhiqiang Liu and renxudong,
> 
> I have not yet encountered the above callstack myself but I'm also
> interested to learn more about the workload. Is this call trace e.g.
> only triggered by one particular SCSI LLD?
> 
> Thanks,
> 
> Bart.
> 
> 
> .
> 
Sorry, I haven't been able to respond to your e-mails in time.
The above callstack is trrigered because the address passed by our
modeules is illegal. When IO is completed, the destination address of
memcpy is an illegal address, and the oops appear.

