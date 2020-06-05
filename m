Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D17BC433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 07:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17EB9206DC
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 07:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFEH0G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:26:06 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbgFEH0G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 03:26:06 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7C28693E25B74D2EBCBA;
        Fri,  5 Jun 2020 08:26:04 +0100 (IST)
Received: from [127.0.0.1] (10.210.169.114) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 5 Jun 2020
 08:26:03 +0100
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
To:     Ming Lei <ming.lei@redhat.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
 <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
 <20200604120747.GB2336493@T590>
 <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
 <20200604130058.GC2336493@T590>
 <83c37a8f-abfa-c1d1-e9d6-ccfdd344edb3@huawei.com>
 <20200605005915.GA2368173@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e7d97cfa-c0c3-180c-cfbd-976d90592ac1@huawei.com>
Date:   Fri, 5 Jun 2020 08:24:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200605005915.GA2368173@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.114]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/06/2020 01:59, Ming Lei wrote:
>> 	hctx5: default 36 37 38 39
>> 	hctx6: default 40 41 42 43
>> 	hctx7: default 44 45 46 47
>> 	hctx8: default 48 49 50 51
>> 	hctx9: default 52 53 54 55
>> 	hctx10: default 56 57 58 59
>> 	hctx11: default 60 61 62 63
>> 	hctx12: default 0 1 2 3
>> 	hctx13: default 4 5 6 7
>> 	hctx14: default 8 9 10 11
>> 	hctx15: default 12 13 14 15
> OK, the queue mapping is correct.
> 
> As I mentioned in another thread, the real hw tag may be set as wrong.
> 

I doubt this.

And I think that you should also be able to add the same debug to 
blk_mq_hctx_notify_offline() to see that there may be still driver tags 
allocated to when all the scheduler tags are free'd for any test in your 
env.

> You have to double check your cooked tag allocation algorithm and see if it
> can work well when more requests than real hw queue depth are queued to hisi_sas,
> and the correct way is to return SCSI_MLQUEUE_HOST_BUSY from .queuecommand().

Yeah, the LLDD would just reject requests in that scenario and we would 
know about it from logs etc.

Anyway, I'll continue to check.

Thanks,
John
