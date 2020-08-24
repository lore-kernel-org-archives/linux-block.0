Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585A5C433DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 14:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275C2206B5
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 14:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="LRcIbwUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgHXOCx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 10:02:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C35C061573
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 07:02:50 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so6174300qtm.10
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SmCXwO9+2QUe5/jHo85GDFvGgT3nxZNKM053yNO6sE8=;
        b=LRcIbwUtWpk653iVTg1ZngI9kNr4SXeOUl+O4EqQXEmAjV7eXn9e7Ou6AJLy0GVdVs
         n4Ev/PBQ1NmCOELHbplLHLlgI4wNyTH5dsjis33voncQr55UaUnMfv4DaaAUum4Er6y6
         UDGe/cWsl3UixiVfZzQMaSvzVC72ygAn+rxLL9stWix1e/g2Mxa9NNEIfcz5sxIBUMNc
         LypJ89bxvUWpUHic/acQG8LYGYEgnFawH60PBA0Iv1FlM76X55OG6Va+u7TLuPjsnUGE
         AGQuUVSZcd9h9FC15f2085q91Ob9+GNLP98Sdn8uZScr4KVmlFcTKXFxp07OjSUcVsvE
         f4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SmCXwO9+2QUe5/jHo85GDFvGgT3nxZNKM053yNO6sE8=;
        b=M9kb/x0WdaxAccc4uYOVRwlAX9uD3HNXh3bEChkE1r/Y4iOx+odabzPR/0CAKn5Dfg
         Bzj+p1I8tfrx2mCZu3d8MfixvLcDS6UCib5kGDq2dHgFFe1M6Sjna0qlD2STZUCaf+BY
         kqAXyk9W7HZWRQp9eCBfkOnBVcfdK9orX9hsVHno7jHkRb1NNZjJytoqUSWg5RWby1J0
         yWr3SqQRaJUxHgm0E3M4u9DADgX+EmKqkE6ti9/3ulyqbRLqX+Nqm2XsnvlCK6qMGXvP
         r5dR8MYguXvxLIeTPmZoScjjbF3KvaEjbA0Vwa3PHbxvP3SvECEKcWhgczePZhBwavuG
         6U7Q==
X-Gm-Message-State: AOAM533jj24mBdLERmV9/wQ9VtFTQMHiw/5cvnCuKdTvRiPg71LU+sYH
        EMIkGiPcruYWNk+l+XlvgHHRVgbc9teQqAbF
X-Google-Smtp-Source: ABdhPJwS4PWlHFsjOgC0j8hNjllW1qMrU+jU50Kwe6oO5bSUg6mOlOAAZdNCuFOea7G56S3L+7H2Yg==
X-Received: by 2002:ac8:4b52:: with SMTP id e18mr4846190qts.231.1598277769476;
        Mon, 24 Aug 2020 07:02:49 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o72sm9657501qka.113.2020.08.24.07.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 07:02:48 -0700 (PDT)
Subject: Re: [PATCH] nbd: restore default timeout when setting it to zero
To:     Hou Pu <houpu@bytedance.com>, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
References: <20200810120044.2152-1-houpu@bytedance.com>
 <38b9de9e-38fe-3090-cea0-377c605c86d4@toxicpanda.com>
 <4e78e4b3-e75b-7428-703d-d8543bcfe348@bytedance.com>
 <1accbf37-1a57-f072-7dc4-063fee991189@toxicpanda.com>
 <701eaeb7-8b91-baa5-ebba-468f890c4cc5@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <59db0b1d-4b2c-7966-9c38-929083e7b8f1@toxicpanda.com>
Date:   Mon, 24 Aug 2020 10:02:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <701eaeb7-8b91-baa5-ebba-468f890c4cc5@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/23/20 11:23 PM, Hou Pu wrote:
> 
> 
> On 2020/8/21 9:57 PM, Josef Bacik wrote:
>> On 8/21/20 3:21 AM, Hou Pu wrote:
>>>
>>>
>>> On 2020/8/21 3:03 AM, Josef Bacik wrote:
>>>> On 8/10/20 8:00 AM, Hou Pu wrote:
>>>>> If we configured io timeout of nbd0 to 100s. Later after we
>>>>> finished using it, we configured nbd0 again and set the io
>>>>> timeout to 0. We expect it would timeout after 30 seconds
>>>>> and keep retry. But in fact we could not change the timeout
>>>>> when we set it to 0. the timeout is still the original 100s.
>>>>>
>>>>> So change the timeout to default 30s when we set it to zero.
>>>>> It also behaves same as commit 2da22da57348 ("nbd: fix zero
>>>>> cmd timeout handling v2").
>>>>>
>>>>> It becomes more important if we were reconfigure a nbd device
>>>>> and the io timeout it set to zero. Because it could take 30s
>>>>> to detect the new socket and thus io could be completed more
>>>>> quickly compared to 100s.
>>>>>
>>>>> Signed-off-by: Hou Pu <houpu@bytedance.com>
>>>>> ---
>>>>>   drivers/block/nbd.c | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>>>> index ce7e9f223b20..bc9dc1f847e1 100644
>>>>> --- a/drivers/block/nbd.c
>>>>> +++ b/drivers/block/nbd.c
>>>>> @@ -1360,6 +1360,8 @@ static void nbd_set_cmd_timeout(struct nbd_device 
>>>>> *nbd, u64 timeout)
>>>>>       nbd->tag_set.timeout = timeout * HZ;
>>>>>       if (timeout)
>>>>>           blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
>>>>> +    else
>>>>> +        blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
>>>>>   }
>>>>>   /* Must be called with config_lock held */
>>>>>
>>>>
>>>> What about the tag_set.timeout?  Thanks,
>>>
>>> I think user space could set io timeout to 0, thus we set tag_set.timeout = 0 
>>> here and also we should tell the block layer
>>> to restore 30s timeout in case it is not. tag_set.timeout == 0
>>> imply 30s io timeout and retrying after timeout.
>>>
>>> (Sorry, I am not sure if I understand your question here. Could
>>> you explain a little more if needed?)
>>>
>>
>> I misunderstood what I was using the tagset timeout for.  We don't want this 
>> here, if we're dropping a config for an nbd device and we want to reset it to 
>> defaults then we need to add this to nbd_config_put().  Thanks,
> 
> AFAIK If we killed a nbd server, then restarted it and reconfigured
> the nbd socket, I think we might not reconfigure IO timeout to 0 since
> nbd_config_put() is not called in such case. So could we still
> restore default timeout here. Or am I missing something?
> 

If you kill the NBD server then the config is going to be dropped and need to be 
reconfigured, so nbd_config_put() will definitely be called.  The only case it 
wouldn't be is if you are using the netlink interface, in which case the device 
is going to keep all of its original settings.  Are you not seeing the final 
nbd_config_put() being done when you kill the nbd server?  That seems like a bug 
if not, and that should be fixed, and then this timeout thing going in there 
will fix your issue.  Thanks,

Josef
