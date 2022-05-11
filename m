Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3164FC433F5
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 23:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiEKXG2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 May 2022 19:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348991AbiEKXGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 May 2022 19:06:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1130F29832
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 16:06:17 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id a191so3048160pge.2
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=wp2EX9vjKBERiNLVm2YqE4Qazcs+sBTSt8gG1hLKc48=;
        b=0lEWBFfhsdG9IId5GVveiAnldtVBmoSpEs2i4HsAWqt/iB4StaKi6DfEsruofQfLWx
         uw7e1Ed0i836DvAtDxkr6W+u1IWP9ZhseUwzVXuybeGQYSFDJNv2tgH3y0P8/67FWFp2
         AE9kjICIrnDNadxbQ0Lp/eE9JYnq6jncO37WK/GNovN/vfTq1esy1hVTDR61tXpJDylM
         4AAnmAZIag4R7SrUZFtJP+zMFinnk9CGJP2y2wmA9GqSJYrHkRbGYXHVppR7NOAQW2Ix
         NtCtiqwIlMg6v6IOa74j1UPcctBQ+/gtJWUXar86UvPyQd5X+qoJz683pUA+eYOEbJcW
         P90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=wp2EX9vjKBERiNLVm2YqE4Qazcs+sBTSt8gG1hLKc48=;
        b=EUBKtAe82GIbFVkzfdA1cnnIJKMBPtEJ+bY327l3a1VjyZhnzXEXJIhLY8F8mNZJ/k
         DG40nWCgNLmw5S3QdyTbQh0WuH5mJLa7jG0JTgTEsy/AFHIBcxYLnvyI3rr6klTvL5M6
         MaVKEhJ8C+93wqYJRjKbjtvLqNFOIad/dyjjlnMsZ4PWKnA6W3KNx6aLr6uH3HL1BsP1
         nOjf/XCet2gTpetw2/L6Zi2oZDpwBpDX50HsSeyoG0QjGaVDShSx2T+hWVS3EFvJaLQy
         gbESwA/22XthcKufhtAh0iGn3bYGk+fUgeqNn2p5A++jtRJ1W9Ma15sHzgPj1aQ8XqWK
         MHxw==
X-Gm-Message-State: AOAM533Fe+Nb/lKrstuSp+SAuFCrQ1GRWQZ/x44bNVrkbolDdRlHvnwW
        8/bwhhe1g6r1bCj3kMbWZq44CQ==
X-Google-Smtp-Source: ABdhPJwZ2VgQYwg6fjILGazTAqXGaVFmsdZbwOX3wddLlrT+rWFgzZMa1pmGwGV6SQeR8dw81bnIhQ==
X-Received: by 2002:a63:515:0:b0:3ab:84c3:3f37 with SMTP id 21-20020a630515000000b003ab84c33f37mr23152360pgf.110.1652310376457;
        Wed, 11 May 2022 16:06:16 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902f34a00b0015e8d4eb1d8sm2387443ple.34.2022.05.11.16.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:06:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, zhouchengming@bytedance.com
Cc:     duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220510034757.21761-1-zhouchengming@bytedance.com>
References: <20220510034757.21761-1-zhouchengming@bytedance.com>
Subject: Re: [PATCH] blk-iocost: combine local_stat and desc_stat to stat
Message-Id: <165231037549.15699.13051976092288865949.b4-ty@kernel.dk>
Date:   Wed, 11 May 2022 17:06:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 10 May 2022 11:47:57 +0800, Chengming Zhou wrote:
> When we flush usage, wait, indebt stat in iocg_flush_stat(), we use
> local_stat and desc_stat, which has no point since the leaf iocg
> only has local_stat and the inner iocg only has desc_stat. Also
> we don't need to flush percpu abs_vusage for these inner iocgs.
> 
> This patch combine local_stat and desc_stat to stat, only flush
> percpu abs_vusage for active leaf iocgs, then build inner walk
> list to propagate.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: combine local_stat and desc_stat to stat
      commit: 2a371f7d5fa575010b915e325c5d20b9ad0d5d5a

Best regards,
-- 
Jens Axboe


