Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16B0C48BE5
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 21:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5DC61040
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 21:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFOVn4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhFOVnz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 17:43:55 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9500C061574
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 14:41:50 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id n17-20020a4ae1d10000b029024a49ea822bso152410oot.5
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=520moXzIk4YESMW1//dMoR4RUm/M9aunMakQVpWHwpQ=;
        b=STjpJgYbK6Vx0ffKYCrnxAtgUid4PJrTd6Qf+U8XyGnNetf+gv5/p2MxC5nSptjqNW
         42q5yMA9Ouhx30hyJszlSz3uPp14irdpsQMKIw0hDyCa5++BL+/+CibdCQCppsslqBEt
         f5IFFyBRUjtHMg+L2sdC12mkhH/PiXS7yYss43vld3IjL8WB62fn3v698OZ4RQl+CjQq
         Xl7v2ExK6HSO7cVWB2OkUkhRPh5VdPsXYngTyF5adqeIbqk43VIARtIVWmS2oS2b+Hp+
         yhXSzR8JfFhrjqAfo/6AmWE0OYzD2wVpmevCcEHl7BJ0IYvSA0Gnrl339e4FgSRF2JjQ
         6MPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=520moXzIk4YESMW1//dMoR4RUm/M9aunMakQVpWHwpQ=;
        b=Hu7f0OY3MXO0ryDLHl/L1Xl9ZfxWyUh93a19hsGTvyNL1/3DolPAq2jCG9a4N8d74L
         c3I71LA1aJqe+qhPfwzPb8wFTHy0RBAOWKMcfYM+g8KeoDcJ10Iuah3EMW9OMrSbpIln
         BL3yP5ohINcvvx9wyLHRbZRc89UZ0gFEdG1QMqsiL97AwDju5X2Uq/AGiRYg3fwr5okA
         uRACIP3cGDFT1iguqxFz+GpoNBlChHiEt8Ie2EX7Ou5TIuQqW14kw+Ho+kbxIE8huvve
         9tho6iJfw+g3/0JBOowwdLfuwmJeqXXT3we8z0d6fRc2ZNYw/1dSMzHhrkg9UMSbITYS
         sD1A==
X-Gm-Message-State: AOAM531hta/OpJ3xE+SlwMbAwURGxastB6FJTleZMrmcmoedFdo8uiko
        /QhpH8slDxRQTRl9vHk91vA6NQ==
X-Google-Smtp-Source: ABdhPJza7IOYH8gu8YO5B9F4vbim9sALt/2zXs/4ZpJN3za/HGMYltgCy33Y00LBqZwxsHJ7/bPOpw==
X-Received: by 2002:a4a:6049:: with SMTP id t9mr1064404oof.14.1623793310350;
        Tue, 15 Jun 2021 14:41:50 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id s81sm29061oie.23.2021.06.15.14.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 14:41:49 -0700 (PDT)
Subject: Re: [GIT PULL] Floppy changes for 5.14
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <2f80871f-a1a5-7c02-52f9-118a0e68d84c@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a8f153a1-daa5-63d1-43ad-c82f358e11a7@kernel.dk>
Date:   Tue, 15 Jun 2021 15:41:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2f80871f-a1a5-7c02-52f9-118a0e68d84c@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/21 12:56 AM, Denis Efremov wrote:
> Hi Jens,
> 
> The following changes since commit d07f3b081ee632268786601f55e1334d1f68b997:
> 
>   mark pstore-blk as broken (2021-06-14 08:26:03 -0600)
> 
> are available in the Git repository at:
> 
>   https://github.com/evdenis/linux-floppy.git tags/floppy-for-5.14

Pulled, thanks.

-- 
Jens Axboe

