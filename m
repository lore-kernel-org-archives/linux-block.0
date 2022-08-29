Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35C6ECAAD4
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 04:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiH2E7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Aug 2022 00:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH2E73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2022 00:59:29 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD643335;
        Sun, 28 Aug 2022 21:59:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VNWwOOY_1661749163;
Received: from 30.97.56.171(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNWwOOY_1661749163)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 12:59:24 +0800
Message-ID: <39a21753-55b2-eb84-7d08-6cd9579c951c@linux.alibaba.com>
Date:   Mon, 29 Aug 2022 12:59:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 3/9] ublk_drv: add a helper to get ioucmd from pdu
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220824054744.77812-1-ZiyangZhang@linux.alibaba.com>
 <20220824054744.77812-4-ZiyangZhang@linux.alibaba.com>
 <YwwtUVl51B0ve0So@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YwwtUVl51B0ve0So@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/8/29 11:06, Ming Lei wrote:
> On Wed, Aug 24, 2022 at 01:47:38PM +0800, ZiyangZhang wrote:
>> We store pointer of task_work in pdu. And we should get ioucmd from pdu
>> since we prepare to only pass ioucmd to task_work function.
>>
>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
>> ---
>>  drivers/block/ublk_drv.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index e08f636b0b9d..8add6e3ae15f 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -555,6 +555,12 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
>>  	return (struct ublk_uring_cmd_pdu *)&ioucmd->pdu;
>>  }
>>  
>> +static inline struct io_uring_cmd *ublk_uring_cmd_from_pdu(
>> +			struct ublk_uring_cmd_pdu *pdu)
>> +{
>> +	return container_of((u8 *)pdu, struct io_uring_cmd, pdu[0]);
>> +}
>> +
> 
> Patch isn't supposed to be written in this way, it is one helper, either
> change its caller in this patch, or merge this one wth the patch which
> applies it.
> 
> Also looks this change belong to include/linux/io_uring.h if you think
> it is useful.

Maybe add a helper in include/linux/io_uring.h is good since ioucmd and pdu is
only used by NVMe and ublk_drv. NVMe does not need to transform pdu to ioucmd.
But in ublk_drv if we want to get ioucmd in task work, this transformation
is needed:

struct callback_head *work
		--> struct ublk_uring_cmd_pdu *pdu
      				--> struct io_uring_cmd *cmd

Regards,
Zhang
