Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D6AC433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 12:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353581AbiDOMpB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350953AbiDOMpA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 08:45:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E602625
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 05:42:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j8so7025215pll.11
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Y5lAtzXMg+ppnAbSv6Q3GxiwRfJLdMdWeI1FfICWONs=;
        b=o9fimpV6GpiP3IeJuO1eZov9gqi31/QclX7nLI3lfbAW776Q5//E67iXr7kMcV+uaF
         1WA583e0yHlyPzanmTt/VgrhVUYQtqSpaedKTpXuusp1y4gO9TKpWiksCCqO/CZTi052
         UqYxbayNcHMPdqsOI+H4yi/3jk+Q603ErV7f94mnYeFr8BNQmSJUyZcdxHckYeHRdfWi
         g2IQQYaP4wKxEy/+W83yEcCbPNqfwS8s1nKJq5zU8QQCkK2JuoVqghI+DCbvMByVk9/M
         ry7x0pkr+XlhEddS9+MgnU2sX9vwqdnsdoSC+3YYj6N5nzUBnKsrCbJRkf1/WQKqqb2B
         cXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Y5lAtzXMg+ppnAbSv6Q3GxiwRfJLdMdWeI1FfICWONs=;
        b=bR/KVDjcnHOMNux7zf6TLJT6tkp2OLmooHE3EWvnMxM58/xuaMDTa6wS+rdkWAj1PC
         lUVZP2ShhzTubtf+nFe4nfvIFBrujhsMmvYeQXJ4RE2dQUZ8leJ2K2lwv5fsCE8Z3pgt
         ZmPEeHgYQYpFebVdEBX3pJepSPA+lpSgG2GKAaEQsOl4CYcn9d5O5KwDgXgAbXDo4ujE
         /xT72dF7fuyJUz+4oNkhkJYHfGPax+I7Rpw9Qwi3sGamC/yz9qcWZP7rmyQmVy1p6lFq
         JVHFnAR1j01T7xeM6uxKWLwcgliACSdE4zX5dhAUouZNcDNIjwSfO5SWTwxtrB5iAr+x
         /LTA==
X-Gm-Message-State: AOAM532i1Ml742K+9ob534VtrCwI+sGrjTzQYqh966AfFGy/DQACiGfz
        jCIXfY3Ye7h2IuY79pnN9NCpPA==
X-Google-Smtp-Source: ABdhPJzwIlw9dEPKGbvN1RvyT9uWP90pu1Rx1isjkrAsInbNbT0uMnb24qKjYAMYi5vH86TpAnkLMA==
X-Received: by 2002:a17:90a:5407:b0:1bf:43ce:f11b with SMTP id z7-20020a17090a540700b001bf43cef11bmr3999585pjh.31.1650026551772;
        Fri, 15 Apr 2022 05:42:31 -0700 (PDT)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm2987102pfu.202.2022.04.15.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:42:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     khazhy@google.com
Cc:     linux-kernel@vger.kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org
In-Reply-To: <20220414224056.2875681-1-khazhy@google.com>
References: <20220408234707.2562835-1-khazhy@google.com> <20220414224056.2875681-1-khazhy@google.com>
Subject: Re: [PATCH v2] block/compat_ioctl: fix range check in BLKGETSIZE
Message-Id: <165002655078.10530.5825902345538532925.b4-ty@kernel.dk>
Date:   Fri, 15 Apr 2022 06:42:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Apr 2022 15:40:56 -0700, Khazhismel Kumykov wrote:
> kernel ulong and compat_ulong_t may not be same width. Use type directly
> to eliminate mismatches.
> 
> This would result in truncation rather than EFBIG for 32bit mode for
> large disks.
> 
> 
> [...]

Applied, thanks!

[1/1] block/compat_ioctl: fix range check in BLKGETSIZE
      commit: ccf16413e520164eb718cf8b22a30438da80ff23

Best regards,
-- 
Jens Axboe


