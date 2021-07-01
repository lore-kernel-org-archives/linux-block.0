Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B41DC11F69
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 16:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773E261413
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 16:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhGAQYS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhGAQYR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jul 2021 12:24:17 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCB6C061762
        for <linux-block@vger.kernel.org>; Thu,  1 Jul 2021 09:21:46 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 110-20020a9d0a770000b0290466fa79d098so7068863otg.9
        for <linux-block@vger.kernel.org>; Thu, 01 Jul 2021 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5ctwuOzYTxH+w7QPRbUBI8W8Uv2Zi+MZNjfb3ZcA0w=;
        b=DssjltuYR95C7O+JvnOBXNIs3jp9tL4sF3CagayPl4Cvs9XbXL3b9ENbCVy5h25B1g
         v5tCo8WVAtJNCB+3wwKEDbeFOdVfvnsLRUkF4Zz9m+DVG+4+Du/WoqOTa+N5lGhVXFqc
         MZ/Ans7LuJC58ZQCRki9He83LwhmiduG+J5AYJlw/vrLlqGon4NgkPg4VeCce3JzgXtS
         /yIRaBilUoq1Ll+oZRNswXdaMDIcM1cFXmuki76wMLHc876AzhQJbF1+8nq29OzAEfMQ
         XBGOevgkpRwUTl7LIEaGF0NDhR3/EZ1UvEOi2/4pwSrQ4rGvCY2mXvn74X1zbeVJrnEX
         sE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5ctwuOzYTxH+w7QPRbUBI8W8Uv2Zi+MZNjfb3ZcA0w=;
        b=KaThYAZ8R0Y0J6cM1/ufRy+tGsaOMF+S3tcVnkn1Y5rTqk/CT3mNCsZXyRYQctXoel
         +es1GLL6/aVn675m5Qd+XGls6B13IjNnHtwZRmLmzaTvpNkxWmAuqOVCHc0Jr93kZBlf
         bSwJ1rkO0CJ+gsVoQT81kqWWQ4lIDrPD22ugWmHjq22xkIxG9yaQhk2TIyTv2kxP3Y4R
         MMX0Zj9cVB+tf/qk3hd5HD2rTLMY6/IRjTEAm5tboiyQBqdVDnVLQ11n89j87V3B1yLv
         471eQOYgLOwDlLTGiE/glmXtGDdyzPg8wI4LS7skGjAuxILYxrmhZQJKMqOEuk4m4daF
         ljXg==
X-Gm-Message-State: AOAM530b0yyswU18uU0UwO7Har350QYSLIXCItEVMCqcQxvMZGftXBYb
        vCbDg7JxXVOT6hpflL7QUY/n6SUlc1jkqw==
X-Google-Smtp-Source: ABdhPJxN34CA3eBfHV5KTi8oP5NKjeqffYOzKAyQ1gSU54UzMYnlcW6F1Y7dW7vz4CCO9J+N7ACUXw==
X-Received: by 2002:a9d:480c:: with SMTP id c12mr694614otf.123.1625156505473;
        Thu, 01 Jul 2021 09:21:45 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id z6sm75146oiz.39.2021.07.01.09.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 09:21:45 -0700 (PDT)
Subject: Re: two fixup for the block_device / hd_struct merge
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210701081638.246552-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a5d794b9-6ebb-1cf3-5cb0-219f1205af53@kernel.dk>
Date:   Thu, 1 Jul 2021 10:21:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210701081638.246552-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/21 2:16 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> find two fixes for the block_device / hd_struct merge series attached.

Applied, thanks.

-- 
Jens Axboe

