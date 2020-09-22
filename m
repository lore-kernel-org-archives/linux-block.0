Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F51C4346E
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 03:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC05723A52
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 03:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="O2cQ4DuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgIVDQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 23:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgIVDQy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 23:16:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C7C0613CF
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 20:16:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k14so10764172pgi.9
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 20:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W+JMCm/7C+eeBdc2FIHlSoejawqCGvJ6dxmgCl2tchk=;
        b=O2cQ4DuQFGwDIsmWH+MPBntdlaKVB5sGKnDSKhLwEaoCVAmR1/+xDefyCnfSM9CalR
         RGxywuecGkTavwgZyXNHLkaOp2Uxmhq+WQWEupDzFWeuovcobTJJ5BngSMqjPjEuDKkq
         xnrqAZKNhyxNcOg6aQRgmcM4/O2XFuvEe8U1/gWvtcFiYHh6aaMQxJJdXdkHYuXDr7+d
         ZB7HdlvOZLfSiJCViFn6sW7JpCekP28P8ethSgEHluv5M26yHaP0XvSz880ODnv4GlrJ
         eLnF2iDg4r//QPNDxdWtGlUNACajBu9kzMkDbAGMLm/qAd5eQXQ3hC+aGFJ5HUgzvST0
         +lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W+JMCm/7C+eeBdc2FIHlSoejawqCGvJ6dxmgCl2tchk=;
        b=WF2un9eNzQ8BSjV2qDdifoLGdJWJb9/DAKc/oQEMOYirVz7KCMo7xl4RX5qmvBDXQB
         dP9vhMV2nFfWyuGvcbBnDb1BJjbfDJQAPB/TogmZXiZqM2VYaQHHNwUvpgmxfhdvZNYQ
         PY2quizIqxjyYeBggKPQztzaLIP2I4wRZEUyRXu3GAuqpOQVc9ONiSXQPAFmxFgOzqi5
         V3wAhwBCKF4EcbeegKKnmQp5co/AkbO0ymADPNY85T0kTS97r0Aja4HEdsLESS7wmycA
         HsBQaECWroNEdZp4nrS8aDYhmUHG2JN01XlJTPjcUfkYtcqrpfD6vl9Y0OIcKmcMpUhs
         FufQ==
X-Gm-Message-State: AOAM533Eq6EbV+3P5iHJqNyhpU3T3mtqiExPlpt0ifJ7qyzAQEhdEK0i
        kFOdK3fUJeiso5HuMYgQx3ocXg==
X-Google-Smtp-Source: ABdhPJymm4UXc37ailVQHPxR98BCoUrBmrkycwOCv+TeTYnwdT13RT5KwoAilUXQMgs71DGPTyjbsQ==
X-Received: by 2002:a63:fe49:: with SMTP id x9mr1937157pgj.446.1600744613159;
        Mon, 21 Sep 2020 20:16:53 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id ep4sm675369pjb.39.2020.09.21.20.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 20:16:52 -0700 (PDT)
Subject: Re: [PATCH 3/3] nbd: introduce a client flag to do zero timeout
 handling
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20200921105718.29006-1-houpu@bytedance.com>
 <20200921105718.29006-4-houpu@bytedance.com>
 <7f680bff-a19e-3aff-c91e-98b2933826a9@toxicpanda.com>
From:   Hou Pu <houpu@bytedance.com>
Message-ID: <516e86aa-42d7-1820-600e-fba8d2e05882@bytedance.com>
Date:   Tue, 22 Sep 2020 11:16:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7f680bff-a19e-3aff-c91e-98b2933826a9@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/9/22 2:03 AM, Josef Bacik wrote:
> On 9/21/20 6:57 AM, Hou Pu wrote:
>> Introduce a dedicated client flag NBD_RT_WAIT_ON_TIMEOUT to reset
>> timer in nbd_xmit_timer instead of depending on tag_set.timeout == 0.
>> So that the timeout value could be configured by the user to
>> whatever they like instead of the default 30s. A smaller timeout
>> value allow us to detect if a new socket is reconfigured in a
>> shorter time. Thus the io could be requeued more quickly.
>>
>> The tag_set.timeout == 0 setting still works like before.
>>
>> Signed-off-by: Hou Pu <houpu@bytedance.com>
> 
> I like this idea in general, just a few comments below.

Thanks,
Hou

> 
>> ---
>>   drivers/block/nbd.c      | 25 ++++++++++++++++++++++++-
>>   include/uapi/linux/nbd.h |  4 ++++
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 4c0bbb981cbc..1d7a9de7bdcc 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -80,6 +80,7 @@ struct link_dead_args {
>>   #define NBD_RT_BOUND            5
>>   #define NBD_RT_DESTROY_ON_DISCONNECT    6
>>   #define NBD_RT_DISCONNECT_ON_CLOSE    7
>> +#define NBD_RT_WAIT_ON_TIMEOUT        8
>>   #define NBD_DESTROY_ON_DISCONNECT    0
>>   #define NBD_DISCONNECT_REQUESTED    1
>> @@ -378,6 +379,16 @@ static u32 req_to_nbd_cmd_type(struct request *req)
>>       }
>>   }
>> +static inline bool wait_on_timeout(struct nbd_device *nbd,
>> +                   struct nbd_config *config)
>> +{
>> +    if (test_bit(NBD_RT_WAIT_ON_TIMEOUT, &config->runtime_flags) ||
>> +        nbd->tag_set.timeout == 0)
>> +        return true;
>> +    else
>> +        return false;
>> +}
>> +
> 
> This obviously needs to be updated to match my comments from the 
> previous patch.

Thanks. Please see v2 latter.

> 
>>   static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>>                            bool reserved)
>>   {
>> @@ -400,7 +411,7 @@ static enum blk_eh_timer_return 
>> nbd_xmit_timeout(struct request *req,
>>           nbd->tag_set.timeout)
>>           goto error_out;
>> -    if (nbd->tag_set.timeout) {
>> +    if (!wait_on_timeout(nbd, config)) {
>>           dev_err_ratelimited(nbd_to_dev(nbd),
>>                       "Connection timed out, retrying (%d/%d alive)\n",
>>                       atomic_read(&config->live_connections),
>> @@ -1953,6 +1964,10 @@ static int nbd_genl_connect(struct sk_buff 
>> *skb, struct genl_info *info)
>>               set_bit(NBD_RT_DISCONNECT_ON_CLOSE,
>>                   &config->runtime_flags);
>>           }
>> +        if (flags & NBD_CFLAG_WAIT_ON_TIMEOUT) {
>> +            set_bit(NBD_RT_WAIT_ON_TIMEOUT,
>> +                &config->runtime_flags);
>> +        }
> 
> Documentation/process/coding-style.rst
> 
> "Do not unnecessarily use braces where a single statement will do."
> 
> same goes for below.  Thanks,
> 
> Josef

Thanks. Will fix this in v2.


Thanks,
Hou

