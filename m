Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEB5C4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 22:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A0E60F9B
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 22:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhG0Wsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhG0Wsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 18:48:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD972C061757
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 15:48:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mt6so2243959pjb.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n2fP7ZlefYUM2C3abnK0BcCDLkGq4hlbOwatDotuXww=;
        b=l1nkOMbHuJi0poyd6sCL+h9w9koG+6uqlV2e5xQn83cqRVZtGno2xpNoScL6OPvGkI
         zvjIhPCRpBvmLPwoc2y8Em9EvCEW/ju61qmiptvsIjVWLoI36jry3exLbTZXktq4V/lI
         LzurBWEvQicW0YYGYvvMsPP/BjX9tc9X8sgH/qX2Vo9CXGe0wjrCbTn8jM969gWACQsD
         grrnT+KmSWhR4ItcS4uOUdy9sFPDa55UsAv9kfqfopyc2n2lY7Cs9gI/SLrTf7lmLx1a
         3RZJXp21w5qUi4PsBRT6DgMr0izt/Q2EhcbONZFeutTu3i+J/6DVrqPeZwnSdGqwIyZy
         wUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n2fP7ZlefYUM2C3abnK0BcCDLkGq4hlbOwatDotuXww=;
        b=dF0rPVBlpI93upy+NjMHkGx7G/KJZmC3YzrTssjsfLvSRuKXjvfG1DjQy+OReL+tEv
         SN+ncz+csWZx0DIjrke8OV0h+WpJMGaAyYabQ3IZW7kva4YQxeO/vP96YANTyfwSLdaB
         4RW/AqIrLnQcdPhmbv543t899Njpv2GN8Kk11I8xHL1ip9h9oFhHRVyIXtZKYGnIzCpp
         i0cDkRkSHnI++ucmLdZkMhkcvEq9STdbP3cROX2wrKlaPcxr10J81xEUD1Pv7pzazahL
         WcZZMEj42JRCPXIWovb3EADHHfdkw+xk0m3GZ4VojHbwXc083i9NW2TK7gdpwsV6bzeH
         Pn9A==
X-Gm-Message-State: AOAM531gWz+wq/jPxcADkxKdsedg5K5+uHvuzW9fF9iXlUOlXmcdYGx/
        wu4KWpdfLCf3eoEEzxZAkxxd8w==
X-Google-Smtp-Source: ABdhPJwYhFjaGVoop6ky3m9FD3ql45vrDfWq/2iNFLNmSXFpPO6cyyjyQ5LEVtTktXO+gJ003lECIg==
X-Received: by 2002:a63:b953:: with SMTP id v19mr25604621pgo.40.1627426111351;
        Tue, 27 Jul 2021 15:48:31 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id y8sm4992846pfe.162.2021.07.27.15.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 15:48:30 -0700 (PDT)
Subject: Re: [PATCH for-next 0/2] Misc RNBD update
To:     Jack Wang <jinpu.wang@ionos.com>, linux-block@vger.kernel.org
Cc:     hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com
References: <20210726115950.470543-1-jinpu.wang@ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cee470f9-599f-252b-d766-46939c7b2037@kernel.dk>
Date:   Tue, 27 Jul 2021 16:48:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210726115950.470543-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/21 5:59 AM, Jack Wang wrote:
> Hi Jens,
> 
> Please consider to include following change for next merge window.
> - one fix for wrong api usage.> - one sysfs_emit conversion for sysfs access.

Applied, thanks.

-- 
Jens Axboe

