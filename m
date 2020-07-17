Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1452C433E2
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 13:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B5A20704
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 13:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jwtFCkad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgGQNP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgGQNP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 09:15:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B071C08C5C0
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2020 06:15:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ch3so6498682pjb.5
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2020 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MvzG0g63u+RjIUSmhlF0+sc7v3Sr//DxS4k25XHaOjg=;
        b=jwtFCkadcjumBubYq6tA4t9/w+3zj256IR/pDHYUPvXdrZTX2YLViuktcSNRrQoZIl
         rGnp5hBz+0NiFREq5oR4jW1E5V33K406zRZ7ygEOuBaBESfAIWLozM3FOdCA0kUJWlEP
         kr94vrw1DGEqW9Cbgeda+p9OaF5br0xLxj+mtLKmMBwnky83M20fSx75ape/ZStqVDRK
         ZwzsDL4sInL8HD9rjuDsrB90qpxYPCTftTyAx4IPlwrbtZgVUZ3yHlKqxsHjKaVMasdu
         VSd1xmw4ChrdFSlCBS/WkyPOhEkCgYG99V0h8YpNkrx8VIIinwU9WWEIIeW1tXrU4VT5
         BtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MvzG0g63u+RjIUSmhlF0+sc7v3Sr//DxS4k25XHaOjg=;
        b=Cpd/8aWgCkMb/zFp8I2KEUCdn0KvGl2LR7/TUq1ELujtgd8PiigEsWsTp8wiCz46hu
         QdwXK+qCPnmROaBGLJ5M9a+cJ6usTOWeo7X6aZUDgqO9gxwbF27Ny3Ic/Xa+pj715Avp
         Gc+B1C9yOSjpwCVak5AyeZveCYkyFNpdGArJIGnAScQRj85NZ3Kd1SNhlle6u7O9zImD
         AaFQuL1Iv+PbiIEdixNrg+TbZbfJEnzfBzv4W2pvypSFzT+ZIXsV9RyN0H9qk1in7cdF
         a4cTIOwSv3kx8iI/Jhu/SAd9Cp3bTZ+KN5pgCkgZfQtFK/OKYhkAIckGVhaEwrXfuhUW
         jizg==
X-Gm-Message-State: AOAM533Lfg2PSweeJZdksisRRtBWHGBvkJNBOBYibvmaQZllccg7tRow
        SVcNYAyDDMu7XUw7Z2Ca/L/FeQ==
X-Google-Smtp-Source: ABdhPJz848s1wYRfrcUOiF7H6UR53NUwQSAewWSWcuj6cpWLM4416SVIf723cYNWG1QtP+1aY0N40w==
X-Received: by 2002:a17:902:ac82:: with SMTP id h2mr7689116plr.300.1594991727927;
        Fri, 17 Jul 2020 06:15:27 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id ci23sm2872917pjb.29.2020.07.17.06.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 06:15:27 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] two generic block layer fixes for 5.9
To:     Coly Li <colyli@suse.de>, linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200717024230.33116-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <679f0d2c-a169-2f71-563b-4d313e57a918@kernel.dk>
Date:   Fri, 17 Jul 2020 07:15:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717024230.33116-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/20 8:42 PM, Coly Li wrote:
> Hi Jens,
> 
> These two patches are posted for a while, and have reviewed by several
> other developers.
> 
> Comparing to previous version, now the discard bio alignment patch can
> correctly handles partition offset as Martin suggested. I verify it
> with 5.8-rc5 kernel on VMware ESXi 6.5. 
> 
> Could you please to take them for Linux v5.9 ?

Applied, thanks.

-- 
Jens Axboe

