Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A10EC433E1
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 03:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF72E206BE
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 03:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="PyvL2DEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHXDXY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Aug 2020 23:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgHXDXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Aug 2020 23:23:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EFEC061573
        for <linux-block@vger.kernel.org>; Sun, 23 Aug 2020 20:23:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so3887893pgm.7
        for <linux-block@vger.kernel.org>; Sun, 23 Aug 2020 20:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+JiC0giJA0MYcrcSlbtahDIbX8SVKKSEEk+p4agMCXM=;
        b=PyvL2DEN6k9wYXpr0eLynqAd6kGdGZ7XKvmJvqWA/7FXrk4nSefuPIxgKEwN92dCNY
         LpAf7x0teP88TPt/0pj9nPDIa6xCMBrNzwRLc94H0tviRh4wXssoYy9jXMISepe6VFiw
         /9u9QebEzdPGrpQEgQjSiiS6MJdHu+BaLycV5Ag2wZa/GL16a3DgKSg4LHo01fNby+o9
         X0xFkHN7XcXc7LseZbS1d1j9NjEXZxNGY6WpHAZg4Te1aKjemZsGCjUPqjVmn9z2STOC
         XoeIuFE7XdXDZX8PkFC/L5muVsGIE2WIF8Vg3hDLiaabI35BavaTgnyd+aLb0E+OudBO
         PBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+JiC0giJA0MYcrcSlbtahDIbX8SVKKSEEk+p4agMCXM=;
        b=k5GYgUn1WGMMqLEremBKN9vFvC6FckYAJ00NtZd9A3Sg6u21JrDRLZ61d7hjECRFFa
         zxalxZ+lXfU8bwurOdPK4CDNCn1sBmzihPeifD9w7wy1N7ANyuMxyZMrkwV9E+NgiVEx
         m5ygGqUY3+OMZk+XiFTy9hyNWinXj9X+Q0fN8+XTjrbWkYXpc6pO1wwHAw19J5K2Jby+
         YWlcfX5tcqfDjfovRQxpGvX1DP/OMSrKsAcIyKKZ2KEM/iEfnte8/XLH9PqaiEiwYtCH
         1mJRpQjZGtJzHqib6/e59jRJzgi2cKdKYiOd3SsE3/Pvfw5drniuDfYpF7VJKUwPEsbV
         gHog==
X-Gm-Message-State: AOAM530TycrbMTMIQHzR9tRMxNn3uypmgdTwRkwqhmDltI8sCIMiz2fk
        GYre9vF6kV4MKQ3UGgsHEuV+nE7KNTlnzw==
X-Google-Smtp-Source: ABdhPJyoEJnl0jhMrOYWAJqVSAFEPTXmvN2ilNwVpyKxZbf8KCzi5xHACRoNam5jzbEjDPsaqLSLZA==
X-Received: by 2002:a63:ce15:: with SMTP id y21mr2298850pgf.163.1598239403257;
        Sun, 23 Aug 2020 20:23:23 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id go12sm7815366pjb.2.2020.08.23.20.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 20:23:22 -0700 (PDT)
Subject: Re: [PATCH] nbd: restore default timeout when setting it to zero
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
References: <20200810120044.2152-1-houpu@bytedance.com>
 <38b9de9e-38fe-3090-cea0-377c605c86d4@toxicpanda.com>
 <4e78e4b3-e75b-7428-703d-d8543bcfe348@bytedance.com>
 <1accbf37-1a57-f072-7dc4-063fee991189@toxicpanda.com>
From:   Hou Pu <houpu@bytedance.com>
Message-ID: <701eaeb7-8b91-baa5-ebba-468f890c4cc5@bytedance.com>
Date:   Mon, 24 Aug 2020 11:23:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1accbf37-1a57-f072-7dc4-063fee991189@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/21 9:57 PM, Josef Bacik wrote:
> On 8/21/20 3:21 AM, Hou Pu wrote:
>>
>>
>> On 2020/8/21 3:03 AM, Josef Bacik wrote:
>>> On 8/10/20 8:00 AM, Hou Pu wrote:
>>>> If we configured io timeout of nbd0 to 100s. Later after we
>>>> finished using it, we configured nbd0 again and set the io
>>>> timeout to 0. We expect it would timeout after 30 seconds
>>>> and keep retry. But in fact we could not change the timeout
>>>> when we set it to 0. the timeout is still the original 100s.
>>>>
>>>> So change the timeout to default 30s when we set it to zero.
>>>> It also behaves same as commit 2da22da57348 ("nbd: fix zero
>>>> cmd timeout handling v2").
>>>>
>>>> It becomes more important if we were reconfigure a nbd device
>>>> and the io timeout it set to zero. Because it could take 30s
>>>> to detect the new socket and thus io could be completed more
>>>> quickly compared to 100s.
>>>>
>>>> Signed-off-by: Hou Pu <houpu@bytedance.com>
>>>> ---
>>>>   drivers/block/nbd.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>>> index ce7e9f223b20..bc9dc1f847e1 100644
>>>> --- a/drivers/block/nbd.c
>>>> +++ b/drivers/block/nbd.c
>>>> @@ -1360,6 +1360,8 @@ static void nbd_set_cmd_timeout(struct 
>>>> nbd_device *nbd, u64 timeout)
>>>>       nbd->tag_set.timeout = timeout * HZ;
>>>>       if (timeout)
>>>>           blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
>>>> +    else
>>>> +        blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
>>>>   }
>>>>   /* Must be called with config_lock held */
>>>>
>>>
>>> What about the tag_set.timeout?  Thanks,
>>
>> I think user space could set io timeout to 0, thus we set 
>> tag_set.timeout = 0 here and also we should tell the block layer
>> to restore 30s timeout in case it is not. tag_set.timeout == 0
>> imply 30s io timeout and retrying after timeout.
>>
>> (Sorry, I am not sure if I understand your question here. Could
>> you explain a little more if needed?)
>>
> 
> I misunderstood what I was using the tagset timeout for.  We don't want 
> this here, if we're dropping a config for an nbd device and we want to 
> reset it to defaults then we need to add this to nbd_config_put().  Thanks,

AFAIK If we killed a nbd server, then restarted it and reconfigured
the nbd socket, I think we might not reconfigure IO timeout to 0 since
nbd_config_put() is not called in such case. So could we still
restore default timeout here. Or am I missing something?

Thanks,
Hou

> 
> Josef
