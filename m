Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BB7C433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 15:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEF622B40
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 15:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="r5E4p6ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgHZPJO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgHZPJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 11:09:13 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9733EC061574
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 08:09:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g13so2443004ioo.9
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=336ES0xqziaj6CCNSx1pjCWxCs0YYHgihNQDLM+A614=;
        b=r5E4p6ciylfK7wGw1a2d1LzIohq2K4Gxmr5rUrozswxQYQzNJYHrElHFu174W2WW8L
         yVG4CLgTwkkJDcUCfjI/z0za0MZ6TeBi874tjHRfia/Tc4NSGAIouhuItvEo0U5ZRIqa
         /aQxWwO2IrQoIKpCb2wY/vgvpuU0kxHXofeW9fTTQcwzAoSGcHtkqRhG9NLv3hsKrsV4
         bpdpjCgwmHN599oGuWS61Z/Rmx4HMUv5gnDPb5FrxuhAm9LX66dRzBCH5Q4rPPsEMc8N
         MRxfLYO478Cuuxw4Y2cGXOmeqzvpevPIxlpq41zueN/OeRwxPJFQK2w/cAUn1ZJyxW4x
         B9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=336ES0xqziaj6CCNSx1pjCWxCs0YYHgihNQDLM+A614=;
        b=fOWDsYzBSoCqTdKWd29Z+AF8yWjPaO/QCmpVzm1J0uqbxHZ5DKwmNuyJGt/2qHGPEF
         an4mVKKdvJxBMHcyqncwtc5IKWjQ22aQJsHRoPa5gEVuM7xjVx1K+PVDes8h69VowIoR
         NBoJjVNuijJjbeZu84KkzHE2BQztD5DRRXrlur3pYm1Ry+vzx363w1kyu7ETVaSzNY5V
         zEDsrfajFKWovV1SOd+29fjqDap1W3/JW/o4MAjF3e7OfzizMMaSO+3hCqwShpBSbz5t
         k97O0czJGXRQQY/jHTZ4bP3GLzRu3t/4Rz8GaZF6Piza1n41eGuPbtB7kPk7jgt70Mp/
         qStQ==
X-Gm-Message-State: AOAM5302W70FoqQGpn+CT0WICeIMpyqrbdObTYCcCC5OQ5/szFd/K6/+
        xfcjZnmw+WdSeT2FtvqW7GVazQf4kew556AT
X-Google-Smtp-Source: ABdhPJywmPm8ctvgvnyPost/3VQwQH3KAKdtayohO/40izb8AJphSF3utPVB+n+b+f8nbNfg7GzADQ==
X-Received: by 2002:a6b:681a:: with SMTP id d26mr13346580ioc.70.1598454551848;
        Wed, 26 Aug 2020 08:09:11 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e68sm1267723iof.36.2020.08.26.08.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 08:09:11 -0700 (PDT)
Subject: Re: [PATCH] nbd: restore default timeout when setting it to zero
To:     Hou Pu <houpu@bytedance.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20200810120044.2152-1-houpu@bytedance.com>
 <38b9de9e-38fe-3090-cea0-377c605c86d4@toxicpanda.com>
 <4e78e4b3-e75b-7428-703d-d8543bcfe348@bytedance.com>
 <1accbf37-1a57-f072-7dc4-063fee991189@toxicpanda.com>
 <701eaeb7-8b91-baa5-ebba-468f890c4cc5@bytedance.com>
 <59db0b1d-4b2c-7966-9c38-929083e7b8f1@toxicpanda.com>
 <6f81b077-e722-1d0e-a506-5507f71540cd@bytedance.com>
 <27dc0e8c-e13b-4671-b739-30628696db7e@toxicpanda.com>
 <b527a43f-e6eb-6b80-6c61-e96c738a3bbc@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2867d116-7def-2f98-f469-11ac1c8ac423@kernel.dk>
