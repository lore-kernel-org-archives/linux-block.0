Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A395C433FE
	for <linux-block@archiver.kernel.org>; Sat, 28 May 2022 12:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiE1Msx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 May 2022 08:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbiE1Msw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 08:48:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DAC140D2
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:48:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b5so6383950plx.10
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 05:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=MnagosiILgWcElXIwikX5UphVikopylBoWqMoiiMl5s=;
        b=cDdWhmYZ12EuRnQEYuNTiOsn2Z4q9Hizo0Y/sTGqlofQlsFknWPNL++0xlSgFUUPCp
         TZsw9XBGIsYuruj+rvzhYxxFSyshhkm/MLQM3csnm9eraulRIPjUIkomdZxn5RMXB8TA
         7E8SzIBqGj6NyVxVqUZN5z7/dqwudKdo+TFG0mnNbyV1AcGCnXgRQDN4X4YOEj04fpQP
         4Hlg1aAON7r8Y17SffO9i+M1mNZc1f1Nla+TaG65lCNMYMr5tz1BScQWVS0KEa1D0o6D
         8SBaG88NhZ/T5bExc0UKJip6b3dyobBJjIWAg6gyuevVYZJ0+TvtA9OSnleWxn0JpsMO
         J9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=MnagosiILgWcElXIwikX5UphVikopylBoWqMoiiMl5s=;
        b=CHtFlZyMSiBtNtuqTqOPFn/skpkXY+LlnuueuOyL92vDOb/QUJ8W+zKCYT5+Rr6Ujo
         9hNU7NBiEHHvQtCbqSc7HyxkjeLKayd5HXrEjVoJ4zey058UTSu1eukXs51kJPzZo3oZ
         H4Ig70iEBCpTg2Wlk19dh3UqNL6+JfLhmZDr1yf3LVRA52b42fYj3CvD+RvnrMYUrEwD
         FfBi9Mav73mh3n8KFJaW4L2lOs27E23tRhkpX0UAtvqcG3lAp9cF9gm7hYGmqr4yuv4t
         FRrvBPiWKJnOOLTBUXxvVSFYjIretuZFpidloP7R7mnO+Tkka1O3J2Wi/OTNjap5o5kC
         fhPw==
X-Gm-Message-State: AOAM530XvksDDUQCGulvTZSi5R3/zEIzsJpScUJXfVu6arJhyb7XzLLI
        gl/VY+a41yWDcvV1fo0xYUpxGA==
X-Google-Smtp-Source: ABdhPJzCGtiYY0UDNOsKgV5dFa6cy4cXR83xuIF5LkbPl3FXIivXuTdIqIwgjkn8aLYYLLdR/Ak0SA==
X-Received: by 2002:a17:903:1d1:b0:162:3dfd:adaa with SMTP id e17-20020a17090301d100b001623dfdadaamr23286342plh.22.1653742130080;
        Sat, 28 May 2022 05:48:50 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0015e8d4eb25bsm5623040plg.165.2022.05.28.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 05:48:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     colyli@suse.de
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220528124550.32834-1-colyli@suse.de>
References: <20220528124550.32834-1-colyli@suse.de>
Subject: Re: [PATCH v2 0/1] bcache fix for Linux v5.19 (3rd wave)
Message-Id: <165374212924.762356.8804693148122760367.b4-ty@kernel.dk>
Date:   Sat, 28 May 2022 06:48:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 28 May 2022 20:45:49 +0800, Coly Li wrote:
> This is the last bcache patch from me for Linux v5.19, which tries to
> avoid bogus soft lockup warning from the bcache writeback rate update
> kworker.
> 
> Comparing to previous version, the only change in this version is to
> change BCH_WBRATE_UPDATE_RETRY_MAX to BCH_WBRATE_UPDATE_RETRY_MAX. This
> is only about naming change, no other thing touched.
> 
> [...]

Applied, thanks!

[1/1] bcache: avoid unnecessary soft lockup in kworker update_writeback_rate()
      commit: a1a2d8f0162b27e85e7ce0ae6a35c96a490e0559

Best regards,
-- 
Jens Axboe


