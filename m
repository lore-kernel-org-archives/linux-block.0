Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0D7C7EE2E
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 01:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbjEXBfN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 21:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjEXBfN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 21:35:13 -0400
X-Greylist: delayed 58450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 18:35:11 PDT
Received: from out-24.mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783E4130
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 18:35:11 -0700 (PDT)
Message-ID: <fd208b16-c191-4d2d-34a9-74e97bb16a33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684892109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i761iZFwKwqHtc07peEjJ/qvFbYoc54lHLPk4d5Gw9g=;
        b=fpTFPcxcbP+q7k96H5fTIPKd6BzYAoI2feC/5DeCzdADTH+grWRNwR5Y0sB2/u22k+h0Tt
        uwAtsEvBwvkvJscWmJY6lNtjC4yhcAMByV7d1Sm3POUXlFnroVcOFlyyN/xvqTNUnb6Ahx
        JDGWpI7Lolko19FC/VhFHBQSseG/osM=
Date:   Wed, 24 May 2023 09:35:05 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 04/10] block/rnbd-srv: no need to check sess_dev
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
 <20230523075331.32250-5-guoqing.jiang@linux.dev>
 <CAMGffEkw=A=WSSgW4ReCMV9h0TCOSWYLEqSUZPf3bfNgTXTp3g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAMGffEkw=A=WSSgW4ReCMV9h0TCOSWYLEqSUZPf3bfNgTXTp3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/23/23 17:27, Jinpu Wang wrote:
> On Tue, May 23, 2023 at 9:53 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> Check ret is enough since if sess_dev is NULL which also
>> implies ret should be 0.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/block/rnbd/rnbd-srv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
>> index e9ef6bd4b50c..c4122e65b36a 100644
>> --- a/drivers/block/rnbd/rnbd-srv.c
>> +++ b/drivers/block/rnbd/rnbd-srv.c
>> @@ -96,7 +96,7 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
>>                  ret = kref_get_unless_zero(&sess_dev->kref);
>>          rcu_read_unlock();
>>
>> -       if (!sess_dev || !ret)
>> +       if (!ret)
>>                  return ERR_PTR(-ENXIO);
>>
>>          return sess_dev;
>> --
>> 2.35.3
> This looks wrong, if you drop the check for !sess_dev, you have to
> check it later with IS_ERR_OR_NULL when call rnbd_get_sess_dev

How can it return NULL? Pls correct me if I am wrong.

1. If sess_dev is NULL then ret is 0, so it just returns ERR_PTR(-ENXIO).
2. If sess_dev is not NULL, we still rely on the checking of ret.

But I can drop it as well if you think it is obscure.

Thanks,
Guoqing
