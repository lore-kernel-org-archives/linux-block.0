Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BA6C433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 07:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1770020732
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 07:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="vlbqyzcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgHUHWU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgHUHWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 03:22:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C1C061386
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 00:22:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so593639pgh.6
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eTj4sOtsBgduTA8LS1xMja6ajQx/O8048Q0MLc3qi0o=;
        b=vlbqyzcgb7nws3A7MQCOO/leq4sFDvEby+SI2KOjrSK4RLQf6jgm6yUiogV07JzgHx
         5cQw7RI61uyXDb9vSh/pfn8o+knBga9WHaeK6zRTBcrFkEy3v1IFmQNsOfvG8ETE/HqD
         4Ny4MdJX7WFXhlSwMhVLo74IsIcFZzVzlikEVFRGrnLvah7B6KblOTiGeic7qGKKaXZG
         iXNqjE50uUPDRNGbU/PMg9BY0P9zaq+AS5UbRQWLhv0j+q2oallqaj06zX9x50ubU7lH
         mHdbHfpYzgG8+6E5hFdP0qixaAS2keHTdB6XHVgBRV4BSVKC8NlZm3rzzhcNnn0lVpr2
         2WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eTj4sOtsBgduTA8LS1xMja6ajQx/O8048Q0MLc3qi0o=;
        b=P+LHNWzb2CJhs8equMQ+kmgJtuQ4HHEYApqZmw6QZdzFAI8vwrH61t9jdzuRVsbG4O
         sUXpxLluHuw/NsYPINqfTJztT4BL7U2U2Ix/TbYiVOdP1kWqDL+WncnM0FdLwQ1qxwTs
         QPy1aR7xr+d3bHXmDWm4Pw1EOzuDDv1IK3s5M2RkXU2OUqpCn8A0HASo+8/9N7Fq57Df
         1Cky6fmfNxWeiBNzDMRHvFwHuBMa+qCjILbDGsm+uHy/jRtOgROUQp0hzjrVy+DIhwAK
         ADDSTiiqmRYVZENlZmoDGLQWOcmRE2Dd6aR2uwt7dKcx1N891wRLKDN8okgCJIVKW8Cn
         5Fmg==
X-Gm-Message-State: AOAM533pu5CwQZhLOkqwbfm3kU3Bvv+PqAeAyxQbikYPED8FGK22+MPE
        V0+HiI1XiOvx2YHT6PngivpFLw==
X-Google-Smtp-Source: ABdhPJzarJgZXmeauttgW+isUhElUak/ija4XMgGoVt+m7CW/sZQPmpWDz2dB93lwn2OX/m2eyzrhQ==
X-Received: by 2002:a63:541e:: with SMTP id i30mr1428677pgb.47.1597994520294;
        Fri, 21 Aug 2020 00:22:00 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id b6sm1149853pgt.17.2020.08.21.00.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 00:21:59 -0700 (PDT)
Subject: Re: [PATCH] nbd: restore default timeout when setting it to zero
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
References: <20200810120044.2152-1-houpu@bytedance.com>
 <38b9de9e-38fe-3090-cea0-377c605c86d4@toxicpanda.com>
From:   Hou Pu <houpu@bytedance.com>
Message-ID: <4e78e4b3-e75b-7428-703d-d8543bcfe348@bytedance.com>
Date:   Fri, 21 Aug 2020 15:21:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <38b9de9e-38fe-3090-cea0-377c605c86d4@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/21 3:03 AM, Josef Bacik wrote:
> On 8/10/20 8:00 AM, Hou Pu wrote:
>> If we configured io timeout of nbd0 to 100s. Later after we
>> finished using it, we configured nbd0 again and set the io
>> timeout to 0. We expect it would timeout after 30 seconds
>> and keep retry. But in fact we could not change the timeout
>> when we set it to 0. the timeout is still the original 100s.
>>
>> So change the timeout to default 30s when we set it to zero.
>> It also behaves same as commit 2da22da57348 ("nbd: fix zero
>> cmd timeout handling v2").
>>
>> It becomes more important if we were reconfigure a nbd device
>> and the io timeout it set to zero. Because it could take 30s
>> to detect the new socket and thus io could be completed more
>> quickly compared to 100s.
>>
>> Signed-off-by: Hou Pu <houpu@bytedance.com>
>> ---
>>   drivers/block/nbd.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index ce7e9f223b20..bc9dc1f847e1 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1360,6 +1360,8 @@ static void nbd_set_cmd_timeout(struct 
>> nbd_device *nbd, u64 timeout)
>>       nbd->tag_set.timeout = timeout * HZ;
>>       if (timeout)
>>           blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
>> +    else
>> +        blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
>>   }
>>   /* Must be called with config_lock held */
>>
> 
> What about the tag_set.timeout?  Thanks,

I think user space could set io timeout to 0, thus we set 
tag_set.timeout = 0 here and also we should tell the block layer
to restore 30s timeout in case it is not. tag_set.timeout == 0
imply 30s io timeout and retrying after timeout.

(Sorry, I am not sure if I understand your question here. Could
you explain a little more if needed?)

Thanks,
Hou

> 
> Josef
