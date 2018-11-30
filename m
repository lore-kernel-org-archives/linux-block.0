Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA7C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86EC206B7
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wuCE3JJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86EC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeLAEaP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:30:15 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50290 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeLAEaP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:30:15 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so10237817iti.0
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 09:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QO2CiVXn54qdK6JpT9Xi21d4JFxOhnoogfe0Bp8gs1s=;
        b=wuCE3JJcSCXBj8xfLmRmMOdzesKWPYHpoHmzDRdyIeLS0HQCQBGMdbOTYs/RaNoE5o
         02TKfGv1qbT7Ggb06wlkY6GVCJoKFyJ7sG1P3fJmO2vawTL1u/18X0FYUqEu9vgv/T4C
         DQc/GnJaLmmN8HIn7PbpUGtQH23V4R9g+5ZTVcavxC+K7wgYylQesU2HT/RTJkB1FaGG
         LUoWKMxkgaBPZLpmAnoLMKYyzVq9lrwk31IzjcyHhUkGuU8NifiWeHP7w6a8eejnZC17
         MfYRL2FDozSSKq5Y49Q1BG90ODHKo6gSUXkmsuEamMEhZExzeWQaSEtbC6sRy5UPDF+J
         iCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QO2CiVXn54qdK6JpT9Xi21d4JFxOhnoogfe0Bp8gs1s=;
        b=FizjvLzaXHdI4asnfFV0swEV7sZjJ2aY4q1SCsvVXOJNfOuLo5Hkr9ONgpqrrDZhrV
         YuW8l5x3VBf66zakmwe3PyEJdwyVxDqCheBQeaQkleCdBZcdNIDbfUPrSSQfIBjvTVRi
         Vb6/Cwy39NG+k6O2b3aYfFaT9LqXTa+W2hAs8jxuBUzqfFdxaBfU2b6m6e+ZnmEfWrx6
         DxB4IXAooY5loF5hkpTRjUBrZ/7P6QVXU3P0vlKsrs6Yv0qDZWS6/xm08V7f90sgHoLZ
         dpdzvi3Ajc9/KZ8c6hn79Jzb+6Fm6pzAPQ6PP2tUTzv7+DiokoXb0R6c2jsqx1YgN/db
         V5BA==
X-Gm-Message-State: AA+aEWZTQ9oQRHpH6mJLRsEMkbVG2Pu9cUU8CTpBWOdDPhOLDImGROT8
        WRfdCLoc1KajrxazDv4Gy8MSig==
X-Google-Smtp-Source: AFSGD/Xh+MQqtMn+xjCexaKJEeju01hhwqeTomJu+MjxO6sCWUYq8+6at4SOap5sLxUky13s1BzCLQ==
X-Received: by 2002:a24:c456:: with SMTP id v83mr5547007itf.44.1543598416107;
        Fri, 30 Nov 2018 09:20:16 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r139sm2390555ior.53.2018.11.30.09.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:20:15 -0800 (PST)
Subject: Re: [PATCH] block: fix single range discard merge
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20181130163818.6540-1-ming.lei@redhat.com>
 <1543598309.4347.5.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9ebec24a-103c-2ea8-49e1-2f927eb8a4f8@kernel.dk>
Date:   Fri, 30 Nov 2018 10:20:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543598309.4347.5.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 10:18 AM, Bart Van Assche wrote:
> On Sat, 2018-12-01 at 00:38 +0800, Ming Lei wrote:
>> Fixes: 445251d0f4d329a ("blk-mq: fix discard merge with scheduler attached")
> 
> Since this patch fixes a bug introduced in kernel v4.16, does it need
> a "Cc: stable" tag?

Like the other one, isn't stable implied with Fixes in there? You'd want
a stable backport for any kernel that has that patchset. I think that's
a stronger hint than stable cc.

-- 
Jens Axboe

