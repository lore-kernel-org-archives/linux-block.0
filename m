Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FB5C7EE23
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 14:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbjEZOgm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243787AbjEZOgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 10:36:40 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2061BE68
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 07:36:20 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7747f082d98so5368739f.1
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685111725; x=1687703725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFFVe4fGYi3lSzHHYAx7oZd/Y8MYWtHHZ3YLr2pVYiw=;
        b=i8uvdX5BpdRP8Dn0HfqxN7STLSNfUe7bxQXVwRVDQmx6rvcasY/E4RCghiZy33Kmvq
         n0WFuUxHseYhRXVywFcGHG/1mC5DXwYalAzUtXWSjwuqzVWBMZTZxnvDSh3LImySwqJ6
         sHjZ974U7yzsxaNECeu3Qy3dzPim4npkI9zV+dMSRUmytUeD7OoITSvNEelmLILGi1rf
         5KwSrJHGVBPmiIKfoWrB5F2fkoRFLbZ4aj8V3yN2T9cSRW/je6eOhBsB8UoozaYshF/7
         fB5zgpzDne+o4nk7I5ReQZg8rIpQqbnvSFgKfDOA3bC+0VroF6zt04WVXAHBxp4JcAej
         ce0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685111725; x=1687703725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFFVe4fGYi3lSzHHYAx7oZd/Y8MYWtHHZ3YLr2pVYiw=;
        b=dKmxqNavV/UjRcW3GzfgusT8KFemGFQRkf9Esmad+5Q/AujNRhapDdkY0Zr5oCk8tg
         5iWC3BHngan/e+95Jaf9m+jAHBuTXrlYEIKWm1907m3u7ctyOWY05vI3/1DVkBWD61xj
         wrZuYzAmmCP0VDfiPHfgkp1BjYaV3b8xwykD/Tz6lJT4S1X6oX8YW1Xmvvz+Li/hNrf6
         zA9Oi3IG6lTHt2cNXly28oC0kgsLFlXY9FfgdvSQf0rICKqFxXYg1S9X3LlZPtEUv9Px
         TT8lzyhPoofXM5nd7UYFMdTYpDP3nSZERXPNuPFIeW/lSg+o/Yd+Tq9oSxW3f1H88rfu
         jErA==
X-Gm-Message-State: AC+VfDxpSG7RsAy+Y0XqSntnvn+RhNSwYAyNjnc9p93OwSUc4cPGSUPI
        IGxJi3gp3ZeiTKiNVA8hC/xrQWk5+FegwRFsiyc=
X-Google-Smtp-Source: ACHHUZ47qy3YTiOTh7HZPsI0BEt4acqoW4nesrAMlklT8drGr0J0cxVJzlB63FvXOgbacG8hNmN+kQ==
X-Received: by 2002:a6b:3b8d:0:b0:774:9337:2d4c with SMTP id i135-20020a6b3b8d000000b0077493372d4cmr923464ioa.1.1685111725035;
        Fri, 26 May 2023 07:35:25 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v6-20020a02cba6000000b004183d110f0dsm1188836jap.86.2023.05.26.07.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 07:35:24 -0700 (PDT)
Message-ID: <ee03b7ce-8257-17f9-f83e-bea2c64aff16@kernel.dk>
Date:   Fri, 26 May 2023 08:35:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/7] block layer patches for bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230525214822.2725616-1-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/23 3:48 PM, Kent Overstreet wrote:
> Jens, here's the full series of block layer patches needed for bcachefs:
> 
> Some of these (added exports, zero_fill_bio_iter?) can probably go with
> the bcachefs pull and I'm just including here for completeness. The main
> ones are the bio_iter patches, and the __invalidate_super() patch.
> 
> The bio_iter series has a new documentation patch.
> 
> I would still like the __invalidate_super() patch to get some review
> (from VFS people? unclear who owns this).

I wanted to check the code generation for patches 4 and 5, but the
series doesn't seem to apply to current -git nor my for-6.5/block.
There's no base commit in this cover letter either, so what is this
against?

Please send one that applies to for-6.5/block so it's a bit easier
to take a closer look at this.

-- 
Jens Axboe


