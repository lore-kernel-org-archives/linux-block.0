Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE16ECAAD1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 15:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiH3PKo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiH3PKk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 11:10:40 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F372EC8
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 08:10:28 -0700 (PDT)
Subject: Re: [PATCH 1/3] rnbd-srv: fix the return value of rnbd_srv_rdma_ev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661872226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5FDMpKino5BuPkL1JtNXFCUgRzMr4tUbLamInPsJbo=;
        b=GKQl68AvwwN5AaBlD8ZQ13kCrvjLCKK1KCgJicNX4bBZ5JeezeDzQcvbgn12gowkuwHHXX
        Kqg9sCqeoFxh2vt/hF99niLMBRdbtdJbHpQeYv3n2xdNXOwnXUOulPAO9r4W+becnXl06x
        xkItH7ahtsPO1DNlquv6mATFgk6WXsE=
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     jinpu.wang@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
References: <20220830123904.26671-1-guoqing.jiang@linux.dev>
 <20220830123904.26671-2-guoqing.jiang@linux.dev>
 <CAJpMwyhT4mnbA4xi2xD4-EeJeXNJL6oQ66QfbddnPdZZBWA2_g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <8765c12f-eb29-b5f5-b15f-5d09e32eca21@linux.dev>
Date:   Tue, 30 Aug 2022 23:10:20 +0800
MIME-Version: 1.0
In-Reply-To: <CAJpMwyhT4mnbA4xi2xD4-EeJeXNJL6oQ66QfbddnPdZZBWA2_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/30/22 9:28 PM, Haris Iqbal wrote:
> On Tue, Aug 30, 2022 at 2:39 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> Since process_msg_open could fail, we should return 'ret'
>> instead of '0' at the end of function.
>>
>> Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/block/rnbd/rnbd-srv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
>> index 3f6c268e04ef..9182d45cb9be 100644
>> --- a/drivers/block/rnbd/rnbd-srv.c
>> +++ b/drivers/block/rnbd/rnbd-srv.c
>> @@ -403,7 +403,7 @@ static int rnbd_srv_rdma_ev(void *priv,
>>          }
>>
>>          rtrs_srv_resp_rdma(id, ret);
>> -       return 0;
>> +       return ret;
> I think the point here was to process the failure through
> rtrs_srv_resp_rdma() function. If you notice how the return of rdma_ev
> is processed by RTRS, in case of a failure return; it tries to send a
> response back through send_io_resp_imm(). Same would happen in the
> function rtrs_srv_resp_rdma().
>
> If we call rtrs_srv_resp_rdma() with the error, and return the err
> back to the caller of rdma_ev, we may end up sending err response more
> than once.

Thanks for the explanation, I am wondering if it makes sense to call
rtrs_srv_resp_rdma when ret == 0, or let's just add a comment here.

Thanks,
Guoqing
