Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3527C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 07:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8602133D
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 07:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfDKHVr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:21:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbfDKHVq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 03:21:46 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3B99B148BE356977E6D2;
        Thu, 11 Apr 2019 15:21:39 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 11 Apr 2019
 15:21:33 +0800
Subject: Re: [PATCH] block: fix the return errno for direct IO
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "miaoxie@huawei.com" <miaoxie@huawei.com>,
        "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20190411064549.13318-1-yanaijie@huawei.com>
 <SN6PR04MB4527D003C972F9E689E71BE7862F0@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <850d21ef-6e37-8b32-f280-5293f3c37d68@huawei.com>
Date:   Thu, 11 Apr 2019 15:21:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB4527D003C972F9E689E71BE7862F0@SN6PR04MB4527.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chaitanya,

On 2019/4/11 14:57, Chaitanya Kulkarni wrote:
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 78d3257435c0..0fead5520a7e 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -84,7 +84,7 @@ void kill_bdev(struct block_device *bdev)
>>    
>>    	invalidate_bh_lrus();
>>    	truncate_inode_pages(mapping, 0);
>> -}	
>> +}
> Didn't understand above change, is it possible to get rid of above line
> change ?

Hi, there are some extra white space at the end of the line and my
editor removed those white space.

If people don't like this change, I can remove it.

Thanks,
Jason

