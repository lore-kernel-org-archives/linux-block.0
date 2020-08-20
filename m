Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02FEC433E1
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 06:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9480E20855
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 06:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgHTGWi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:22:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgHTGWi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 02:22:38 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C82A776E5115F68AF5E8;
        Thu, 20 Aug 2020 14:22:34 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 14:22:33 +0800
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC:     <linux-block@vger.kernel.org>, <kbusch@kernel.org>, <axboe@fb.com>,
        <hch@lst.de>
References: <20200820035357.1634-1-lengchao@huawei.com>
 <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <a95ebc4b-8b9f-27bc-f64f-efebc2eb7f78@huawei.com>
Date:   Thu, 20 Aug 2020 14:22:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/20 12:33, Sagi Grimberg wrote:
> 
>> nvme_revalidate_disk translate return error to 0 if it is not a fatal
>> error, thus avoid false remove namespace. If return error less than 0,
>> now only ENOMEM be translated to 0, but other error except ENODEV,
>> such as EAGAIN or EBUSY etc, also need translate to 0.
>> Another reason for improving the error translation: If request timeout
>> when connect, __nvme_submit_sync_cmd will return
>> NVME_SC_HOST_ABORTED_CMD(>0). At this time, should terminate the
>> connect process, but falsely continue the connect process,
>> this may cause deadlock. Many functions which call
>> __nvme_submit_sync_cmd treat error code(> 0) as target not support and
>> continue, but NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both
>> are cancled io by host, to fix this bug, we need set the flag:
>> NVME_REQ_CANCELLED, thus __nvme_submit_sync_cmd will translate return
>> error to INTR. This is conflict with error translation of
>> nvme_revalidate_disk, may cause false remove namespace.
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   drivers/nvme/host/core.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 88cff309d8e4..43ac8a1ad65d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2130,10 +2130,10 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
>>        * Only fail the function if we got a fatal error back from the
>>        * device, otherwise ignore the error and just move on.
>>        */
>> -    if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
>> -        ret = 0;
>> -    else if (ret > 0)
>> +    if (ret > 0 && (ret & NVME_SC_DNR))
>>           ret = blk_status_to_errno(nvme_error_status(ret));
>> +    else if (ret != -ENODEV)
>> +        ret = 0;
>>       return ret;
> 
> We really need to take a step back here, I really don't like how
> we are growing implicit assumptions on how statuses are interpreted.
agree.
> 
> Why don't we remove the -ENODEV error propagation back and instead
> take care of it in the specific call-sites where we want to ignore
> errors with proper quirks?

Maybe we can do like this.
---
  drivers/nvme/host/core.c | 15 ++++-----------
  1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4..dc02208ff655 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2104,7 +2104,7 @@ static int _nvme_revalidate_disk(struct gendisk *disk)

  	ret = nvme_identify_ns(ctrl, ns->head->ns_id, &id);
  	if (ret)
-		goto out;
+		return 0;

  	if (id->ncap == 0) {
  		ret = -ENODEV;
@@ -2112,8 +2112,10 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
  	}

  	ret = nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
-	if (ret)
+	if (ret) {
+		ret = 0;
  		goto free_id;
+	}

  	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
  		dev_err(ctrl->device,
@@ -2125,15 +2127,6 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
  	ret = __nvme_revalidate_disk(disk, id);
  free_id:
  	kfree(id);
-out:
-	/*
-	 * Only fail the function if we got a fatal error back from the
-	 * device, otherwise ignore the error and just move on.
-	 */
-	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
-		ret = 0;
-	else if (ret > 0)
-		ret = blk_status_to_errno(nvme_error_status(ret));
  	return ret;
  }

-- 
