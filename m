Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C641C433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 13:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6584F20720
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 13:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="bsVrk+Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgHUN5p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgHUN5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 09:57:44 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15D2C061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 06:57:44 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x6so651234qvr.8
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vt8B4qHdUal95IqaET3W02YCHjGO9PrSEH2rm63LReQ=;
        b=bsVrk+FarUU3KMxx1IVcbNBj1HCftpAuXBu5+HZPxVOb+4NdmQcIst5W3PKaVqy1Vy
         CgfRFA9hULwq/i9VBM5Do5C3gQdFPxQzTV5HhulCBHfU/gCNuqWZFl2yMTjbHZybTqGP
         nathFYZiuMbseGIgXeauFCJo6q1/vAnSYjceMvKzLoEyJQkhsTjKStP8VzQRpclrT3Gi
         QJ6lmMBuXrwDbUdo3rTLpgFfxX1yzdDXANKNN7EPHjKPIUE2lcZ7pBAaDZLUqQqAP3fW
         svIm45bxhxce3gpHOXVFsTF6ou7gHOopixkgGUDJkp1ZWkojAqyscwPo00znMch6oTnc
         sM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vt8B4qHdUal95IqaET3W02YCHjGO9PrSEH2rm63LReQ=;
        b=DJ7F9zglGK5YEosLzwlLd+WOyb++8NGkAQqDkW+So6ynYaBGIksIUe/YZk3ImwYV/2
         E7GUfd+rEoX9Cxg+w6Gmj9ac+/u+MFH92WWWkwR6YD+w35sahhMd+7dQ7gmqs6stoIi+
         VRLvjJMu1hAxxN+J73oW+KXeVYE11qovK9kvsA5v2JCe5afMfBppATMgWRtYXeAA5jZ2
         19+1m5IUtgN9VT1MGlT/q8BpKIDlRGV2g3oeQ4FSc8NiwaEBGDHkbwzOawRewF3RFIp/
         4P7sZ0FUH3YCMtEzHknX+xMFqnDXy8M+3VmO2sW3EnaSVTIgOQeZZPHOm26V3vxx1Kbm
         +CJg==
X-Gm-Message-State: AOAM531mM3vOrhFug/dGzX7E1OavSe7U/LWlFaku9Lz50P1rrJDG+V2+
        zyLESyI0cp5VfgYr6skT9uZ2uQ==
X-Google-Smtp-Source: ABdhPJzi+FSEkO899fPqlo4IH6gvoK7KIZ6VvuWK95Z3bE8kE+NfQKmA2dafOT9PMOs3O8marQv+yg==
X-Received: by 2002:a0c:fbd1:: with SMTP id n17mr2539337qvp.4.1598018263498;
        Fri, 21 Aug 2020 06:57:43 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s4sm2093473qtn.34.2020.08.21.06.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:57:42 -0700 (PDT)
Subject: Re: [PATCH] nbd: restore default timeout when setting it to zero
To:     Hou Pu <houpu@bytedance.com>, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
References: <20200810120044.2152-1-houpu@bytedance.com>
 <38b9de9e-38fe-3090-cea0-377c605c86d4@toxicpanda.com>
 <4e78e4b3-e75b-7428-703d-d8543bcfe348@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1accbf37-1a57-f072-7dc4-063fee991189@toxicpanda.com>
Date:   Fri, 21 Aug 2020 09:57:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4e78e4b3-e75b-7428-703d-d8543bcfe348@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/20 3:21 AM, Hou Pu wrote:
> 
> 
> On 2020/8/21 3:03 AM, Josef Bacik wrote:
>> On 8/10/20 8:00 AM, Hou Pu wrote:
>>> If we configured io timeout of nbd0 to 100s. Later after we
>>> finished using it, we configured nbd0 again and set the io
>>> timeout to 0. We expect it would timeout after 30 seconds
>>> and keep retry. But in fact we could not change the timeout
>>> when we set it to 0. the timeout is still the original 100s.
>>>
>>> So change the timeout to default 30s when we set it to zero.
>>> It also behaves same as commit 2da22da57348 ("nbd: fix zero
>>> cmd timeout handling v2").
>>>
>>> It becomes more important if we were reconfigure a nbd device
>>> and the io timeout it set to zero. Because it could take 30s
>>> to detect the new socket and thus io could be completed more
>>> quickly compared to 100s.
>>>
>>> Signed-off-by: Hou Pu <houpu@bytedance.com>
>>> ---
>>>   drivers/block/nbd.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>> index ce7e9f223b20..bc9dc1f847e1 100644
>>> --- a/drivers/block/nbd.c
>>> +++ b/drivers/block/nbd.c
>>> @@ -1360,6 +1360,8 @@ static void nbd_set_cmd_timeout(struct 
>>> nbd_device *nbd, u64 timeout)
>>>       nbd->tag_set.timeout = timeout * HZ;
>>>       if (timeout)
>>>           blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
>>> +    else
>>> +        blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
>>>   }
>>>   /* Must be called with config_lock held */
>>>
>>
>> What about the tag_set.timeout?  Thanks,
> 
> I think user space could set io timeout to 0, thus we set 
> tag_set.timeout = 0 here and also we should tell the block layer
> to restore 30s timeout in case it is not. tag_set.timeout == 0
> imply 30s io timeout and retrying after timeout.
> 
> (Sorry, I am not sure if I understand your question here. Could
> you explain a little more if needed?)
> 

I misunderstood what I was using the tagset timeout for.  We don't want 
this here, if we're dropping a config for an nbd device and we want to 
reset it to defaults then we need to add this to nbd_config_put().  Thanks,

Josef
