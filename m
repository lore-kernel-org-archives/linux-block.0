Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72140C4332F
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5E8610C9
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbhJMRsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbhJMRsq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B24C06176D
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:46:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 5so623374iov.9
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i8WpYOxIOt0h1wKF25eaG/3zEkk9UVEslm5o1F+h5cE=;
        b=aO+NNvZL3VRdrHkzWNM2txWMJ39DK2YhTbd/u8G4y1GFarjCTHKXwQCF264Vy00oxv
         iL+FIHin82x92zVi68zo3hnTK5aSvbi0Om5ZDOFpvqETVgKBhwlNxQPnW2MDkdZH3D56
         h8BpcmYeZqr44fZtr00PIAikaU8vfW2PZZFpeKE1O4S83wKoDB9f923MQ6Pu101PCDzI
         kv43M65Nt9/etgcgDm8FMtQOaDWUcBqL+vdCdITj1/ndDNrY1EyUNJA8pzaiB/NLJ9Xp
         6/Ud9502EmD5oxvZVFgJJ3BiEbRDhrNwGwT+8DedCWeBrVDJE9qC+Og8fRVC6PCDUB9z
         S+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i8WpYOxIOt0h1wKF25eaG/3zEkk9UVEslm5o1F+h5cE=;
        b=nesYcbckc6JLSGR7LUF+DKEgJWazeM46xpe30a/ewv+1v7peq8ZCPW7iz4FPDIgSoo
         vnWIcdxkgpKLjfYxuo/Ye3r8qiFFjrnxIilEot+r9Krao76O/t7Y+4MwnvKPf8EvXYEI
         +tZhlt3/8qOaOysHkwb6NFQxJIJ955kdbzO7a1qO9qgSyn6mww9rSI0rEnlaaEQaNNj5
         lqECn0fwA/O+tpYftk5ygWgARLUXCyuhm8f14EdBamqTYfCzQ2ptdtpYOqOnFbk+UA+a
         jLE89yRM0QGGAo/4V05zuwBF9twMO8tdYNva12t4NNkqJVSo9eIg/rrRkuIx6LzoSvxC
         XYhw==
X-Gm-Message-State: AOAM533USo0CZUdx0aekJI4/bXXImERFgyhsg/akVZDfwAD+Nq9B4nB8
        Zk4b6TcpciBCc02yWzteGOefwT3n7njtwQ==
X-Google-Smtp-Source: ABdhPJxssYPsZoXRqEXv6sBwZX4cbD2RcVsS/ufJYE+v1Ybkg00xRvAHVx8RkmOk04Dj1Zjlkhrpsw==
X-Received: by 2002:a05:6638:148b:: with SMTP id j11mr568997jak.79.1634147200985;
        Wed, 13 Oct 2021 10:46:40 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d1sm81977ils.25.2021.10.13.10.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 10:46:40 -0700 (PDT)
Subject: Re: [PATCH 4/4] block: move update request helpers into blk-mq.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-5-axboe@kernel.dk> <YWcYFywO7J0R4oMb@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f55d823f-79ca-67f0-1868-c013d7711fe5@kernel.dk>
Date:   Wed, 13 Oct 2021 11:46:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWcYFywO7J0R4oMb@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:32 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 10:49:37AM -0600, Jens Axboe wrote:
>> For some reason we still have them in blk-core, with the rest of the
>> request completion being in blk-mq. That causes and out-of-line call
>> for each completion.
>>
>> Move them into blk-mq.c instead.
> 
> The status/errno helpers really are core code.  And if we change
> the block_rq_complete tracepoint to just take the status and do the
> conversion inside the trace event to avoid the fast path out of line
> call.

It's all core code at this point imho, there's on request based without
mq.

-- 
Jens Axboe

