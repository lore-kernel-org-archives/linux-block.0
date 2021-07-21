Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C180AC636C9
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 16:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABDD60FE9
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 16:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhGUPir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhGUPir (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 11:38:47 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271BBC061575
        for <linux-block@vger.kernel.org>; Wed, 21 Jul 2021 09:19:24 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id i11-20020a4adf0b0000b0290263e1ba7ff9so191760oou.2
        for <linux-block@vger.kernel.org>; Wed, 21 Jul 2021 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V68QkkCRxVc1i8IofVKRhJiTH9nwdrtSj5K+hf6SL3A=;
        b=QmDN9hS4Aq/Di8SdCrH1vSQoFJ/Q/xVzyRhfkzJ22KWmfjcK0eH7T3dVqpvIG5LNMj
         6z6bK8tU33NlW6ci8Z53KcDlDdQVCly4q0vvcMPysc+SDXFkl9kJzd0uPnEJcuDt8etH
         xOJJRx5ljPtZ6z1WK7Z/wtV/ZTttvNoDU6ZTeVCVaa6KtRehPQi6mx8sWraywkqUwYHL
         PaWpU8RB9/rtkKEcq9c0+G+K+DHpoCoQK+HwG9Brxok5ZJWQEpABRdopI4zB3aF4miye
         JtfA69zuK+3fIlYfkTwiacsDcw4lXdeLOR8uPA/lSDPuGQ1VubBUIqn62kx+5pSJBnYI
         H8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V68QkkCRxVc1i8IofVKRhJiTH9nwdrtSj5K+hf6SL3A=;
        b=OrYsqf4n6jvvZPVNChRmzFKt9h6zDwbwgAaopVhvYK90bBkO8UKy2GZOEBOp3ybtX3
         99LOomuUAEi07nqtnzSi/ClpqAh9r72nQwhgqCMoqEtgeByuJbj3oRzWvHX5YNCSDKqt
         9VVHrk3w8h/ksfHDL21VoTSh3EZP1/Msb9Q1WyWJ5umkXzNUcqMneSf+zJIaZsOP+jo5
         I5VegkJW6xSIiCvkh5PDHVFj+Y4jTWrrnsJryW2qEbGMPbkNT/TGDne6VMUYeOymGUBZ
         fajj34/YRcoHT79rJgtVzRMkZq9M/pKd5l3GcBjdVlWV0TvXLdc/Pov3OjTUuU1qrvhK
         f0tQ==
X-Gm-Message-State: AOAM530es5ka+GaeJd7z4Kv1bwzp9YgfOdXXtlMTIixlCCJ+kUOPDraE
        Y7ax28ljQ/TlMA04ixrYvkGSNQ==
X-Google-Smtp-Source: ABdhPJxmd0ZvNnZChBwQgLueHKEhcVNjoVwuJY0/yhCLS27KajUWC8Yf9bCfh+Tqd9dxrZ2pLjJjyQ==
X-Received: by 2002:a4a:c3c1:: with SMTP id e1mr22457265ooq.93.1626884363447;
        Wed, 21 Jul 2021 09:19:23 -0700 (PDT)
Received: from [192.168.1.170] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p4sm4478415ooa.35.2021.07.21.09.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 09:19:23 -0700 (PDT)
Subject: Re: [PATCH] block/bfq: the delta_from_first should be ns rather than
 us
To:     Paolo Valente <paolo.valente@linaro.org>,
        liubaozhu <liubaozhu@uniontech.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210721063047.92122-1-liubaozhu@uniontech.com>
 <3A3B282C-FA5D-43F3-9C78-5E257C93A835@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd992897-2ef6-f574-eb07-5223fc6b1af5@kernel.dk>
Date:   Wed, 21 Jul 2021 10:19:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3A3B282C-FA5D-43F3-9C78-5E257C93A835@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/21 1:54 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 21 lug 2021, alle ore 08:30, liubaozhu <liubaozhu@uniontech.com <mailto:liubaozhu@uniontech.com>> ha scritto:
>>
>> In the block/bfq-iosched.c,the function bfq_update_peak_rate(),
>> bfqd->delta_from_first = now_ns - bfqd->first_dispatch,
>> according to the subtraction operation here,now_ns is ns,
>> and bfqd->first_dispatch is also ns,so bfqd->delta_from_first should be ns.
>>
> 
> Correct!
> 
> Acked-by: Paolo Valente <paolo.valente@linaro.org <mailto:paolo.valente@linaro.org>>

Just pick this up for your 5.15 series and include it in that.

-- 
Jens Axboe

