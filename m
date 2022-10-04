Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95542C433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 22:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiJDWLa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 18:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJDWLV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 18:11:21 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D116D573
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 15:10:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b5so13784415pgb.6
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=9c4M4NaKYwplMQyV+GkcSll4buW+t3Sjd/Yj4MDRHKw=;
        b=tQsA8k2mYw22xI7s9M70ai/xj/eaL4qPzJ2kiDmzw+z1Ju72fmABqKfwSsOxfAbucD
         tWfGaY0DW5BrnU74eRKCRRl+yecWlCMLDIblUa0YC/zIiYViOgApabgUs/f2E45QN4xB
         4cJ06b0rcoUP2TOZ6+r5IZGKcLFY4StU9yXN1XNvD0eB3htUOmJmtpNQ+OTyF7yUFYII
         zm5zkAv4SSIFpeQVkSmDazhU0Fp0N2AHRo/RdHhw1/VhqS0RBmV+/FH9CqASxk47ffh+
         ymDjOcJd+Hl9RicJkCVkSbxAmMdd3MNDDbJmQVMmyhYrKpSqSaAiL9R2kN40QV337xpX
         R1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9c4M4NaKYwplMQyV+GkcSll4buW+t3Sjd/Yj4MDRHKw=;
        b=nWFLaeha6SvDzMvuxgd0qumWy7yVrQnRhIGgsQxem/zYjiYC8wCT6lsY5XSBfkORmj
         iJsKaGtlVG5palXw7yRNnZOu5H0zf2z3eyMqiP+8T+jiA8pvINoGIJ/3BEtmAB18sYt1
         5TSTWYmN79F5Z8P+XbrsnjzX5ZziT0gYpO1FG4uXGmEuI3EjbLJw2Sqhajn75P2wgU6B
         kluJBebWgiDPi/eElDugCmG0+IUXlIZZrF/cMcZ+zomooDciz6DZNiFE7F44s9354btE
         o1QLt7NeonPmwLtUWyu9hwKmkYZ6jokcNw3zoScTBR3bUFbyOHZwThVkSFQYYjVJNkvW
         Zerg==
X-Gm-Message-State: ACrzQf26OQwXnvNSuYvXxOpNVjZIEUk9XZ9DiwESG3TOQV3UKIkiQ6Lo
        v+Tgc2y0Jl5tRJ28Gx8tCRuFqwNfPAepng==
X-Google-Smtp-Source: AMsMyM7Mmvf+MrajTLKjZd44LA1r6QmvaJbevAc7dpsqiube9kj0tGNFPBv3uIaDW2ws9h0BFKryRw==
X-Received: by 2002:a65:6e47:0:b0:438:c2f0:c0eb with SMTP id be7-20020a656e47000000b00438c2f0c0ebmr24742972pgb.236.1664921441082;
        Tue, 04 Oct 2022 15:10:41 -0700 (PDT)
Received: from ?IPV6:2600:380:4b7a:dece:391e:b400:2f06:c12f? ([2600:380:4b7a:dece:391e:b400:2f06:c12f])
        by smtp.gmail.com with ESMTPSA id z13-20020a63330d000000b00434651f9a96sm8758274pgz.15.2022.10.04.15.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 15:10:40 -0700 (PDT)
Message-ID: <d7d4befa-bfff-e01f-817c-03158528e46e@kernel.dk>
Date:   Tue, 4 Oct 2022 16:10:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [GIT PULL] Passthrough updates for 6.1-rc1
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
References: <dcefcabc-db87-f285-ddce-ad8db26feb2e@kernel.dk>
Content-Language: en-US
In-Reply-To: <dcefcabc-db87-f285-ddce-ad8db26feb2e@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/3/22 1:40 PM, Jens Axboe wrote:
> Hi Linus,
> 
> On top of the block and io_uring branches, here are a set of updates for
> the passthrough support that was merged in the 6.0 kernel. With these
> changes, passthrough NVMe support over io_uring now performs at the same
> level as block device O_DIRECT, and in many cases 6-8% better. This pull
> request contains:
> 
> - Add support for fixed buffers for passthrough (Anuj, Kanchan)
> 
> - Enable batched allocations and freeing on passthrough, similarly to
>   what we support on the normal storage path (me)
> 
> Please pull!

Geert noticed that there was an issue if io_uring wasn't configured,
there's been a patch added for that. I'll send a v2 of this pull request.

-- 
Jens Axboe


