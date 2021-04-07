Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111C6C433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 08:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB69C61222
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 08:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbhDGIHJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:07:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2779 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhDGIHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 04:07:09 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFcHy74fYz6873F;
        Wed,  7 Apr 2021 15:59:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 10:06:58 +0200
Received: from [10.210.168.126] (10.210.168.126) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 09:06:57 +0100
Subject: Re: [PATCH] blk-mq: set default elevator as deadline in case of hctx
 shared tagset
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Yanhui Ma <yama@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Kashyap Desai <kashyap.desai@broadcom.com>
References: <20210406031933.767228-1-ming.lei@redhat.com>
 <d081eb6a-ace7-c9b2-7374-7f05a31551a0@huawei.com> <YG0BTVsCNKZHD3/T@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6c346805-a7b1-f66d-af16-b1da03d77fc0@huawei.com>
Date:   Wed, 7 Apr 2021 09:04:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YG0BTVsCNKZHD3/T@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.126]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: John Garry <john.garry@huawei.com>


> On Tue, Apr 06, 2021 at 11:25:08PM +0100, John Garry wrote:
>> On 06/04/2021 04:19, Ming Lei wrote:
>>
>> Hi Ming,
>>
>>> Yanhui found that write performance is degraded a lot after applying
>>> hctx shared tagset on one test machine with megaraid_sas. And turns out
>>> it is caused by none scheduler which becomes default elevator caused by
>>> hctx shared tagset patchset.
>>>
>>> Given more scsi HBAs will apply hctx shared tagset, and the similar
>>> performance exists for them too.
>>>
>>> So keep previous behavior by still using default mq-deadline for queues
>>> which apply hctx shared tagset, just like before.
>> I think that there a some SCSI HBAs which have nr_hw_queues > 1 and don't
>> use shared sbitmap - do you think that they want want this as well (without
>> knowing it)?
> I don't know but none has been used for them since the beginning, so not
> an regression of shared tagset, but this one is really.

It seems fine to revert to previous behavior when host_tagset is set. I 
didn't check the results for this recently, but for the original shared 
tagset patchset [0] I had:

none sched:		2132K IOPS					
mq-deadline sched:	2145K IOPS			

A quick audit of other SCSI HBA drivers in drivers/scsi which set 
nr_hw_queues and don't set host_tagset gives lpfc, qla2xxx, qedi 
(nr_hw_queues seems to be getting unset), storvsc_drv (host_tagset might 
be getting set), virtio_scsi, and then mpi3mr

Thanks,
John


[0] 
https://lore.kernel.org/linux-scsi/1597850436-116171-1-git-send-email-john.garry@huawei.com/

