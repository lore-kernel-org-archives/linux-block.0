Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC04C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD5D20724
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 14:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bwk778MV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404067AbgFXOtd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404066AbgFXOtc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 10:49:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5F3C061573
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 07:49:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j12so1251814pfn.10
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vv5CeoEMEd/XaZyV+X7P1kNkofsoeplzWSRdxxDS00M=;
        b=bwk778MV4JRcgoFbMQOrQgekxwUsT84rphonaJEjHj+tfSFgbhTzCHVdvKkfqgXvDh
         UE4F79xHy4RFL0ns2M2Zv2P02GwzOsoQRQQqM693N5JymzSK/a+bbLJoSB8s/MjjXHJ/
         +3N6+4UOOYVhgS5xUk0Mdg4z8qe9FFjD3MvS+/1D/wuZODZJAj6AagfkW8oEPHhKD8U6
         jrrL7Ly+zgjkUKzmEG3eo/+rfETbRC1fI8Md37S5x9WLYpokhEZhf3WE7/ZmtPE6bXNi
         kIsj6eQ01WibKj8/ClGpO2i88KR1NO1/TmU3GZXHWCPCoThV05mxrKALh5v1+OSF7Zi0
         aB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vv5CeoEMEd/XaZyV+X7P1kNkofsoeplzWSRdxxDS00M=;
        b=EEQJzgWrbMt6bSyLSFgSRpx/h2r3VAJUFT0nYgTBaj0aj9QsEQ9R4oWrY2TNU5myTF
         Ab7wJF/C70kRmgi0MRzvfWYlUVJxzWwqJI33lZOwKeJYHqX7bs171JbOQe7EiF4bgZ1A
         oAU6fuOKY1Ud1NytPz4Ru0mpRUc1RyFAMpUoR4FLHa1jhOPoBXH3CszTyx8diYpzGnEW
         sqyuBZQXIJInPPW7ljSdhzeOW//CSiP4RQppwuVaVgGnf9ipxqx9xf4W4idlRvRAXza+
         Z3oPxqn717D3mEKM7ubTTvzHIOXhq8+CI7BWlrEBvhO2HuvDZIvDxLjGoqMsCv5q949f
         JJ2g==
X-Gm-Message-State: AOAM533xNdR58V3JNIMMVfFtt/6/YS731uvuOGl82zgyNJEAkffwQidg
        fbIqouWYMllIGFh2gO0FYu2fW47CtqY=
X-Google-Smtp-Source: ABdhPJyM4fFwvRRNX5p+v1RifjT9/ieT6VifxFNZ3IQ0hZrbH1eGfqSR0OqBAwySQxsrAhRe/MaJ9A==
X-Received: by 2002:aa7:9686:: with SMTP id f6mr31328779pfk.132.1593010170995;
        Wed, 24 Jun 2020 07:49:30 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 12sm20597546pfb.3.2020.06.24.07.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 07:49:30 -0700 (PDT)
Subject: Re: [PATCH v2] block: release bip in a right way in error path
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     hch@infradead.org, linux-block@vger.kernel.org
References: <20200624102139.5048-1-cgxu519@mykernel.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6c29e063-5733-9975-22dd-5bbcf297739a@kernel.dk>
Date:   Wed, 24 Jun 2020 08:49:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624102139.5048-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/20 4:21 AM, Chengguang Xu wrote:
> Release bip using kfree() in error path when that was allocated
> by kmalloc().

Applied, thanks.

-- 
Jens Axboe

