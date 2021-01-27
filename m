Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A92C433E6
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF53A20789
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhA0QTC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbhA0QRW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 11:17:22 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B9C0613ED
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 08:16:41 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l18so1656107pji.3
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ednta+6yXbNhz5wLJka5IF2MWHxV+wNQ13bmIeWQsJk=;
        b=eAg+pYEGbaHJw4eO2afDCi/HtMXjXXY3dj2BLkDewHoT+wBnSYJt45aC10PHJnFZR2
         lr2LyylAJg7K2T9kPDuY+YNJzI3PzPfFLXFamxzWCe832ZRMX2IqZYKNi81bQMvWjHwm
         pfWe9TBchsdzVXFGs3InXadTzAxGlR6har0XujRTkDrzK6yTZq782rQ3Lt8AKIVojuCX
         qFdJUxNEIxjEbf99jI17Ao34i5WIk4pBVbwF3FcZ5W864fSRzgl6tkOUdB2prsUKBQKO
         D4r+8Blbg5vwnPMWCKfAh+yDSz2GK9T1ZjUv39S3im6eeLwm0rfyjFMoliWxa8zDReYl
         IOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ednta+6yXbNhz5wLJka5IF2MWHxV+wNQ13bmIeWQsJk=;
        b=SDT8lARwY5Fp8Oeg+6sgKnrbE5AQrPaZk/OW7qRA1AjGqgmzuUqEJ6H0n//GjzAHs+
         sBPfowKZieub4DIyENaDMqGqffm3ndBfnRKe3kSZmFzTz5rA3Ye8OwlW+Mq6TaHVA9nB
         t0uZlM9EIPV9I7TEh0LhGWxX6731BzHIlwojQIzR1EQy/Ejv0/2wKbmAaYVb6nRqAAlL
         b3+TiWJb+PkKz7G2gwPmCfmKDAbsU34x7NNmZTVa5MrAkXo+Hu5IpmESsL45gkkIPbNR
         gzX6r36fUij9d/wlxp5qhdbvnyhDHbiMdt2eterShl72Lz4/0GbH59tAG8vieq61rLr2
         nEKw==
X-Gm-Message-State: AOAM531TdIe5B+2f2IFGqMyUVoqIgVccwh307FXQfKyZ4Tfgbq0yJN5R
        T9Lh6dp0PruWNztS3sihlc1ZgQ==
X-Google-Smtp-Source: ABdhPJx4cs7LPOwSSwNxiwbkiEpe1IJNKwZVoM4mb39efm6PIS5BoseiRRxsaSHDLSgwFPHx8QyFpQ==
X-Received: by 2002:a17:902:bb90:b029:df:bdbb:be99 with SMTP id m16-20020a170902bb90b02900dfbdbbbe99mr12126959pls.52.1611764201475;
        Wed, 27 Jan 2021 08:16:41 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id y16sm3073206pgg.20.2021.01.27.08.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:16:40 -0800 (PST)
Subject: Re: [PATCH 0/3 v2] bfq: Two fixes and a cleanup for sequential
 readers
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20200605140837.5394-1-jack@suse.cz>
 <20210127152729.GA15748@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f435dbca-0fdb-dadc-7121-f4718a5b4215@kernel.dk>
Date:   Wed, 27 Jan 2021 09:16:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127152729.GA15748@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/21 8:27 AM, Jan Kara wrote:
> On Wed 13-01-21 11:09:24, Jan Kara wrote:
>> Hello,
>>
>> this patch series contains one tiny cleanup and two relatively simple fixes
>> for BFQ I've uncovered when analyzing behavior of four parallel sequential
>> readers on one machine. The fio jobfile is like:
>>
>> [global]
>> direct=0
>> ioengine=sync
>> invalidate=1
>> size=16g
>> rw=read
>> bs=4k
>>
>> [reader]
>> numjobs=4
>> directory=/mnt
>>
>> The first patch fixes a problem due to which the four bfq queues were getting
>> merged without a reason. The third patch fixes a problem where we were unfairly
>> raising bfq queue think time (leading to clearing of short_ttime and subsequent
>> reduction in throughput).
>>
>> Jens, since Paolo has acked all the patches, can you please merge them?
> 
> Jens, ping? Can you please pick up these fixes? Thanks!

Yep, I've queued them up, thanks.

-- 
Jens Axboe

