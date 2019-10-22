Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41823CA9EA0
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 11:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1455120B7C
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 11:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbfJVLTY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 07:19:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2049 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387651AbfJVLTY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 07:19:24 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 944EF7D4B5C4AE745ABC;
        Tue, 22 Oct 2019 12:19:22 +0100 (IST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 22 Oct 2019 12:19:21 +0100
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 22 Oct
 2019 12:19:22 +0100
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
References: <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
 <20191021093448.GA22635@ming.t460p>
 <9e6e86a5-7247-4648-9df9-61f81d2df413@huawei.com>
 <20191021102401.GB22635@ming.t460p>
 <c98c0cd5-950d-5404-eeaf-4e4ed6c86acc@huawei.com>
 <20191021125327.GA25864@ming.t460p>
 <d4c8e435-b243-4734-6383-3618ad303842@huawei.com>
 <20191022001613.GA32193@ming.t460p>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4a42a062-8bca-9e03-c158-1c149986d383@huawei.com>
Date:   Tue, 22 Oct 2019 12:19:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022001613.GA32193@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/10/2019 01:16, Ming Lei wrote:
> On Mon, Oct 21, 2019 at 03:02:56PM +0100, John Garry wrote:
>> On 21/10/2019 13:53, Ming Lei wrote:
>>> On Mon, Oct 21, 2019 at 12:49:53PM +0100, John Garry wrote:
>>>>>>>
>>>>>>
>>>>>> Yes, we share tags among all queues, but we generate the tag - known as IPTT
>>>>>> - in the LLDD now, as we can no longer use the request tag (as it is not
>>>>>> unique per all queues):
>>>>>>
>>>>>> https://github.com/hisilicon/kernel-dev/commit/087b95af374be6965583c1673032fb33bc8127e8#diff-f5d8fff19bc539a7387af5230d4e5771R188
>>>>>>
>>>>>> As I said, the branch is messy and I did have to fix 087b95af374.
>>>>>
>>>>> Firstly this way may waste lots of memory, especially the queue depth is
>>>>> big, such as, hisilicon V3's queue depth is 4096.
>>>>>
>>>>> Secondly, you have to deal with queue busy efficiently and correctly,
>>>>> for example, your real hw tags(IPTT) can be used up easily, and how
>>>>> will you handle these dispatched request?
>>>>
>>>> I have not seen scenario of exhausted IPTT. And IPTT count is same as SCSI
>>>> host.can_queue, so SCSI midlayer should ensure that this does not occur.
>>>
>>
>> Hi Ming,

Hi Ming,

>>
>>> That check isn't correct, and each hw queue should have allowed
>>> .can_queue in-flight requests.
>>
>> There always seems to be some confusion or disagreement on this topic.
>>
>> I work according to the comment in scsi_host.h:
>>
>> "Note: it is assumed that each hardware queue has a queue depth of
>>   can_queue. In other words, the total queue depth per host
>>   is nr_hw_queues * can_queue."
>>
>> So I set Scsi_host.can_queue = HISI_SAS_MAX_COMMANDS (=4096)
> 
> I believe all current drivers set .can_queue as single hw queue's depth.
> If you set .can_queue as HISI_SAS_MAX_COMMANDS which is HBA's queue
> depth, the hisilicon sas driver will HISI_SAS_MAX_COMMANDS * nr_hw_queues
> in-flight requests.

Yeah, but the SCSI host should still limit max IOs over all queues to 
.can_queue:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/scsi/scsi_mid_low_api.txt#n1083



> 
>>
>>>
>>>>
>>>>>
>>>>> Finally, you have to evaluate the performance effect, this is highly
>>>>> related with how to deal with out-of-IPTT.
>>>>
>>>> Some figures from our previous testing:
>>>>
>>>> Managed interrupt without exposing multiple queues: 3M IOPs
>>>> Managed interrupt with exposing multiple queues: 2.6M IOPs
>>>
>>> Then you see the performance regression.
>>
>> Let's discuss this when I send the patches, so we don't get sidetracked on
>> this blk-mq improvement topic.
> 
> OK, what I meant is to use correct driver to test the patches, otherwise
> it might be hard to investigate.

Of course. I'm working on this now, and it looks like it will turn out 
complicated... you'll see.

BTW, I reran the test and never say the new WARN trigger (while SCSI 
timeouts did occur).

Thanks again,
John

> 
> 
> Thanks,
> Ming
> 
> .
> 

