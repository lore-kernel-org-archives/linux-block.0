Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F5C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 22:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjC2WsH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2WsH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 18:48:07 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D319A10C3
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 15:48:05 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3230125dde5so603715ab.1
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680130085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3RsGkHtbe7hFCgfTwPiyz/Yz3UUNeLQpkcu2PeDaIc=;
        b=OcFymZYw8554gudOlcUcidK5mTOI73Lum6c707vuwJiiltkjqRUVeBzdoIFd7Cs/L+
         xdSElHbtOaZefWXv8U3nkWWmbnt3oJ1YxyUmca8cgw0AR6Tj4qG97SLCrxu5ZV8/KNJk
         mfuPr0hJ+jXzpZd4sfDLRD1ZOSd4NrnG32x5oAMKsnWnYseqVvdgB5Rqa9ULM2TT5g/B
         5c50lq0mifRPZERAr8o6FyqdGZRvQqoLvwx0VR1Sc1qzpiGvCnsbtA/tIE7aVTh2BK3r
         7hZVnn8u1LGD5wCOxCjLTpdnSW/bbHuRfWh2FHCOMeW11LK+9sQFifkPr68TvZJC1A/u
         3uPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680130085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3RsGkHtbe7hFCgfTwPiyz/Yz3UUNeLQpkcu2PeDaIc=;
        b=HEvQNqQfxGbHCsWU6ZUbPMprcl5RY7Oq1ppOyPSrjE/IieJfX1cXg4osOgHU8wwoPb
         OSJ0EEhqZuJlTlmvdXsryxVGFwfQo1HYhnf5Kskf3DzzVkUVIIYLVewHoHtdcdw02bdH
         0LTcvbyMVGNcEwgLVr7gcK/flI0a0cT7UHxv2lGrpoiW5O0mgieGI2rC0PpwSQIKG0US
         7HTr9LVPCF/km2t55e3I4o/3XUxj53IQ/uElr1Azvty1PM89ileuWdZJsP9CbNFNu++1
         4A4Kw47kVJITy7fqobavctqJmNpuMWvo1NnSRRPDIElQP8eBIzpGZiCDLx4qOjhJBaDT
         oCVQ==
X-Gm-Message-State: AAQBX9dGZO/GC/SVXvfHj5+VMQj5wBg8qg8UMeMFBMbj7vfoNgHVciKR
        WMBuFUqNifyURYBunszubgmTzKneRVheYx+FSKC3Dw==
X-Google-Smtp-Source: AKy350av2KaUAve2ibQJ37NNFZGFR7vVhttextyH6kwC3LF0IurgIhIw4E0jHLx0WHUtj/eIbEGr1g==
X-Received: by 2002:a05:6e02:48a:b0:325:e065:8bf8 with SMTP id b10-20020a056e02048a00b00325e0658bf8mr187599ils.0.1680130084835;
        Wed, 29 Mar 2023 15:48:04 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b89-20020a0295e2000000b003c5157c8b2csm11047798jai.47.2023.03.29.15.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 15:48:04 -0700 (PDT)
Message-ID: <8f759010-cd5e-3ace-9b6e-ea4f896ee789@kernel.dk>
Date:   Wed, 29 Mar 2023 16:48:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/4] null_blk: usr memcpy_[to|from]_page()
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        bvanassche@acm.org, kbusch@kernel.org, vincent.fu@samsung.com,
        shinichiro.kawasaki@wdc.com, error27@gmail.com
References: <20230329204652.52785-1-kch@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230329204652.52785-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/23 2:46 PM, Chaitanya Kulkarni wrote:
> Hi,
> 
> From :include/linux/highmem.h:
> "kmap_atomic - Atomically map a page for temporary usage - Deprecated!"
> 
> Use memcpy_from_page() since does the same job of mapping, copying, and
> unmaping except it uses non deprecated kmap_local_page() and
> kunmap_local(). Following are the differences between kmal_local_page()
> and kmap_atomic() :-

Looks fine to me, but I'd fold patches 1-3 rather than split them up.

-- 
Jens Axboe


