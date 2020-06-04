Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52618C433DF
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3D020738
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 12:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgFDMqY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:46:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727988AbgFDMqY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jun 2020 08:46:24 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E13AE3F277EB00E7C5CC;
        Thu,  4 Jun 2020 13:46:22 +0100 (IST)
Received: from [127.0.0.1] (10.210.172.107) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 4 Jun 2020
 13:46:21 +0100
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
To:     Ming Lei <ming.lei@redhat.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de> <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
 <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
 <20200604120747.GB2336493@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
Date:   Thu, 4 Jun 2020 13:45:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200604120747.GB2336493@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.107]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> That's your patch - ok, I can try.
>>

I still get timeouts and sometimes the same driver tag message occurs:

  1014.232417] run queue from wrong CPU 0, hctx active
[ 1014.237692] run queue from wrong CPU 0, hctx active
[ 1014.243014] run queue from wrong CPU 0, hctx active
[ 1014.248370] run queue from wrong CPU 0, hctx active
[ 1014.253725] run queue from wrong CPU 0, hctx active
[ 1014.259252] run queue from wrong CPU 0, hctx active
[ 1014.264492] run queue from wrong CPU 0, hctx active
[ 1014.269453] irq_shutdown irq146
[ 1014.272752] CPU55: shutdown
[ 1014.275552] psci: CPU55 killed (polled 0 ms)
[ 1015.151530] CPU56: shutdownr=1621MiB/s,w=0KiB/s][r=415k,w=0 IOPS][eta 
00m:00s]
[ 1015.154322] psci: CPU56 killed (polled 0 ms)
[ 1015.184345] CPU57: shutdown
[ 1015.187143] psci: CPU57 killed (polled 0 ms)
[ 1015.223388] CPU58: shutdown
[ 1015.226174] psci: CPU58 killed (polled 0 ms)
long sleep 8
[ 1045.234781] scsi_times_out req=0xffff041fa13e6300[r=0,w=0 IOPS][eta 
04m:30s]

[...]

>>
>> I thought that if all the sched tags are put, then we should have no driver
>> tag for that same hctx, right? That seems to coincide with the timeout (30
>> seconds later)
> 
> That is weird, if there is driver tag found, that means the request is
> in-flight and can't be completed by HW.

In blk_mq_hctx_has_requests(), we iterate the sched tags (when 
hctx->sched_tags is set). So can some requests not have a sched tag 
(even for scheduler set for the queue)?

  I assume you have integrated
> global host tags patch in your test,

No, but the LLDD does not use request->tag - it generates its own.

  and suggest you to double check
> hisi_sas's queue mapping which has to be exactly same with blk-mq's
> mapping.
> 

scheduler=none is ok, so I am skeptical of a problem there.

>>
>>>
>>> If yes, can you collect debugfs log after the timeout is triggered?
>>
>> Same limitation as before - once SCSI timeout happens, SCSI error handling
>> kicks in and the shost no longer accepts commands, and, since that same
>> shost provides rootfs, becomes unresponsive. But I can try.
> 
> Just wondering why not install two disks in your test machine, :-)

The shost becomes unresponsive for all disks. So I could try nfs, but 
I'm not a fan :)

Cheers
