Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF906C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E2320C01
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Rb+5Dvng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbfB1VDZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:03:25 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34080 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfB1VDZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 16:03:25 -0500
Received: by mail-it1-f195.google.com with SMTP id d125so8693956ith.1
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 13:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nv3u0G/V3fQnw0uOpLM1knoRv2ExvBRHpS5Vngv0uhI=;
        b=Rb+5Dvngpl3lnByRKyvcQQo4lDFOSdougL9iFYjKQFlnbhAoX1dxToOrZNy/UA/HOm
         fYAllvWj8g7D0pvBMl/vXcjOasNTdOgGyZd+nWadMpVOYgehNlcmZjHkNEj5OBNvTwhb
         KxQ5zyfz75P+9bhDcyLaprX0VKay00LLlYU0HZmDIrdbW9W9S4OzI+ksWGPi5gQ/n7S4
         4hBNLL0DJhnJjBtkH8uE651Bo0JlhcK7XQWbogdZQDREgrT8IQgOrSM3dQ9KyJDmGUN1
         5p/j/cA9wv26BIUS2WDdH9iPTjjJfltUPsCHTcNeow3ttK2J1h1dPC9rGo3GCfbfhzWT
         nasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nv3u0G/V3fQnw0uOpLM1knoRv2ExvBRHpS5Vngv0uhI=;
        b=I5ZWfiS39RtSwFMtfPOJK8EzIXteYL7lLEipTQYX1a3pSVnkk5NW/lAnA4Um9sejrF
         jzn+OHpTKhz2umn2paSO17L77KXdoHN+ocV2HLQgLIO24Vw9BOemzcpWwksDwL7AL8w2
         wK6mYWhRIECwbLIAluyvJIrjRF7BYlENVeSu6h2hIWA+9AokcndkDkl1p9d2oWgS4yKT
         82LUCdDpdL2N9beXe1eUq97rPLI/qYC+7113RdLVxB7vnkQnRTdTXOurWLM6T2WDEqse
         DX7FGmWxlNoVFm/ATc8rEfuMbF7mT5QuEnmMfB87gw1kYh1HYOlBYE9bEEfxUlmlMy8O
         pp2w==
X-Gm-Message-State: APjAAAVpcHNAumTAKUZU3vj+GxvuHtLX4j3DUhRysBHZdeVLwzHchKLN
        AQOr75UMtCDNMPEkwaPHEUpYwPEV7uPs/g==
X-Google-Smtp-Source: APXvYqwxAb+3495RQBw9bnB4X8f2zqgDSs7FAf7da+dIuge5VO/XG8LGGTOHwxD+CpfNH2z6eiTGBg==
X-Received: by 2002:a02:7124:: with SMTP id n36mr706400jac.122.1551387804251;
        Thu, 28 Feb 2019 13:03:24 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u82sm3286213itb.18.2019.02.28.13.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:03:23 -0800 (PST)
Subject: Re: [PATCH] null_blk: fix checking for REQ_FUA
To:     Heinz Mauelshagen <heinzm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <154589c8c1b22879dfc03aec4555793329d5ce83.1550861849.git.heinzm@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de98873b-a47d-c200-c260-b62ef704f26a@kernel.dk>
Date:   Thu, 28 Feb 2019 14:03:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <154589c8c1b22879dfc03aec4555793329d5ce83.1550861849.git.heinzm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/19 12:00 PM, Heinz Mauelshagen wrote:
> null_handle_bio() erroneously uses the bio_op macro
> which masks respective request flag bits including REQ_FUA
> out thus failing the check.
> 
> Fix by checking bio->bi_opf directly.

Thanks, applied.

-- 
Jens Axboe

