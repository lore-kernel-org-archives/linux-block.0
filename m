Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB3DC636D6
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 16:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjBVQtl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 11:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBVQtk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 11:49:40 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA3F59FD
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 08:49:39 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id z5so222294ilq.0
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOwjZBCbe3t+oyEUTMZOXE1/D6LnszTp4wPIPaznlMc=;
        b=MDXcoa26bkEdchyq5ZPNYD85vT8IJIH8vAcRkzb+315ebdmtcKoIGwPjiecF7E1MGG
         x1SjBDxhN4aRmEjfsd99e9dvuemcwLVfFJE2e9OXT7qq1bWxYeNo9yqxeX5TzoKUPDV5
         d/D+o4ui+Uy4FwUL2HtAmBi3afrZuTYO7kyL4UONeOd8GURbv0fgrPAKmLlCckWG03L6
         Y+fPpRYQPrrcux2Y2gcLsh9/E9cI6mBjMiFoBCu48udg7yGxgdZa/NYxZzxDFX7VoprB
         Ja1IQVxxF5qNQL1Oriw1/p8OLDl37IExigO0qpw5CR6JaQ/hP7fjbm+ITgA+lFSq0H7G
         sWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOwjZBCbe3t+oyEUTMZOXE1/D6LnszTp4wPIPaznlMc=;
        b=GOYcUs1ZU2ecOf/fbvBmOJ4NXUKuJhRYMXJf87oOL0GVgL8ASjeFYOh3tOd0j4u+4e
         7aS1mMA+Mlbm01s26hCYxGPInjYX4tl48xx8DNOTSdjvKV6TxKdXyiY/QGnezgV5KzR5
         euViT5sEMnjuKHwVphqF8whQYNBI8r1C5qCtb5c+lSGRWuGulAlhQ6oulT3V9dgo2zEu
         Dnjt4Kp9scfBzQ8AMrCaJ6fdd1wZ7wZJAIDsuRMh65l26SQZaAUTUXRcGV3jKsugMsy9
         BAD8h0ALkjlO1baWKaV0pv/+ZBJIeudAbtpBDi4ZwDRWGRJKSHSOe2VgMDCP3MM6nOcE
         qouw==
X-Gm-Message-State: AO0yUKW+Bui/l2HXPp7v/SffEaFNcoV87KoIe9lvkP7QWFsp9FpES+e8
        THDXhvDJEoCC/ZwclJ0iKS9vIA==
X-Google-Smtp-Source: AK7set9TwFlWfOCh1qiew+EYlv0amux5ysjUIjO/OdHopl2gOKM8GTTO7QxAVEgJl/8poOVHVchvYA==
X-Received: by 2002:a05:6e02:17ca:b0:315:5436:a632 with SMTP id z10-20020a056e0217ca00b003155436a632mr5646393ilu.2.1677084578874;
        Wed, 22 Feb 2023 08:49:38 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n6-20020a02a906000000b0039df8e7af39sm1105653jam.41.2023.02.22.08.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 08:49:38 -0800 (PST)
Message-ID: <f8aa172e-3c21-320e-36ef-7e48fc52ab29@kernel.dk>
Date:   Wed, 22 Feb 2023 09:49:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] block: shift with PAGE_SHIFT instead of dividing with
 PAGE_SIZE
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     hch@lst.de, gost.dev@samsung.com, linux-block@vger.kernel.org
References: <CGME20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5@eucas1p1.samsung.com>
 <20230222143443.69599-1-p.raghav@samsung.com>
 <4686cf1d-d618-d7b0-48f2-26ab94bf3985@acm.org>
 <299c512b-06d6-cd79-9193-936bcabd2d69@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <299c512b-06d6-cd79-9193-936bcabd2d69@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/23 9:25 AM, Pankaj Raghav wrote:
> 
> On 2023-02-22 20:57, Bart Van Assche wrote:
>> On 2/22/23 06:34, Pankaj Raghav wrote:
>>> No functional change. Division will be costly, especially in the hot
>>> path (page_is_mergeable() and bio_copy_user_iov())
>>
>> Although the change looks fine to me, is there any compiler for which this
>> patch makes a difference? I would expect that a compiler performs this
>> optimization even without this patch.
>>
> 
> I didn't notice any for x86_64. But I was thinking this also as a way to
> maintain consistency across block code where we do a shift with PAGE_SHIFT
> instead of dividing with PAGE_SIZE.

It won't make a difference on any architecture, it'd be a pretty
awful compiler that didn't turn a division by a constant power-of-2
into a shift.

-- 
Jens Axboe


