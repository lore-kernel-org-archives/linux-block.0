Return-Path: <SRS0=BuC1=RE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D1C43381
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 01:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FE22085A
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 01:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbfCAB1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:27:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732400AbfCAB1Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 20:27:25 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ECF566E6022BDC212B34;
        Fri,  1 Mar 2019 09:27:23 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Mar 2019
 09:27:17 +0800
Subject: Re: [PATCH 0/1] Fix NULL pointer dereference in register_disk
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>
References: <1550669225-77623-1-git-send-email-zhengbin13@huawei.com>
 <b88dc434-5e47-f446-896c-b1b75acefa11@kernel.dk>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <6a73ee68-73d5-cc08-afe7-be8e5251d018@huawei.com>
Date:   Fri, 1 Mar 2019 09:27:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <b88dc434-5e47-f446-896c-b1b75acefa11@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks

> That can/should be done when we actually deal with error handling properly
> in this path. I have applied your patch.

-->So when we will actually deal with error handling properly?

On 2019/3/1 5:02, Jens Axboe wrote:
> On 2/20/19 6:27 AM, zhengbin wrote:
>> When I use syzkaller test kernel, there is a NULL pointer dereference
>> in register_disk. The better solution is add return code to
>> __device_add_disk. There is a patchset(http://lists.infradead.org/pipermail
>> /linux-nvme/2016-August/005860.html) from Fam Zheng, int this patchset, the
>> modify is as follows:
>>  int device_add_disk() {
>>         ...alloc A...
>>         retval = alloc B
>>         if (retval)
>>             goto fail;
>>         ...
>> 	fail:
>> 	    return retval;  --->did not free A
>>    }
>> There are many callers, ie:
>> loop_add-->add_disk-->device_add_disk-->__device_add_disk
>> loop_remove-->del_gendisk
>> ----->This will free all resources, inclue B(free fail)
>>
>> Maybe the better way is that if device_add_disk return fail, it should
>> free all resources? This needs to modify all the callers(Otherwise the
>> callers will double free), unfortunately, I am not very familiar with it.
> 
> That can/should be done when we actually deal with error handling properly
> in this path. I have applied your patch.
> 

