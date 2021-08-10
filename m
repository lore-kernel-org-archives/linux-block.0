Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC69C4338F
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 02:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBA060EDF
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 02:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhHJCTl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 22:19:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8387 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhHJCTk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 22:19:40 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GkGkd3Phqz85pk;
        Tue, 10 Aug 2021 10:15:21 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 10:19:17 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 10:19:16 +0800
Subject: Re: [PATCH] nbd: call genl_unregister_family() first in nbd_cleanup()
To:     Eric Blake <eblake@redhat.com>
CC:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20210805021946.978686-1-houtao1@huawei.com>
 <20210805155004.6l4gxrniih6vxisr@redhat.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <63570292-5b27-c619-4911-2f3db471f61f@huawei.com>
Date:   Tue, 10 Aug 2021 10:19:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210805155004.6l4gxrniih6vxisr@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Thanks for your suggestions. Will fix in v2.

Regards,

Tao

On 8/5/2021 11:50 PM, Eric Blake wrote:
> On Thu, Aug 05, 2021 at 10:19:46AM +0800, Hou Tao wrote:
>> Else there may be race between module removal and handling of
>> netlink command and will lead to oops as shown below:
> Grammar suggestion:
>
> Otherwise, there is a race between module removal and the handling of
> a netlink command, which can lead to the oops shown below:
>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  drivers/block/nbd.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 9a7c9a425ab0..0993d108d868 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -2492,6 +2492,12 @@ static void __exit nbd_cleanup(void)
>>  	struct nbd_device *nbd;
>>  	LIST_HEAD(del_list);
>>  
>> +	/*
>> +	 * Unregister netlink interface first to waiting
>> +	 * for the completion of netlink commands.
> Grammar suggestion: s/first/prior/
>
