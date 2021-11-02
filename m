Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6625C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 22:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A0C600EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 22:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhKBWrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 18:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhKBWrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 18:47:17 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A1DC061714
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 15:44:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l19so701260ilk.0
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JdbS5UbolX9aie9TxRRQAzT2uYFrPgMXr4RUNUP5o9c=;
        b=WDBz631Mz0brP8ChYqjrAuzQcP2aBj+Wbip210xxQFWWHNaNBmKeWLnmLnPpEC0ICN
         tI7ppbESN5B9q1LrSCkTcoBANOEdqfsqf8tzjqYUub6h+ZhIrpOjIuOj2TSslUh3SWrm
         4mSPDPLy1VL+gwDU8aroldMPUrzmVFRYDlVihk9ocZ0sMekFig5/ylcLeZdxZ5QrdOjB
         aXGCGQHQ46pAVrgJMQVpNaoWyxGe3XbEGqPqEf/FSxqVaVRQhce2BDm5xtdwfEG3Brpd
         4cszMjQ39e+QZKK6p4B/jidW4l9TUasuzLSvX0qwuz78jLQdZcSd3fJfECID0y7bLC5K
         fvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JdbS5UbolX9aie9TxRRQAzT2uYFrPgMXr4RUNUP5o9c=;
        b=aeEJ0toTGyzNGkkmyvjdwrt0TJfNeL+KcDf694VjBsZcqPqtRDdBfRnMM1LBQ64TfI
         4IQ+OyLkcBwx105Q+irrzU6DthgoZjjCnbromg1FJIETu1PBuRoL3h4JlSZ8ohawDWLI
         QM/I30yuXp/dDDoCqPgK1ycTK8LMxHGZV+Uowh+SYZF0eCOtEnOWLaEBFqz4korrZzKN
         Jcd+IMkuwn/GQlBUbgUHSDHurifLp1evuFIme7cYSqEqixYTx9O1GMbYoCHqMeV/23Ps
         X/KBsOs5QaJRI4H+rORkjoOv3ceiHAzYrJ0L62pj9JXkhyQmtLCOlOyw56gHwwLsXbki
         WaEA==
X-Gm-Message-State: AOAM530ZaRrjwixXbE8BH8Rbt4FZJ6+1e5cDrRB2jID9kvOBlW+3JHRZ
        1YRuk26QRwBrtZ7fLaEcsTemOQPqzSsjuQ==
X-Google-Smtp-Source: ABdhPJxx6VDC0f9jyWTYQlTHURoumhK/30EUbBaQ+U5YGb2iVD8u2xtmL7LNjc8OSz/FgynM/2HgzA==
X-Received: by 2002:a05:6e02:17c8:: with SMTP id z8mr10061702ilu.19.1635893081471;
        Tue, 02 Nov 2021 15:44:41 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x11sm248144ilu.51.2021.11.02.15.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 15:44:41 -0700 (PDT)
Subject: Re: [PATCH V2 3/3] blk-mq: update hctx->nr_active in
 blk_mq_end_request_batch()
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <Keith.Busch@wdc.com>
References: <20211102153619.3627505-1-ming.lei@redhat.com>
 <20211102153619.3627505-4-ming.lei@redhat.com>
 <20211102224352.sv5fihsfpkqjghgl@shindev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4e2fe2fe-5088-46cd-8b9c-432aaca9ab06@kernel.dk>
Date:   Tue, 2 Nov 2021 16:44:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211102224352.sv5fihsfpkqjghgl@shindev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 4:43 PM, Shinichiro Kawasaki wrote:
> On Nov 02, 2021 / 23:36, Ming Lei wrote:
>> In case of shared tags and none io sched, batched completion still may
>> be run into, and hctx->nr_active is accounted when getting driver tag,
>> so it has to be updated in blk_mq_end_request_batch().
>>
>> Otherwise, hctx->nr_active may become same with queue depth, then
>> hctx_may_queue() always return false, then io hang is caused.
>>
>> Fixes the issue by updating the counter in batched way.
>>
>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Ming, thank you very much. I have confirmed that the blktests block/005 hang
> disappears using NVMe devices with two namespaces.
> 
> Though this patch is already queued up to for-5.16/block, in case it is still
> meaningful:
> 
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Testing is _always_ meaningful! So thanks for doing that, and reporting it in
the first place. The patch has been queued up this morning for 5.16.

-- 
Jens Axboe

