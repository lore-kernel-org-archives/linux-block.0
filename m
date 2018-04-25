Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754472AbeDYODZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Apr 2018 10:03:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3PE1htx099968
        for <linux-block@vger.kernel.org>; Wed, 25 Apr 2018 10:03:24 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hjtpa9afx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 25 Apr 2018 10:03:23 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 25 Apr 2018 15:02:56 +0100
Subject: Re: [PATCH] Revert "blk-mq: remove code for dealing with remapping
 queue"
To: Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Ewan Milne <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20180424200144.16179-1-ming.lei@redhat.com>
 <30f75463-b50b-e3b7-8f78-768538fce016@de.ibm.com>
 <a6003752-474a-e0cc-6091-087a37470fdf@linux.vnet.ibm.com>
 <27da3601-14c9-3363-cfa3-ee80a601370d@kernel.dk>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Apr 2018 16:02:52 +0200
MIME-Version: 1.0
In-Reply-To: <27da3601-14c9-3363-cfa3-ee80a601370d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Message-Id: <73178b69-a104-7828-cb8f-8a6b21d2891a@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 04/25/2018 03:59 PM, Jens Axboe wrote:
> On 4/25/18 2:38 AM, Stefan Haberland wrote:
>> On 25.04.2018 09:41, Christian Borntraeger wrote:
>>> On 04/24/2018 10:01 PM, Ming Lei wrote:
>>>> This reverts commit 37c7c6c76d431dd7ef9c29d95f6052bd425f004c.
>>>>
>>>> Turns out some drivers(most are FC drivers) may not use managed
>>>> IRQ affinity, and has their customized .map_queues meantime, so
>>>> still keep this code for avoiding regression.
>>>>
>>>> Reported-by: Laurence Oberman <loberman@redhat.com>
>>>> Cc: Ewan Milne <emilne@redhat.com>
>>>> Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
>>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> Seems to work ok with 4.17-rc2 + this patch with s390 and dasd devices.
>>> So one of the other fixes seems to have taken care of the original issue.
>>> Would be good if Stefan Haberland could also verify that.
>>>
>>>
>>
>> Looks OK to me, too.
>> Did some testing with 4.17-rc2 + this patch on LPAR and z/VM with 1-65 
>> CPUs as
>> well as dynamic CPU definitionon z/VM and a small DASD regression test.
> 
> For both you and Christian - it'd be really nice if those positive
> test results could be included in the forms of a Tested-by or similar
> in the patch itself.
> 

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
