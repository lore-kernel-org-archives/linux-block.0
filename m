Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7462C433DB
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 18:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC85822D5B
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 18:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbhAESea (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 13:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbhAESe3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 13:34:29 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07250C061795
        for <linux-block@vger.kernel.org>; Tue,  5 Jan 2021 10:33:42 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y5so279127iow.5
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ohK/WOqK+ZvrSsmSNelyPVjobCoSndTH+kRVqdgfQck=;
        b=yFCzBAb7pcp52jJAYR4+TvKZCaWguAg151R8BOkItBOboa6Pf0MRWIgKlY+/3q/RwU
         NaNtTOJF12GlyfeIA8Tannb+uK9ysgMco/LBIu6Pa2ewNKmF8GDiWiyDvkDjwevtgxL0
         89J9KzDXPBmE6AlYfvFZCo4z2KBGTpX27GVlXrw5RAtqyN1m5CyAgzpVIRJbKF5Gukq/
         Q8XKu8zQfKg82GlbE398/jw4vzYt5R5BjtqzGh657vTt0beXCVCA1irAGTwLs9EDMjPx
         qo3J3/OHKFnJ+Webs96VpJJAW/XcVVWuITnQts46kGPxLL1ewl8oYp6GYef2SMA5C1Yn
         ZIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ohK/WOqK+ZvrSsmSNelyPVjobCoSndTH+kRVqdgfQck=;
        b=CjFk55ZkMINROyEvnb9r8d84BczBopjfdH+ZSVKJthQ5NsseFr/yS4NUjoI67F+B2W
         fPuV89WhpErlNcfBOwQlru4H8e/Ytc/cN+h1+QANZVHoAZJnaBdV0ARsT7RvQSb8gWuF
         /lJT9jxqgjgn8G2GlVJ8IoEahql/c8m/xygZPcvuk986Sddy5MI4Yl8ukbMI7sIK6mNJ
         MGvKDUapI348r+bc9ptjjpWVtwUKZiRVA+5/KlPPv3ct44nvRZCmW+faZnvxWERzcHyV
         CswPtBJg/4HHyAmlxi5uHTNeQ2EI4ZWA1OVjowpDW1Z0/lFcqNkCLY6qKjsnPHwMHvr+
         1yeQ==
X-Gm-Message-State: AOAM533/zGvNKchUbpceJTxmEsDPJjd+zez3UWtD2+3iZn6bJ3Vfx4kE
        /W3H/77vzl2UAUvb/Z30ytZGYw==
X-Google-Smtp-Source: ABdhPJynQj+KbiQlm8OW7/RioJnW+WO3zmXsSb7EeUZc0qpMBxJeSrW8/w/niA/KEHG5WU6Kh7tH6A==
X-Received: by 2002:a02:7650:: with SMTP id z77mr826755jab.134.1609871622178;
        Tue, 05 Jan 2021 10:33:42 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p13sm37856iod.54.2021.01.05.10.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:33:41 -0800 (PST)
Subject: Re: blk-iocost: fix NULL iocg deref from racing against
 initialization
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org, bsd@fb.com,
        kernel-team@fb.com
References: <X/Sj014x+U8ubiFT@mtj.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a7723952-93f2-d719-29df-c7e25691cf38@kernel.dk>
Date:   Tue, 5 Jan 2021 11:33:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X/Sj014x+U8ubiFT@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/5/21 10:37 AM, Tejun Heo wrote:
> When initializing iocost for a queue, its rqos should be registered before
> the blkcg policy is activated to allow policy data initiailization to lookup
> the associated ioc. This unfortunately means that the rqos methods can be
> called on bios before iocgs are attached to all existing blkgs.
> 
> While the race is theoretically possible on ioc_rqos_throttle(), it mostly
> happened in ioc_rqos_merge() due to the difference in how they lookup ioc.
> The former determines it from the passed in @rqos and then bails before
> dereferencing iocg if the looked up ioc is disabled, which most likely is
> the case if initialization is still in progress. The latter looked up ioc by
> dereferencing the possibly NULL iocg making it a lot more prone to actually
> triggering the bug.
> 
> * Make ioc_rqos_merge() use the same method as ioc_rqos_throttle() to look
>   up ioc for consistency.
> 
> * Make ioc_rqos_throttle() and ioc_rqos_merge() test for NULL iocg before
>   dereferencing it.

Applied, thanks.

-- 
Jens Axboe

