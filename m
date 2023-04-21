Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F898C7618E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 22:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjDUWZC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 18:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjDUWZC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 18:25:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B3B1BE5
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 15:25:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a7111e0696so5461745ad.1
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682115900; x=1684707900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtOk22wHsRTIJLakW5pQsLDvU50er+NeXN7SxTWy9qk=;
        b=oerIEMuVGMo3tf7ainFnGShOU4ymhQn2JIZkQ5ZB4LQezPNmDezHZ74CsaeAZJQpD6
         fBOri4QsdRMaGb2stkX1WSwEZwfrNh9aQZWqyNJoXurA5LawSG0y1G2Xv1oUcyhDfcMp
         9sbYCkZuE9eli+qnK9IsSiSsdVJHCJSw/W3sMGWPje4NFX463I+v+t7Es1rrOVfCvCrD
         U9gO5mnakr3a3I+Qu1a4NVVPqGjSfvWoKTJthz4c4dgYea4zYEHowFeYEbZOiF95SR+K
         Jq4c5WzqI8i0UVXC3OJDP1Rl9oKvaB8DuqRz1pK4f1u8wkRZdFtR2Oi36akQy0CVWjt4
         77tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682115900; x=1684707900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtOk22wHsRTIJLakW5pQsLDvU50er+NeXN7SxTWy9qk=;
        b=kO7a0D2ugsStlAe5PAraX6gD4vd2cu23CaR1kvgLUaNBZqy9mw3IKJsKAsk47yyNAL
         EWBMeSTkazG0BCl3Gn5lkSqjfDaHxTJQbGsMx3ATuuUD5zrxC0MKMmHBTWJ42iS/Pz2z
         QTKurIa6wrrQ1Gwb30T5hqgldjo0eIO7jZKcjOQS7AxKVgiN/IGNTX5AP6LRScm3x/wE
         2/6k137Gwwy3FPxofZ2hpVR8CxR16BxbJR+7YBooTuFD1UCsnmnDO7459NXBvFTCK+yN
         H4TzAqCZn3ti6A2tTgSpLW+SzxeeUzoxDUTI5b2oKIcHxvT5F1KoM0HvtrQk/BVBoZpK
         TCMw==
X-Gm-Message-State: AAQBX9ceThE9L5cm0YUUVjyjVw749te2PdKbyJtdIhELLCwT1skiJ+mB
        HaRmoCpXmH79wQSv1BrVVW9EQA==
X-Google-Smtp-Source: AKy350ab5zsgqMFX9gmLPlFbJI6JNwFXd5UcuHSryHmhAdUudcIDmmGg6bERrDL3LQkvBwimuDuVEg==
X-Received: by 2002:a17:902:c94f:b0:1a2:1a52:14b3 with SMTP id i15-20020a170902c94f00b001a21a5214b3mr7699856pla.4.1682115900155;
        Fri, 21 Apr 2023 15:25:00 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jn15-20020a170903050f00b001a945e7147asm1657335plb.231.2023.04.21.15.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 15:24:59 -0700 (PDT)
Message-ID: <47688c1d-9cf1-3e08-1f1d-a051b25d010e@kernel.dk>
Date:   Fri, 21 Apr 2023 16:24:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/5] iomap: simplify iomap_init() with PAGE_SECTORS
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     agk@redhat.com, snitzer@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        hch@infradead.org, djwong@kernel.org, minchan@kernel.org,
        senozhatsky@chromium.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
        da.gomez@samsung.com, kbusch@kernel.org
References: <20230421195807.2804512-1-mcgrof@kernel.org>
 <20230421195807.2804512-4-mcgrof@kernel.org>
 <ZELuiBNNHTk4EdxH@casper.infradead.org>
 <ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/23 4:02 PM, Luis Chamberlain wrote:
> On Fri, Apr 21, 2023 at 09:14:00PM +0100, Matthew Wilcox wrote:
>> On Fri, Apr 21, 2023 at 12:58:05PM -0700, Luis Chamberlain wrote:
>>> Just use the PAGE_SECTORS generic define. This produces no functional
>>> changes. While at it use left shift to simplify this even further.
>>
>> How is FOO << 2 simpler than FOO * 4?
>>
>>> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>>> +	return bioset_init(&iomap_ioend_bioset, PAGE_SECTORS << 2,
> 
> We could just do:
> 
> 
> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> +	return bioset_init(&iomap_ioend_bioset, 4 * PAGE_SECTORS,
> 
> The shift just seemed optimal if we're just going to change it.

It's going to generate the same code, but the multiplication is arguably
easier to read (or harder to misread).

-- 
Jens Axboe


