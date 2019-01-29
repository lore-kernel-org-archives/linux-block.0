Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C4BC282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 03:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E663214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 03:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfA2D1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:27:47 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbfA2D1q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 22:27:46 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3E4D7C1DFBDAE7BD24C4;
        Tue, 29 Jan 2019 11:27:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 29 Jan 2019
 11:27:42 +0800
Subject: Re: [PATCH] floppy: check_events callback should not return a
 negative number
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <axboe@kernel.dk>, <osandov@fb.com>, <linux-block@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20190128090646.44747-1-yuyufen@huawei.com>
 <20190128131942.GH1795@kadam>
From:   yuyufen <yuyufen@huawei.com>
Message-ID: <0c53dcac-94db-a8a7-addf-673c29abe068@huawei.com>
Date:   Tue, 29 Jan 2019 11:27:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190128131942.GH1795@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/1/28 21:19, Dan Carpenter wrote:
> On Mon, Jan 28, 2019 at 05:06:46PM +0800, Yufen Yu wrote:
>> Since .check_events interface return an unsigned int value,
>> floppy_check_events() should not return a negative error number.
>> Otherwise, disk_check_events() may process wiht an unexpected path.
>>
>> fixes: a0c80efe5956 ("floppy: fix lock_fdc() signal handling")
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   drivers/block/floppy.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
>> index 6f2856c6d0f2..55481b40df9a 100644
>> --- a/drivers/block/floppy.c
>> +++ b/drivers/block/floppy.c
>> @@ -4075,7 +4075,7 @@ static unsigned int floppy_check_events(struct gendisk *disk,
>>   
>>   	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
>>   		if (lock_fdc(drive))
>> -			return -EINTR;
>> +			return 0;
> The patch is correct, but I wish the commit message had said what the
> run time impact of the patch is.  Or sometimes it's hard to say what the
> run time impact is, but it could have at least said why returning zero
> is correct.  Say something like:
>
>    floppy_check_events() is supposed to return bit flags to say which
>    events occured.  We should return zero to say that no event flags are
>    set.  Only BIT(0) and BIT(1) are used in the caller.  This code
>    returns -4u  here so both BIT(0) and BIT(1) are clear.  So this patch
>    shouldn't affect runtime, but it obviously is still worth fixing.

OK. Thanks a lot for your suggestion.

thanks,
Yufen

> regards,
> dan carpenter
>
> .
>


