Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06595C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 12:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbiDNM6X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 08:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiDNM6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 08:58:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B2991AC3
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 05:55:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ll10so5032644pjb.5
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 05:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=qaviF4kW31Fo1xK4xoBwkHMneCjafX3NgCgaAcKc24c=;
        b=xcoUl7fMXL/JiFHrSRSTwBLqj071n/8CH5h4NCbSPhlRjsLJfM8pWA9iYLVgFhzbph
         is9snEQEUyDSgNVMDzrw8qcq5nHuZHTNLhC52kY1nGhc3c70PK6wu9uNeCcDekqN0VYO
         d2XGWgETRFdTRsrkyNjbKmIYoal4ZS6qWxP4NRKqO8S133dsd42jUMCl0/z/hD62mYJo
         YeFQ1LcHatb/xZ4BguI0JH234wNgm+INY7zxtC8Jg3uN9Q59uSZTvx5kk3WHQkmra9En
         bO9Ww7AIFY52LWZklfxZFm6eLHWeyjY02V2CsMx952rbdn60zu5k3KMrEAyoWtbm+Sd6
         pMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=qaviF4kW31Fo1xK4xoBwkHMneCjafX3NgCgaAcKc24c=;
        b=78Suw2FyQVpCwRxcJoSGvHn3ZOTuWhqgFx+9MC82O8aS4PT9Yx3Tpq24HMcZYlPvym
         m7iCK8E+FmkFSxZ2bbevFnf01ClWGOnZVcCwUW8E9j4cOJ1L52FSdgl36MwKeb41d40N
         xSAtCTk27bMftdHWKL5lrBtq9PI84K0vfobg3mmn6LpVi/zV4Trr8Bb4pRBrMuWw13Ju
         zQj1XO/Rcf+KQCzFe1FOIHvWVF/K/v5zl1t5pj+RcXGX0h59CGkWyTnELO+aKn7dIW1Y
         MbLFwwtQRDuPJ+Gt06t6b8Bbw2GeuD09BGRyHrqhE2nLJJbsMQPoTG3x6XDPmdp2Ck2M
         Q3yA==
X-Gm-Message-State: AOAM532wdxpOrGJDe4FsVCL9gbqwOqjvMDBTH1lPe1Np8NLswifN2YUw
        ndVT1VDxjmyb9FZXUjmMxW7V6i8afYHSGg==
X-Google-Smtp-Source: ABdhPJzo5EiJH+CMimVBcbH8kfaP8E0zTnmGbuz3POJTdntRiF1RALHaL0iWqqRbziG/Cqtfyv6GKg==
X-Received: by 2002:a17:90b:1b12:b0:1cd:5d4d:955f with SMTP id nu18-20020a17090b1b1200b001cd5d4d955fmr3551422pjb.175.1649940956352;
        Thu, 14 Apr 2022 05:55:56 -0700 (PDT)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78503000000b00504e93ef182sm2136764pfn.31.2022.04.14.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:55:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, stefanha@redhat.com
Cc:     darwinskernel@gmail.com
In-Reply-To: <20220414063651.81341-1-stefanha@redhat.com>
References: <20220414063651.81341-1-stefanha@redhat.com>
Subject: Re: [PATCH] Revert "make: let src/Makefile set *dir vars properly"
Message-Id: <164994095556.5549.451228203725812750.b4-ty@kernel.dk>
Date:   Thu, 14 Apr 2022 06:55:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Apr 2022 07:36:51 +0100, Stefan Hajnoczi wrote:
> This reverts commit 9236f53a8ffe96cc2430f7131bbcba5756b97bc2.
> 
> "make install DESTDIR=..." specifies a root directory where files are
> installed. For example, includedir=/usr/include DESTDIR=/a should
> install header files into /a/usr/include.
> 
> Commit 9236f53a8ffe removed the includedir=, etc arguments on the make
> command-line in ./Makefile, leaving only prefix=$(DESTDIR)$(prefix). It
> claimed "prefix suffice for setting *dir variables in src/Makefile" but
> this is incorrect. "make install DESTDIR=..." now has no effect and
> files are not installed with a DESTDIR prefix.
> 
> [...]

Applied, thanks!

[1/1] Revert "make: let src/Makefile set *dir vars properly"
      commit: 415c62fca6b8014bf9b03517c4d6e0e2e7ad02a9

Best regards,
-- 
Jens Axboe


