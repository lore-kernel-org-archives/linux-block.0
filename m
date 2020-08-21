Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2FAC433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 14:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8ED2075E
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 14:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T1rDKM8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgHUOql (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgHUOqk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 10:46:40 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D477AC061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 07:46:39 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c6so1571128ilo.13
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/iB45LxSFJUxKYmdcuof137g+3Gn7H09VvxLf92jINM=;
        b=T1rDKM8e3H3CmnDotRzPGNfdbbv6Gciap2veMbOtMaxygcnsYvpbFyZHwGsgLIUKgx
         W6dHmn0pakIZ3K1NzmafH2/FHNy7AFPh5705M9iuodrrTKNZRxDXG+FLLN2UOfVtmJdS
         8ULi3dyEbvmfS2LVIMX+Cq/q8PwkXlYxXoTp33FzZqxBNG6rTXHJZ+cHJQ3JmUiSkirf
         KzWMX5lj3vv5RvsWUVIQwDAYnV1Avd77h1sbO6LUCxLqqvPN9WkHwYtnj5/OfGMY+Mbg
         r+lZhkcrstJ7xIYxtMzbvuJuRfgVz+HEbqNEqQQ1OmVaMHaDG1JaLuIS86Nq1ZsXyz7x
         M9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/iB45LxSFJUxKYmdcuof137g+3Gn7H09VvxLf92jINM=;
        b=Fs4yqyfavCvETxBkAXIMBpnbevTfeBbPyI4921ORAM9io2j001bepDjaJumRDSkEOt
         FiSAwUfpmUCaaNReDFY+6qsAwYo2GgDqMKZm82+i83jUBd+QFV2P95UoGsqfbLd9GJKT
         zBl+vJcYvm8ahGWGGb/w4qLCQgTfxNoUO1c+X1MWeG7XHRY6sboAkvhvKTEbsi2ci2Eg
         OEVjJJYz8H+DrnneJR7dYP87FDTkmx19Rk3MibisMEUazvK4mbjWoqtnO58kmlF6GHwG
         +i59azuujYwwsZA6g/xa0Mj2t/60zVa5A2aomhDD6RmDeeQJ1Ws+9feNCi234jZyz1Oi
         GttQ==
X-Gm-Message-State: AOAM530CthZRaaZokP8jz+Jz61et5GEBlx9f44gslxypFsTGVbuwyjfj
        AcPQCf/19vDrFMDdNKC7fnRSbg==
X-Google-Smtp-Source: ABdhPJxFdYgHUt/zf9twLI7GVwJhIlOOeTSywNd+AKRqPUDVRWitVO1GIqEQkz6Et7gd3J8M2MfNSw==
X-Received: by 2002:a05:6e02:673:: with SMTP id l19mr2756665ilt.121.1598021199124;
        Fri, 21 Aug 2020 07:46:39 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p7sm1301086ilj.56.2020.08.21.07.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:46:38 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
References: <20200820030248.2809559-1-ming.lei@redhat.com>
 <20200821063448.GF28559@lst.de> <20200821101617.GA3125762@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <85b14d60-d5f8-2ae9-8717-2e655fbd16c0@kernel.dk>
Date:   Fri, 21 Aug 2020 08:46:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821101617.GA3125762@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/20 4:16 AM, Ming Lei wrote:
> On Fri, Aug 21, 2020 at 08:34:48AM +0200, Christoph Hellwig wrote:
>>> -static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
>>> -	__releases(hctx->srcu)
>>> +static void hctx_unlock(struct blk_mq_hw_ctx *hctx)
>>>  {
>>>  	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
>>>  		rcu_read_unlock();
>>>  	else
>>> -		srcu_read_unlock(hctx->srcu, srcu_idx);
>>> +		percpu_ref_put(&hctx->queue->dispatch_counter);
>>
>> While you're at it:  can we avoid the pointless inversion in the if
>> statement and just do:
>>
>>  	if (hctx->flags & BLK_MQ_F_BLOCKING)
>> 		percpu_ref_put(&hctx->queue->dispatch_counter);
>> 	else
>> 		rcu_read_unlock();
> 
> OK, will do that, but strictly speaking they don't belong to this patch.

Yeah let's please not mix up the two.

-- 
Jens Axboe

