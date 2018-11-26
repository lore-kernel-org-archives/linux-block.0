Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C3C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 15:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FAC2086B
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 15:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DJ6qa2KU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FAC2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeK0CMJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:12:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39752 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeK0CMJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 21:12:09 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so28192256itl.4
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 07:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zRp44ijtzCWgQxOHi0Byi212voE6Wq8NaaVMa826J4w=;
        b=DJ6qa2KUQQiX/CAHbq4unc8n0+xuN6rIkhyB+xRjhzSoHO+KlNBe3H9GwUnCJqxzTw
         7K6FPpLG9vMedzhInGgXwxsFw/O7u30O+2JTMFgACNKp17bdcwCeHhehExDXDYY7fw4b
         Dr46wHM15OQEzyRHbh3Ywx39zwsoBpi8dPikJSkgq4yuW6FIxSP3994YsUkyK72NLU4/
         tr13UScMXNbvWYXUrQvqY+lJUAP7o87fS9vycQO5mksLsFDyJ8WuLQcZLFRAW7bw2xOl
         m9FfNSTlyMmZJIwDlsFAhP9GObFviCFeU76m4uLZUpWasjKoc9V2lLMoCMsEh0s92UeT
         gvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zRp44ijtzCWgQxOHi0Byi212voE6Wq8NaaVMa826J4w=;
        b=FHnwBTcCtv6i8syIz/C5rwTl/fyrAU6TH4cCPuF4MFV8iOh4AskKpbtNu0eqDmAVFD
         xDBlt2j7ZqGU430OM/lnc+iZZhHWrQwcPLedGlgO1EC7rc6jL/LATtp2QUyW+zNpMCUv
         XGFAg4KVSzXCX6678cBJRCdgeg9LxlXy/D23m8Kjdu0QKMmboVxd21T20h2xf+t/fyIr
         70kGU9/ESHUgzfbKV6FGz1rDWnK+S3y6LJn9DGhmIyutUwySzMfu62fvQak1FiN7pBIL
         Lf01ranBmOc7Cfcq6JpHTiOEy590dg8EeKJt2ykmZ7m15NqsiQaYnJAw1ILxkjluRf6s
         E6yA==
X-Gm-Message-State: AA+aEWYUePruurSSCKV03YHvuMmBiymslk27pjjBAarvjmOAsuBdZhvE
        BjmEMfp+4adk/GWueXiitDuAUrxs+d0=
X-Google-Smtp-Source: AJdET5f6ewW1tUy4RjY09fix1b/wyLNVn1U2PTLyt+sQ/kdLdJeo68NpR0v3SvAvFMkEL+y0p2/TtA==
X-Received: by 2002:a24:be06:: with SMTP id i6mr20947363itf.168.1543245463201;
        Mon, 26 Nov 2018 07:17:43 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m12sm171780ioh.69.2018.11.26.07.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 07:17:41 -0800 (PST)
Subject: Re: [PATCH 1/6] blk-mq: when polling for IO, look for any completion
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20181123183411.8708-1-axboe@kernel.dk>
 <20181123183411.8708-2-axboe@kernel.dk> <20181126081652.GA362@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b653445-2f81-10b9-494a-4a722ed9453a@kernel.dk>
Date:   Mon, 26 Nov 2018 08:17:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126081652.GA362@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/18 1:16 AM, Christoph Hellwig wrote:
>> -bool blk_poll(struct request_queue *q, blk_qc_t cookie)
>> +int blk_poll(struct request_queue *q, blk_qc_t cookie)
> 
> Can you add a comment explaining the return value?
> 
>>  {
>>  	if (!q->poll_fn || !blk_qc_t_valid(cookie))
>>  		return false;
> 
> And false certainly isn't an integer constant..

Done

-- 
Jens Axboe

