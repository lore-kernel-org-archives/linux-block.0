Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF35C7EE29
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 01:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjEXBgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 21:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjEXBgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 21:36:01 -0400
X-Greylist: delayed 63712 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 18:36:00 PDT
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E72130
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 18:36:00 -0700 (PDT)
Message-ID: <067778a0-1439-c2c5-69f4-f2e7c3fa397c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684892158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t15oiyWkAyK94pY/kMy/fkhQCLM+mwONyUU5OtQa+Ik=;
        b=RehE0eewA/R28BScKJDGXkksbXX2PLuNgGTX9y4zkS2Sqa5RO0cm31bUS+kLpqX1z4MHUm
        sMz3Mfzx5qSZa8UZWELShmNlSkK5wLaE7xiHzhz2rnhHT2JBvDg/+qRfKI57OUNpZHv9xB
        EoByIueyeAH/dMNjdsuTz2Ut4CGG8Dk=
Date:   Wed, 24 May 2023 09:35:55 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 05/10] block/rnbd-srv: defer the allocation of
 rnbd_io_private
Content-Language: en-US
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
 <20230523075331.32250-6-guoqing.jiang@linux.dev>
 <CAMGffEkhcOZtiQOeoHTyStU8ba7n2QbC9eb_MVAixUBkCx8R5A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAMGffEkhcOZtiQOeoHTyStU8ba7n2QbC9eb_MVAixUBkCx8R5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/23/23 17:29, Jinpu Wang wrote:
> On Tue, May 23, 2023 at 9:53 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> Only allocate priv after session is available.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/block/rnbd/rnbd-srv.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
>> index c4122e65b36a..b4c880759a52 100644
>> --- a/drivers/block/rnbd/rnbd-srv.c
>> +++ b/drivers/block/rnbd/rnbd-srv.c
>> @@ -128,20 +128,17 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
>>
>>          trace_process_rdma(srv_sess, msg, id, datalen, usrlen);
>>
>> -       priv = kmalloc(sizeof(*priv), GFP_KERNEL);
>> -       if (!priv)
>> -               return -ENOMEM;
>> -
>>          dev_id = le32_to_cpu(msg->device_id);
>> -
>>          sess_dev = rnbd_get_sess_dev(dev_id, srv_sess);
>>          if (IS_ERR(sess_dev)) {
>>                  pr_err_ratelimited("Got I/O request on session %s for unknown device id %d\n",
>>                                     srv_sess->sessname, dev_id);
>> -               err = -ENOTCONN;
>> -               goto err;
>> +               return -ENOTCONN;
>>          }
>>
>> +       priv = kmalloc(sizeof(*priv), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
> before return you have to rnbd_put_sess_dev!
> it seems not much benefit with the change.

You are right, thanks for the review.

Guoqing
