Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F5C433DB
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 02:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D95964DD3
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 02:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhA1Cyw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 21:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhA1Cys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 21:54:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE84C061574
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 18:54:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cq1so3004910pjb.4
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 18:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z34EMXbcc/pwjLv/TbQcBPIUKWf7ItMnjSIWKA7ZVEQ=;
        b=AqlvFjN5sjVFa/wHbZWp/nevGY/mTUOTwgJO/5nltAv3fK4c9LtHIW6ohzqCQso8+p
         JHzQgPgkQg1CuqtNV/LeG7jBtGn3qz5edXfFypmTH9Ycz6Fwu2PectPWp4X9LCkytUoQ
         4PE7hc9dvwQ0IgR2HMNYVHjeo1WCaYyNpt/JompfkDXoF6PiDl2ClA/zBOI7n6g3ErqB
         NsYjRQHwctpYzh/8nGpCGdtm3RPzuRFQnxaCodP9VLEgmrSaHgyViEu4abMfvluID/7K
         EQ0A9kjmfZEfkyVM0lgLXAOWF+OOIwpfUqjjwUprpGF3IaxI9/JtgOEa/9jCfGV53joa
         tBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z34EMXbcc/pwjLv/TbQcBPIUKWf7ItMnjSIWKA7ZVEQ=;
        b=KO0RkJxjj/cWjpdob4pLoNR5YaPHsL1KUlJa1FmZbv0ayXgn2MUlya/YnGI274uaJW
         yBO9YRpCb/u4txZF5nc0eTILj7mK46pDQNamyhK0zKmZl/+cODQGL8bZ8mO0rijBAHRs
         ZrKAww65N5DrgsmUaT9ZV6BfUuf0qtNiJD3pya7438dKnE5ttpw80Er+YAOmtpsaJiQ4
         61sZk9eKePdkYQA7pOt58MdZCojQ4Rls2EYhQ/gF51wEDn+SIRYBKXXB3ejAblYKzvpT
         jr31NpKNCn7KJMLYFHP5JtLm/z3YHlbyVTH6nxV1QtFeoNaqJHY+fwOiVHJJOCGUeSkt
         hPzA==
X-Gm-Message-State: AOAM533OOkY0Tyika/7owDmTRaEu/G5CH1e/Wd8X3SweWmkPDZmI8v0w
        lYoLVtC+qxdRfR/7uc3aiznepQ==
X-Google-Smtp-Source: ABdhPJz1DW39NsufcK8k6jFoR1QJVNiqDn+Z9Q0DGCQTr71mDlLNHy+fqj6qJGVooUQGe/Wd37RVkg==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr8958826pjt.144.1611802446599;
        Wed, 27 Jan 2021 18:54:06 -0800 (PST)
Received: from [10.8.1.98] ([89.187.162.118])
        by smtp.gmail.com with ESMTPSA id 78sm3534348pfx.127.2021.01.27.18.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 18:54:05 -0800 (PST)
Subject: Re: [PATCH 4/4] block: call blk_additional_{latency,sector} only when
 io_extra_stats is true
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
References: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
 <20210127145930.8826-5-guoqing.jiang@cloud.ionos.com>
 <20210127170914.GA1732537@infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <9f597649-3b44-c387-0218-63e369bb13bc@cloud.ionos.com>
Date:   Thu, 28 Jan 2021 03:53:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127170914.GA1732537@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On 1/27/21 18:09, Christoph Hellwig wrote:
> On Wed, Jan 27, 2021 at 03:59:30PM +0100, Guoqing Jiang wrote:
>> +		if (blk_queue_io_extra_stat(req->q))
>> +			blk_additional_sector(req->part, sgrp, bytes >> SECTOR_SHIFT);
> 
> This is completely unreadable due to the long line.
> 

Hmm, then how about move the check into blk_additional_{sector,latency}
to make the code more readable.

Thanks,
Guoqing
