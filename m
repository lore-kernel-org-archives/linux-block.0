Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD3C433E2
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96472206E2
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="BqwoeXzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgGHRqs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgGHRqm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 13:46:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDE8C061A0B
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 10:46:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h28so42555939edz.0
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YL5AsViXRIQPP3nnxcSAhXVd5Sclqys9qPKvqwTLE3s=;
        b=BqwoeXzur9qY11GAMh8iUS8wGsJEaXOu2GlYF9jXCFgA4X/LbKWhkRlLbsGxsG4quO
         f/4ysQmlHFGhJyoq10wTbkMfhmiaBsNc/6LD79S5LL7nk8O5mZQQFIFcRS9uWFgy4IIQ
         tB6N3b53MhWziui+miF3b0ZhtRstiXMCJNKJwdMbglH0Nq4IXSPvcNMvQ2dNhF2iyTnN
         QIDtf/436iYjsDa7O1Dp18YI0wV83hP9tp0QVsGMC9Ckd7z/HknurMgHhL1EgFxJFAcZ
         5rKUOn6Wj07Oexl0x6NksHsjJEyaH6pkSntiMwZfbtFTQ5mYC+OxC6OuMo4+8q/PFLaO
         kc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YL5AsViXRIQPP3nnxcSAhXVd5Sclqys9qPKvqwTLE3s=;
        b=JkBjjEgmpgaSQTQvG6L+VDOsd75fIwpgdrxwzGAmfdRvgHuJ9sH93oJ6zdWrLk92Xl
         W+KO0vlH9rWt1t08o92yVJzDSOTuBxssP/Sxb72ddIfY6oyCc5UQ2abeZaAq6mOJ2wun
         YPhkpdgefU4N6NJYwrr/vrcjHeoiVbeU+h80FJJGicRVwqBo8/7mc+3J9B2eaWcuiU8A
         PG16B6SzbYog2EtJaB1iBD52SZnK/IsV8r2eKSpi03LQtGDVN+peOGjW/ckUXfYjeCll
         So/0IpdcjRcJ5Lscg5Xj4okNGef1C1eUGFqudc3NXCvqV9XwVVlVCPax5WXcZAAu3PNH
         7WmA==
X-Gm-Message-State: AOAM533OLMukPAbAjENenPPLth80v29cVlvRWMf39WEYBeh4lFwVLxOH
        ZAIrwJo7ytrMReAUeEFBXPWPlw==
X-Google-Smtp-Source: ABdhPJzJeR+VMnWx4BZ1QAluoyf+ygJqrRH9JtzKWxMrG3tpGatJs5b6/v3hHXBf4+s+4DGYPvzOjA==
X-Received: by 2002:a50:fa07:: with SMTP id b7mr66457602edq.298.1594230400781;
        Wed, 08 Jul 2020 10:46:40 -0700 (PDT)
Received: from [192.168.178.33] (i5C746C99.versanet.de. [92.116.108.153])
        by smtp.gmail.com with ESMTPSA id o15sm166196edv.55.2020.07.08.10.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 10:46:40 -0700 (PDT)
Subject: Re: [PATCH RFC 1/5] block: return ns precision from
 disk_start_io_acct
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-2-guoqing.jiang@cloud.ionos.com>
 <20200708132704.GB3340386@T590>
 <ad89a0b2-3b40-b515-2120-85bc0274165b@cloud.ionos.com>
Message-ID: <1796891f-66c3-09c4-559f-15d1d350d817@cloud.ionos.com>
Date:   Wed, 8 Jul 2020 19:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ad89a0b2-3b40-b515-2120-85bc0274165b@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/20 3:53 PM, Guoqing Jiang wrote:
>>
>> Cost of ktime_get_ns() can be observed as not cheap in high IOPS device,
>
> Could you share some links about it? Thanks.
>
>> so not sure the conversion is good. Also could you share what benefit 
>> we can
>> get with this change?
>
> Without the conversion, we have to track io latency with jiffies in 
> 4th patch.
> Then with HZ=100, some rows (such as 1ms, 2ms and 4ms) in that table
> don't make sense. 

Hmm, I can still output those rows based on HZ_TO_MSEC_NUM, which means
this patch can be dropped since the cost of ktime_get_ns is more expensive.

Thanks,
Guoqing
