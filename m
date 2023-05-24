Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CB7C7EE2C
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 15:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjEXPCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 11:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjEXPCN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 11:02:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3117CB0
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 08:02:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7747f082d98so7923739f.1
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684940531; x=1687532531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwf57azNybT9v+Lg2CMN2sb9fLVIIGUOGeYghvdjLPg=;
        b=j8dtYIjP94479te1+EaV/gWEzZPD0jKPaxH4IJEOWq8N99C7cbFAtuJuLoz2zM9Xqi
         QK/ykjGbpTIocJ5YYHyCbUKtC5O+RF0GYzEFyQHX4ozqaIoPwqpu1xgMpeyoRS4x9/4D
         3bJqKNey7+kopR/WfC3vwVsgiXZOyjzNtuYnRZS2tlN2pIskqNSsy511kaGSLQicY9U2
         PIh7J0ws9nxdSC+5OAs9uTKu/bU7guocHNCRSVGQQ47I/ae/dW8njJGHGjH+Bl0XLs0v
         KneThcxWvH6kmsmfhPxpkIyG+ZDeOEFPch3BpZ9GH2vgp9cVQupwP2mpPmKlWkn8pCeB
         b/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684940531; x=1687532531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwf57azNybT9v+Lg2CMN2sb9fLVIIGUOGeYghvdjLPg=;
        b=H0PE2j/zztRfkjZsmwfbwkCy8EyXexAwTwgfdNDUpRhMjspopTeVmdBX2w3dzBiar/
         TDDJZTZntjB4yv4y8IskILUwo1JUJWCk4QE0QUeeUrIOzcHqEembcI+ozRQUIn1Or8je
         nOAMBmFPqY683Yx0FPyywz64uM/1PW/CdGEspyYd3a7BsIZMw1ONDiRIx97FOJQEDuYP
         rM2rnyLpuS9sGTzYRjUCKdyI0LY80syYJdHzF4kPzciuu04Qv1d3czaHKW20ZdSRMSjw
         klci/xW/XBxhOdoInRP/kvr4T00BHgvguqnt6cBu7Yuqi8Pfu0ewccOV3B/t8CeEej3+
         peRQ==
X-Gm-Message-State: AC+VfDywF/rRH14zKETWtAfzqR5Yb7Gpclz5UyVNmlc6hHyZxcL7q7/A
        u84UOQicgNLajQqx4EWbpCBI92kk1OgHyaQQwbE=
X-Google-Smtp-Source: ACHHUZ50tzfDRcH1j6S2Z6TgSbqpVFNpX8Jv88XOuQFTADKkXBGAMy329r3aqgfQXEN+hNSP1qppLQ==
X-Received: by 2002:a05:6602:3420:b0:774:8571:a6dd with SMTP id n32-20020a056602342000b007748571a6ddmr3685006ioz.2.1684940531189;
        Wed, 24 May 2023 08:02:11 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f13-20020a056638112d00b0040fb2ba7357sm3209457jar.4.2023.05.24.08.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:02:10 -0700 (PDT)
Message-ID: <3235f123-0638-b39f-f902-426059b87f81@kernel.dk>
Date:   Wed, 24 May 2023 09:02:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 00/20] bio: check return values of bio_add_page
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        damien.lemoal@wdc.com, dm-devel@redhat.com, hare@suse.de,
        hch@lst.de, jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-raid@vger.kernel.org,
        ming.lei@redhat.com, rpeterso@redhat.com, shaggy@kernel.org,
        snitzer@kernel.org, song@kernel.org, willy@infradead.org
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/2/23 4:19?AM, Johannes Thumshirn wrote:
> We have two functions for adding a page to a bio, __bio_add_page() which is
> used to add a single page to a freshly created bio and bio_add_page() which is
> used to add a page to an existing bio.
> 
> While __bio_add_page() is expected to succeed, bio_add_page() can fail.
> 
> This series converts the callers of bio_add_page() which can easily use
> __bio_add_page() to using it and checks the return of bio_add_page() for
> callers that don't work on a freshly created bio.
> 
> Lastly it marks bio_add_page() as __must_check so we don't have to go again
> and audit all callers.

Looks fine to me, though it would be nice if the fs and dm people could
give this a quick look. Should not take long, any empty bio addition
should, by definition, be able to use a non-checked page addition for
the first page.

-- 
Jens Axboe

