Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750716AbeC2KMe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 06:12:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2TA9k3P008268
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 06:12:33 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h0vd8vw9c-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 06:12:33 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 29 Mar 2018 11:12:31 +0100
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180328012035.17565-1-ming.lei@redhat.com>
 <ab28ea2a-9061-a4bb-723f-7db46d9a61c2@kernel.dk>
 <ebd41c63-5b64-23a7-1914-4abdedf3c9b2@de.ibm.com>
 <20180328152617.GA6071@ming.t460p>
 <19cb3f30-a2aa-5d3b-acad-95c882615929@de.ibm.com>
 <20180329020021.GA29317@ming.t460p>
 <b3f7e1b5-2de4-80d3-8125-c2a1da8ba9a6@de.ibm.com>
 <20180329095214.GB17190@ming.t460p>
 <c9329fd1-934d-2ef2-9c08-0ad9beb3058d@de.ibm.com>
Date: Thu, 29 Mar 2018 12:12:27 +0200
MIME-Version: 1.0
In-Reply-To: <c9329fd1-934d-2ef2-9c08-0ad9beb3058d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <3d3a720d-e4e3-ac59-be75-554454af2fe9@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 03/29/2018 12:11 PM, Christian Borntraeger wrote:
> 
> 
> On 03/29/2018 11:52 AM, Ming Lei wrote:
>> From the debugfs log, hctx0 is mapped to lots of CPU, so it shouldn't be
>> unmapped, could you check if it is hctx0 which is unmapped when the
>> warning is triggered? If not, what is the unmapped hctx? And you can do
>> that by adding one extra line:
>>
>> 	printk("unmapped hctx %d", hctx->queue_num);
> 
> Where do you want that printk?

And do you want it with or without the other patch that you have just sent?
