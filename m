Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483E1C4332F
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 12:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbiEJMdw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 08:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiEJMdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 08:33:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFAB2A376A
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 05:29:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n18so16609946plg.5
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jp7HjFBFx3m1li+wnracJc1zJal8gZ4hoEqGbVeKt/I=;
        b=dQ9mqsipznukUKDUkmGqQ6cNYBKwXMZ6FykGsE/msGVDR87AK14dpp08ZVEpPQzJ5e
         dadLbFK2qQsI2ASI+cILavLkdHwguE51X6a896gLTxd7pS+k2pMbbmfux4zNkQrIBCfm
         XQLVRknw18d84O0e16om6yLrPQ/nHttcRSddgewV3rh6FC6/UTZbfZR7zxZDynpjTctQ
         OY3HP76EtZCi2sTUssIj4yml6XGZIaVfns5p2VtyBXHNN9/ASxJoiYvUt5LkNBoP8bBv
         XQZ7dqo3urs1YpRnZCdP9P9KIJbsSGVifu13+MPT/2WJoghejG/UMHb13aw0z0/bL0AQ
         4E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jp7HjFBFx3m1li+wnracJc1zJal8gZ4hoEqGbVeKt/I=;
        b=tyvGWtkL7PHk/5DXsbzUSkQ1SgyVjHPFK39Ah0JdrcySy0vMcIT0avldqmfiqmEnQL
         LX7Kifa3EoEJfV1/tJZLYA/ICH+J3AXp4QmhsIpONYDUpkwyyVwetzvt7NmsUEaOOG/t
         7x145K+nQGc1f+t8kMsxcKZD2BGJRfIUMoEEvVnE6w8rjFqgFXO+jQg3KD8Jvq58tckt
         YNEmid64lZ0lClExj1OpZuextDf3GLd8zOzfTc86HWeZUqQ0GHHQQepj7MjDq0FvXWaA
         +ljmb5R1KU2SIuApoZG0zZlT2G/OSN5jfjmnkbZsBktfVtkSisKOfOGKV5A+Jmq1NjOk
         MYDw==
X-Gm-Message-State: AOAM531RpHHwZk/xjNfZQOdG0/S1qr6YAYTm+CaxYj3palEdPsQmCNL4
        SkyEgTTGQeQo1j501Cma53SRuQ==
X-Google-Smtp-Source: ABdhPJwgJU11iFqgteUqesG2Y4aoSdv556T/SpO5vBCJUnsWGbRSoSZAfC+9tXV7a2csI0sDnod51g==
X-Received: by 2002:a17:90a:c595:b0:1d9:532e:52fd with SMTP id l21-20020a17090ac59500b001d9532e52fdmr23180190pjt.79.1652185794001;
        Tue, 10 May 2022 05:29:54 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b0015e8d4eb2besm1861400plj.264.2022.05.10.05.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 05:29:53 -0700 (PDT)
Message-ID: <c393d0dd-05a9-2a12-92a2-eebd8d49c2dd@kernel.dk>
Date:   Tue, 10 May 2022 06:29:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: SPDX tag and top of file comment cleanups for the loop driver
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, tytso <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org, linux-spdx@vger.kernel.org
References: <20220419063303.583106-1-hch@lst.de> <YnGLRAuS8QGaSADK@mit.edu>
 <20220503201334.GA7325@lst.de> <YnGgP7ubsXxFTaZE@mit.edu>
 <20220510072243.GB11929@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220510072243.GB11929@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/10/22 1:22 AM, Christoph Hellwig wrote:
> Jens,
> 
> are the comments from Ted here enough to apply the series?  Or do
> we need a formal Acked-by to be on the safe side?

Looks conclusive enough to me - if not, Ted, please holler. I'll
queue it up.

-- 
Jens Axboe