Date:   Wed, 26 Aug 2020 09:09:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b527a43f-e6eb-6b80-6c61-e96c738a3bbc@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/20 7:51 PM, Hou Pu wrote:
> 
> 
> On 2020/8/26 1:29 上午, Josef Bacik wrote:
>> On 8/25/20 4:27 AM, Hou Pu wrote:
>>>
>>>
>>> On 2020/8/24 10:02 PM, Josef Bacik wrote:
>>>> On 8/23/20 11:23 PM, Hou Pu wrote:
>>>>>
>>>>>
>>>>> On 2020/8/21 9:57 PM, Josef Bacik wrote:
>>>>>> On 8/21/20 3:21 AM, Hou Pu wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2020/8/21 3:03 AM, Josef Bacik wrote:
>>>>>>>> On 8/10/20 8:00 AM, Hou Pu wrote:
>>>>>>>>> If we configured io timeout of nbd0 to 100s. Later after we
>>>>>>>>> finished using it, we configured nbd0 again and set the io
>>>>>>>>> timeout to 0. We expect it would timeout after 30 seconds
>>>>>>>>> and keep retry. But in fact we could not change the timeout
>>>>>>>>> when we set it to 0. the timeout is still the original 100s.
>>>>>>>>>
>>>>>>>>> So change the timeout to default 30s when we set it to zero.
>>>>>>>>> It also behaves same as commit 2da22da57348 ("nbd: fix zero
>>>>>>>>> cmd timeout handling v2").
>>>>>>>>>
>>>>>>>>> It becomes more important if we were reconfigure a nbd device
>>>>>>>>> and the io timeout it set to zero. Because it could take 30s
>>>>>>>>> to detect the new socket and thus io could be completed more
>>>>>>>>> quickly compared to 100s.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Hou Pu <houpu@bytedance.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/block/nbd.c | 2 ++
>>>>>>>>>   1 file changed, 2 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>>>>>>>> index ce7e9f223b20..bc9dc1f847e1 100644
>>>>>>>>> --- a/drivers/block/nbd.c
>>>>>>>>> +++ b/drivers/block/nbd.c
>>>>>>>>> @@ -1360,6 +1360,8 @@ static void nbd_set_cmd_timeout(struct 
>>>>>>>>> nbd_device *nbd, u64 timeout)
>>>>>>>>>       nbd->tag_set.timeout = timeout * HZ;
>>>>>>>>>       if (timeout)
>>>>>>>>>           blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
>>>>>>>>> +    else
>>>>>>>>> +        blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
>>>>>>>>>   }
>>>>>>>>>   /* Must be called with config_lock held */
>>>>>>>>>
>>>>>>>>
>>>>>>>> What about the tag_set.timeout?  Thanks,
>>>>>>>
>>>>>>> I think user space could set io timeout to 0, thus we set 
>>>>>>> tag_set.timeout = 0 here and also we should tell the block layer
>>>>>>> to restore 30s timeout in case it is not. tag_set.timeout == 0
>>>>>>> imply 30s io timeout and retrying after timeout.
>>>>>>>
>>>>>>> (Sorry, I am not sure if I understand your question here. Could
>>>>>>> you explain a little more if needed?)
>>>>>>>
>>>>>>
>>>>>> I misunderstood what I was using the tagset timeout for.  We don't 
>>>>>> want this here, if we're dropping a config for an nbd device and we 
>>>>>> want to reset it to defaults then we need to add this to 
>>>>>> nbd_config_put().  Thanks,
>>>>>
>>>>> AFAIK If we killed a nbd server, then restarted it and reconfigured
>>>>> the nbd socket, I think we might not reconfigure IO timeout to 0 since
>>>>> nbd_config_put() is not called in such case. So could we still
>>>>> restore default timeout here. Or am I missing something?
>>>>>
>>>>
>>>> If you kill the NBD server then the config is going to be dropped and 
>>>> need to be reconfigured, so nbd_config_put() will definitely be 
>>>> called. The only case it wouldn't be is if you are using the netlink 
>>>> interface, in which case the device is going to keep all of its 
>>>> original settings. Are you not seeing the final nbd_config_put() 
>>>> being done when you kill the nbd server?  That seems like a bug if 
>>>> not, and that should be fixed, and then this timeout thing going in 
>>>> there will fix your issue.  Thanks,
>>>
>>> I was using the netlink interface. So I could use the reconnect
>>> feature to update the nbd server without impacting the user of
>>> nbd device.
>>>
>>> I did not see the final nbd_config_put() when I killed the nbd server.
>>> After I killed the nbd server, the recv_work() put 1 config_ref.
>>> Another ref count is still held by nbd_genl_connect(). I thought it
>>> was as expected.
>>>
>>> Beside in nbd_genl_reconfigure(), it is checked nbd->config_refs should
>>> not be zero by:
>>>          if (!refcount_inc_not_zero(&nbd->config_refs)) {
>>>                  dev_err(nbd_to_dev(nbd),
>>>                          "not configured, cannot reconfigure\n");
>>>                  nbd_put(nbd);
>>>                  return -EINVAL;
>>>          }
>>> So AFAIK this behavior is as expected.
>>
>> Ahh ok I see what you're getting at.  Ok I agree, you can add
>>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks for your review,

Applied, thanks.

-- 
Jens Axboe

