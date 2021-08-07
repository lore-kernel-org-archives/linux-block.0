Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E59C4338F
	for <linux-block@archiver.kernel.org>; Sat,  7 Aug 2021 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC53D6101D
	for <linux-block@archiver.kernel.org>; Sat,  7 Aug 2021 16:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhHGQTb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Aug 2021 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhHGQTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Aug 2021 12:19:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5642C0613CF
        for <linux-block@vger.kernel.org>; Sat,  7 Aug 2021 09:19:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j3so11446977plx.4
        for <linux-block@vger.kernel.org>; Sat, 07 Aug 2021 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jyBzebSSlchrLQAMP8lLKMmyfmojiYtazje9CNMSlKg=;
        b=MaxxVks2IMBzQ2F9jCxLj/nSiEgTZ5pyDfrDxNCKpZWXarGCZq7vMZRx2Y9Es+aS+Q
         DvYaJvydaaTMlRNk4Dibcc4Na6xlqh3lSo2Rgh/y/+DSsddD9I7N2ujGneS4EtoybCwA
         jQIC3q0tys063u3jkCm8RnL3PTsWJeAOwcdw3AJ9TBKCpKZIae1rohekMUQox60hacb6
         tLQeJoBBbb3ZbH6i4NnnPeBZwHjUuimWAbpYsJIgu3T3jr306+6xr9lNhNQ9lG/Ysnbn
         gJ+3iLP9WJo9xMwJqbyOzTSeVwUc7r4WiOx8sTFmDh4w1srveOS0XcwsCljsysw8vYTT
         Ug4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jyBzebSSlchrLQAMP8lLKMmyfmojiYtazje9CNMSlKg=;
        b=nFJscw4gUf0Wmv0ptZujKV8WRvGSnO6zfb8KHfmkLlTTee25/67oXd5jbowrBUsMvV
         twI9GlKB1bo4aYwJ+C7HPo3USFqWFNMjQajR3Lvjm4tpjIaTw0VBloTk1fFeax0CY2Ql
         We9LZ/eePz957J4AtaKZWdH2yFj2UOxyC8AuqnnGv7wznYd8tLRwxDPLjvBzinghaXzc
         ivgCqPixq8WdbTmPxKz07RlmbJnpisr5vX5IDOchACRky9mdDcGn0/Hg7go/R/CBNn8I
         OiPF3PpjZu5lzswnBggxcIiGIH7sGjXvwHCDhZ1I85FahorThObGdMN64VM/BAkBTnwd
         qYPA==
X-Gm-Message-State: AOAM532RnOMQ4O0fsd9EzgCQxUx4aOigWJVccCg+ZrDvq1X5vVWBouOa
        CUd7LE02/I/rjVKqRNfZJJX9FQ==
X-Google-Smtp-Source: ABdhPJws9/JRHOcGdCKqQKGagRxgYns1/oS3OmZs0ZbHu68UHrNfNgca07uWSHK3QGqEEDJyDfYAkw==
X-Received: by 2002:a05:6a00:2a9:b029:3c4:cb96:5b with SMTP id q9-20020a056a0002a9b02903c4cb96005bmr10204096pfs.36.1628353140364;
        Sat, 07 Aug 2021 09:19:00 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id s7sm14313588pfk.12.2021.08.07.09.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 09:19:00 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] block: fix ioprio interface
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
 <20210806111857.488705-3-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0141fb21-c0dc-d743-6af9-c2b26d34c4ba@kernel.dk>
Date:   Sat, 7 Aug 2021 10:18:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210806111857.488705-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/21 5:18 AM, Damien Le Moal wrote:
> An iocb aio_reqprio field is 16-bits (u16) but often handled as an int
> in the block layer. E.g. ioprio_check_cap() takes an int as argument.

I'd just reference kiocb->ki_ioprio, that's transport agnostic.

Apart from that, this one looks fine to me. A better commit title
would do wonders too, though, it's very non-descript.

-- 
Jens Axboe

