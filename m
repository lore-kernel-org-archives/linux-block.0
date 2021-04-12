Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E80DC433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC1DB61263
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbhDLMsF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbhDLMsF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 08:48:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31FFC061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:47:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id p12so9273407pgj.10
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SiZZmAGFJzNh1NTL9Ov9JrR8e1WGoFVfaLzDg2PWcPw=;
        b=SoINPW/HFJ7/YFi/BYThiKZ2W703vfAcxnxpm75zubpI521zcgrYMQWxRcAzbZKoi7
         427QQytY913I57pwvR+ofB5BEH+y7Hc/z3r21OcMTPTByU14r63usABVFyH3/xJGPq/l
         Za9QlZfCupBRILSJ3urNTRcMyg7nKm2CJU1twrGBhQp3PHBeT+WV/iQCkojjJrUmh1Po
         6sPcXCPshkXY5lDdyRxLemNm7BE1u5Ia5ZQGHlyqEeusYe8pXuvaQtYSKp1zdQ8WLArH
         gMXifNMzYAUWB9YrF3W61FcWeVe6HwDhHNxPxadrzAGuA9gU7c7eAXLal2lIisoHLwao
         PWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SiZZmAGFJzNh1NTL9Ov9JrR8e1WGoFVfaLzDg2PWcPw=;
        b=AnFAvd7tDWO0EsTKcAp2UP+FDXlcLKGA8DGoKXLM0vOydsXh+iEOO8tqMB9KkPYqGx
         e5OU60pC9XM279XukWEtScw9O376ncx8PnOJJGo19jsDjDYfhEvklaROZbmsHKWZtFu6
         v+6QhgPcLSkWHgddPM10tYWDCGgbWMEacwmFVBKE9E3oD5zy1k/vQAH4OQOxr9Bd8Rqd
         KcHFA2k5YTTnRMUakutgu/atnnyLufZXTrxIBXDMFwb5O3LXciLJTSA4gJOOZ7ov2lzI
         GR3EwO7V3f+DL9I/MRrQMpnc658UI1OLBqnx8HpZGI6TNh+tU2HYxu0zj1XH+C3VLf1r
         bNHw==
X-Gm-Message-State: AOAM530B5DGUcG3WcR9TA4RreC/0ySRjzSWXp4diRFjnYeUwUsBLuuzP
        bPpOnUQ2lX8QaG2Uq6Ww2jgRTw==
X-Google-Smtp-Source: ABdhPJySvSK6xalouznjEu6BAAZOUZsTf7n80eytcPTrV5KIoI+9UFDpEAq6DXp6xsYc99wJM7XbSg==
X-Received: by 2002:a63:174e:: with SMTP id 14mr26227020pgx.125.1618231667179;
        Mon, 12 Apr 2021 05:47:47 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q17sm10911871pfq.171.2021.04.12.05.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 05:47:46 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] null_blk: add option for managing virtual boundary
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc:     oren@nvidia.com, idanb@nvidia.com, yossike@nvidia.com,
        Damien.LeMoal@wdc.com, Chaitanya.Kulkarni@wdc.com
References: <20210412095523.278632-1-mgurtovoy@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af599b5f-0e1f-99c8-8d59-73fc48227d9c@kernel.dk>
Date:   Mon, 12 Apr 2021 06:47:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210412095523.278632-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/21 3:55 AM, Max Gurtovoy wrote:
> This will enable changing the virtual boundary of null blk devices. For
> now, null blk devices didn't have any restriction on the scatter/gather
> elements received from the block layer. Add a module parameter and a
> configfs option that will control the virtual boundary. This will
> enable testing the efficiency of the block layer bounce buffer in case
> a suitable application will send discontiguous IO to the given device.

Applied, thanks.

-- 
Jens Axboe

