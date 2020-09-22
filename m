Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E9C4346E
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 03:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D5523A52
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 03:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Z+SpVVb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgIVDOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 23:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgIVDOs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 23:14:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5BC061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 20:14:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so11141409pfa.10
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 20:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4YXVximMVBk4Q6UzqjVcDGCl1/Wd0o9kuGFpPERfHQI=;
        b=Z+SpVVb7Ij+Y8UgdGhnnLcMTZiwFcxCcyvE7Byzj6qfh76qUkM++CVmQYT1fx22cJy
         nNFVtRFF28PFYk/9CFscq9z7//ZQvZ9uRNn8P8bBfY3TlhcVSrV8LVdzhFsF7EMYmm/C
         zrhLkGttmamKTFKtxNgLCqn8iABzKBl3mXbFSyiXI7J2PQuxjvkWHpzmYfV6vQWXuaTv
         Ra8XtuFx+lL8wiyGZsen4f+VjPXV7PiX0Rm1VgMjx4aGNk6kGVVxtVINfgwuGH1Tp4Yj
         1WjZZ90W9wZqToa8ZbEpOtKxYU6p56mh5asK8HpsrfZBYXdhcdv6CZnUYNC7MTWx8lNK
         FnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4YXVximMVBk4Q6UzqjVcDGCl1/Wd0o9kuGFpPERfHQI=;
        b=OA5FSFDxt21Cs0fWfDqd3pc8nKq7CS56zjDrgku3o/VoQqVymjD9QTilj0z5M54Ly3
         wrvRDFLyK7ALpE2Mj6ReaqcJOd4WW1M+co1eGzw7gmHxnOGz3s3BugRCocJSxLASe5g6
         2dNBiEb1h2cQ9Vxd6A2EuW8M6HqXvwfEEdQb5rXmY9LtBV0DbTpRUNHppNJ5kDUzrdeS
         B7CxJD/ndqTMT6C+KcH9VpvkdegSZCN7hZs0f/wwIeNv5pnhKuRcN5JAAYe4L++Qc60r
         xlzK4gne7gkRpxbJpwIbUDixhQw11AZkHDNTsG9U57l4cgziJOgZvLrc7BhV1h/qVEhX
         CZew==
X-Gm-Message-State: AOAM530oAIQgg82vsyiKdff4nDLNzcA7ldgrlie5crqgBFpmiVi/DsjO
        SjeJjrYs5QQqq2sXgBYaZ/vB/Fj1Kh5mlEAR
X-Google-Smtp-Source: ABdhPJy6DP8TrYoPxogFHwh1oyuiWXMB3U0lGvHgdorQR4n8kCfVq556Xs6gZDR4Sc+ZYsUkpVV7cQ==
X-Received: by 2002:a63:4a43:: with SMTP id j3mr2045193pgl.42.1600744487410;
        Mon, 21 Sep 2020 20:14:47 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id l78sm13145241pfd.26.2020.09.21.20.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 20:14:46 -0700 (PDT)
Subject: Re: [PATCH 2/3] nbd: unify behavior in timeout no matter how many
 sockets is configured
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20200921105718.29006-1-houpu@bytedance.com>
 <20200921105718.29006-3-houpu@bytedance.com>
 <7f56fc84-5fbd-cf4a-e1d7-c6a75396a6bf@toxicpanda.com>
From:   Hou Pu <houpu@bytedance.com>
Message-ID: <b451f14d-3ed1-e746-21c3-8dcf766ec91a@bytedance.com>
Date:   Tue, 22 Sep 2020 11:14:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7f56fc84-5fbd-cf4a-e1d7-c6a75396a6bf@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/9/22 2:01 AM, Josef Bacik wrote:
> On 9/21/20 6:57 AM, Hou Pu wrote:
>> When an nbd device is configured with multiple sockets, the request
>> is requeued to an active socket in xmit_timeout, the original socket
>> is closed if not.
>>
>> Some time, the backend nbd server hang, thus all sockets will be
>> dropped and the nbd device is not usable. It would be better to have an
>> option to wait for more time (just reset timer in nbd_xmit_timeout).
>> Like what we do if we only have one socket. This patch allows it.
>>
>> Signed-off-by: Hou Pu <houpu@bytedance.com>
>> ---
>>   drivers/block/nbd.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 538e9dcf5bf2..4c0bbb981cbc 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -400,8 +400,7 @@ static enum blk_eh_timer_return 
>> nbd_xmit_timeout(struct request *req,
>>           nbd->tag_set.timeout)
>>           goto error_out;
>> -    if (config->num_connections > 1 ||
>> -        (config->num_connections == 1 && nbd->tag_set.timeout)) {
>> +    if (nbd->tag_set.timeout) {
> 
> So now if you don't set a .timeout and have num_connections > 1 we don't 
> close the socket, so this won't work.  Thanks,
> 
> Josef

OK, will keep the behavior same as before when we don't set a .timeout
and num_connections > 1. And there is not need to keep this patch.
Will remove it in v2.

Thanks,
Hou
