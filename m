Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF81C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhKWQSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbhKWQSI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:18:08 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63B0C061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:14:59 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id j21so16684895ila.5
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xIUI9Sm6v90ZiYepXSstLGooRj3KvIqFk667gPCLHsI=;
        b=5B7zJpCVAr8C+NGxE0tOO37FGWWNTvItvKvB1AjTVzgUsBIt4yqkraOxM/fsCzucns
         wA6mfYyZXkJbObowq+nQ2T92qqxs3zJVmgquKegWQt4etmY5kaJ9tRfpKLMjBq/FRgLG
         dGzozSzpog38+l+8StMJac1xRS0oz7SQLs/qvVrmSxEG+4pYJTWZg1MiLtfft38D3bmP
         8JWVH3YYft7IxOe3aB0NpE4P6Sia1QR0u9UOERHpAWJhw0lWlhrMN8YkO0pv60/MSw9e
         arGBkTWUFbuHIQuW1D5FcwGylrUkas3NTXQ8yAGpcYBeOtnt6t9ACZNzM8a2kwTsGfH3
         Cp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xIUI9Sm6v90ZiYepXSstLGooRj3KvIqFk667gPCLHsI=;
        b=fUoYDTs3+zS5MaGvSBjUARHRyx1T6sMKnHT9N6o1KyUc2b3pTMxUjWNWoMEAR9Q0x0
         ty4+4RNLoTnRa9/mIWwiZyGqnfxUSXCYd5rUZxT8PoHpRr/3YA6FSN3i5qnpHWbt8q7c
         dENLZOV92gEwDxiDPmhXsySSHxGX9gAOU1JZO6Q7n/dzwdJCerQ2+9kQCQvG+OqguiN2
         xYykcY0WoR2S7BC/a3MrRg9x4hW01kBl/ahX0MR4wsT8UjTSI+443QDbAayDxxSDWNX6
         CrCAMTsaDPnGUla0APlZgcsfTpVY2StB0zbpiE1+EM53rybZPbhZUAGsHUfWndMm8Ltd
         zjWw==
X-Gm-Message-State: AOAM533mMAMiVtSnSLCfsIGlFM1HVAi18IvOg7FHKSdFH4mJyqlR6ulq
        wiC+HAF28gE73MZVKgrs8un7GjpkEXR6iF5h
X-Google-Smtp-Source: ABdhPJxvxGr0jH3mktTOSTPFDotpWHTteihO/6pkv5bcEHxj0+HfO6IIrD+ZKYsOIigEMz/USNm1Rg==
X-Received: by 2002:a92:d74f:: with SMTP id e15mr7038547ilq.181.1637684098951;
        Tue, 23 Nov 2021 08:14:58 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z6sm9718842ioq.35.2021.11.23.08.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:14:58 -0800 (PST)
Subject: Re: [PATCH 3/3] blk-mq: cleanup request allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20211123160443.1315598-1-hch@lst.de>
 <20211123160443.1315598-4-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5db26d62-1573-ffa3-0890-46f7eb4f0149@kernel.dk>
Date:   Tue, 23 Nov 2021 09:14:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211123160443.1315598-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 9:04 AM, Christoph Hellwig wrote:
> Refactor the request alloction so that blk_mq_get_cached_request tries
> to find a cached request first, and the entirely separate and now
> self contained blk_mq_get_new_requests allocates one or more requests
> if that is not possible.
> 
> There is a small change in behavior as submit_bio_checks is called
> twice now if a cached request is present but can't be used, but that
> is a small price to pay for unwinding this code.

I've done 1-2 from this series, can you resend this one against the
current tree? With the fixes in 5.16-rc it needs some fixes and I don't
want to hand-apply it (I did with #2).

-- 
Jens Axboe

