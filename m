Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAFFC43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 11:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiFVLNC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 07:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355022AbiFVLNB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 07:13:01 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423065BA
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 04:12:57 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] rnbd-clt: refactor rnbd_clt_change_capacity
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655896375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ou1sGhm6EW73TEGyaoCxFST2Iu1qPDa4jNN9L+8FVPw=;
        b=Hg6yBmtug/MVDJDlyR+ydiEEBwH/IiCwoXeyJc6VzNGCI1IZi8Uy0HZrWpnkWH2lD29rTk
        etRkPg4iQJXRaTr8zGjahh0dr+dHOONTHbP1+IAZGxLb467QQO19IwZ+k4RjrJJlaS9mo4
        RkF0hdGlpuvHgm5Zj9ZbeIZ9HzpUtt4=
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
References: <20220620034923.35633-1-guoqing.jiang@linux.dev>
 <20220620034923.35633-7-guoqing.jiang@linux.dev>
 <CAMGffE=N2hAvBQB_kt1ZcnqNBg7SHxZ=3jquR0fogatoad6WKA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <b5b2ca6a-cc90-9065-e737-da7f2e6f27ef@linux.dev>
Date:   Wed, 22 Jun 2022 19:12:51 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffE=N2hAvBQB_kt1ZcnqNBg7SHxZ=3jquR0fogatoad6WKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/22/22 6:57 PM, Jinpu Wang wrote:
> On Mon, Jun 20, 2022 at 5:50 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> 1. process_msg_open_rsp checks if capacity changed or not before call
>> rnbd_clt_change_capacity while the checking also make sense for
>> rnbd_clt_resize_dev_store, let's move the checking into the function.
>>
>> 2. change the parameter type to 'sector_t' then we don't need to cast
>> it from rnbd_clt_resize_dev_store, and update rnbd_clt_resize_disk too.
>>
>> 3. no need to checking the return value, make it return void.
>>
> better to split this into 3 patches.

Will do.

>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/block/rnbd/rnbd-clt-sysfs.c |  2 +-
>>   drivers/block/rnbd/rnbd-clt.c       | 24 ++++++++++++------------
>>   drivers/block/rnbd/rnbd-clt.h       |  2 +-
>>   3 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
>> index 2be5d87a3ca6..e7c7d9a68168 100644
>> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
>> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
>> @@ -376,7 +376,7 @@ static ssize_t rnbd_clt_resize_dev_store(struct kobject *kobj,
>>          if (ret)
>>                  return ret;
>>
>> -       ret = rnbd_clt_resize_disk(dev, (size_t)sectors);
>> +       ret = rnbd_clt_resize_disk(dev, sectors);
>>          if (ret)
>>                  return ret;
>>
>> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
>> index 2c63cd5ac09d..6c6c4ba3d41d 100644
>> --- a/drivers/block/rnbd/rnbd-clt.c
>> +++ b/drivers/block/rnbd/rnbd-clt.c
>> @@ -68,13 +68,18 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
>>          return refcount_inc_not_zero(&dev->refcount);
>>   }
>>
>> -static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
>> -                                   size_t new_nsectors)
>> +static void rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
>> +                                    sector_t new_nsectors)
>>   {
>> -       rnbd_clt_info(dev, "Device size changed from %llu to %zu sectors\n",
>> +       if (get_capacity(dev->gd) != new_nsectors)
>> +               return;
> This change is broken, it leads to resize no longer work, should be "=="

Yes, thanks for catch it.

Thanks,
Guoqing
