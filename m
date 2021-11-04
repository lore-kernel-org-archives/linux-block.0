Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A6C433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FBB611CE
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhKDLgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhKDLgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 07:36:01 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEACAC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 04:33:22 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q203so6342107iod.12
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ySFcxw9wMfyr8BMF91t5JhJmlb4MRRFibYvBsHLWxHA=;
        b=Ew8Y8PO6EciDd7CqvRcMvv3nrP/sLjP/xNcGq0Y0cDd0NsYCwGDv8VCrP9RUivSuSE
         b8g44b2WuCOcBHdWWOBHgjrnXoKLkOHl0Ky/UFaHXCfl8jT2BzpAtuz4Mca/MDoIow2r
         NcsYkNey1Q63U88O2jhW5Rn5EskdicoSd8t8A6rgyIHxo70BfNtRg/cG8U9K3ndi2ANm
         sy52XdRHyJjyd5e+43tiDx99A1K8D2eQvP8pYRGRaWbotgAsKqVAqpELAbVtPxBw8bA8
         t8aLBMYWOCfBy3dbcEPETQO0+eG4CcjZo3hTF3cMSJl/SkckavDf/f2R3nVvB8/QPBko
         xYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ySFcxw9wMfyr8BMF91t5JhJmlb4MRRFibYvBsHLWxHA=;
        b=18DV6sDliOpDWKE9228Ib3hEkLQZAL04utGNrJ2grou8BaWE50mJP4qVlQ0ulDEGXp
         CbjyjveWZE0d+OjN/wOeaTiS2bLh+wYL+xkvSReC/Qlm/seV+B3XhYPkbw1THZ7bNKQa
         Lfqi0OPEqNzJQCOGHyZ8+mP+7W0K6PfvmDthAx+TXXjuRDE760b4z4ILbXDu+GzKWPA9
         lIEDU8HeO/b35ZvsJUZJjqtuliKMuAAM5oY+qcFMCW7rBfUCjFhPyWhxKHItxXcIce4s
         g/bacVdVpimxoRLlopFZrt/mqpWziVjRd22JLooIiK2AgKmCdfcVLB2ae66GxWK2kGGf
         i85g==
X-Gm-Message-State: AOAM531i+il4rXelpW1Jgl18LHXgQSr8Lka1bbsSrXTsPZiqFeWHa+vZ
        MEvMHhPRP9RyMQUHS9jVPcA8c5irIUb+uQ==
X-Google-Smtp-Source: ABdhPJw9xZilzlyd4plnRsa9TycS659RfOG3+bMbTaMzFH9+BYlm4+6tDOOyAsrPfplXCwtLgg1ZtQ==
X-Received: by 2002:a05:6638:2107:: with SMTP id n7mr3397326jaj.70.1636025601776;
        Thu, 04 Nov 2021 04:33:21 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l2sm2998046iln.50.2021.11.04.04.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 04:33:21 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: have plug stored requests hold references to
 the queue
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-2-axboe@kernel.dk> <YYOhbiRY0xFAyVEE@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a46ffbd9-1421-1a95-0b63-3fd8be1805d8@kernel.dk>
Date:   Thu, 4 Nov 2021 05:33:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYOhbiRY0xFAyVEE@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 3:01 AM, Christoph Hellwig wrote:
>> @@ -1643,7 +1643,7 @@ void blk_flush_plug(struct blk_plug *plug, bool from_schedule)
>>  		flush_plug_callbacks(plug, from_schedule);
>>  	if (!rq_list_empty(plug->mq_list))
>>  		blk_mq_flush_plug_list(plug, from_schedule);
>> -	if (unlikely(!from_schedule && plug->cached_rq))
>> +	if (unlikely(!rq_list_empty(plug->cached_rq)))
> 
> How is this related to the rest of the patch?

With references to the requests, flushing them even from a schedule
unplug condition is a lot saner in case someone is waiting on the
queue to quiesce.

-- 
Jens Axboe

