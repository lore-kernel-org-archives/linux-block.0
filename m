Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491F7C433F5
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 00:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiEPAcE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 20:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiEPAcD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 20:32:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA069B1E9
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 17:32:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so1922848pjp.3
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 17:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=oABzOL0ZZUROajzpGcdQcCRjEutzvvQvaz7gOGjVZmU=;
        b=M1Hf+mAYP99z7QHAsv0TSsXIHPcwz/vgbK5W/eNohsehDsGpVeHj6BFqLBKR+3B4PW
         /QEOgmQAOfG8vj+BTHbfFAliiS/x0gGbdqnOg1HQs2pJlt8tPRNypajlRVp/z5YPTFib
         A/0COj0WO85m/vAMtx4mGoWw6JZJKvOnvQPvQwmgFCjA6DiPDV+6BIbZ/82hZqHiosie
         3/AqSb1DDs/EmKyLnqhIR1YKy1WcN7/QCVaHGav4K3SqVBNQ2iBwxKSMYzUHFET5eSot
         DgYSs2vN0fp0mIiWgDSZiiEpheysny2v5hxDVi7X++CIa86vTNR5S2c+X1IiPvD5WQwN
         3SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=oABzOL0ZZUROajzpGcdQcCRjEutzvvQvaz7gOGjVZmU=;
        b=e+s2sElgJx62J7il32otwEwW7dWL1/FxIEY1jUHZjX2cCLXWCYEwz2j95yXsBqY+D0
         +dGjfWz92CWu0A9tH4OObbDvWIaIPC6se6QrAx/VEspwAndaxinQ+t77sPyKgwUE3LNf
         OJoXXq25tu3AWPE1z1SfoaiAw7Ns+8vr3//MsBozq8X5tlt8V18Gd/m3JTkv7huzy0tD
         z1GN5X1gj4Sg6oU9f1p6mXNgK4pl/LcxV7h0t4s6IQl9BKnP/GFNM18Bu5/EPpkHdWZY
         TiKFaaHZZD75QS6zTKu8Ha0oT/25HIqskX/iOAUvlOPfXd/H4r4t37EdJBvLLkPHRn2z
         lmvQ==
X-Gm-Message-State: AOAM532i7HVNukZ61FUfUMvot5hibvee/YokYy8nFJ2z1TGDkKe8nIlj
        fuRUMqdHzUyIzFGbWzS3v0hWLly0mjrKbg==
X-Google-Smtp-Source: ABdhPJxROl6kOCTqfjdadqG8usmR5ExAOaY+8pHFfGP04vHAC5NrXLXVXFPwLnv1P99ihZvDtOOeYQ==
X-Received: by 2002:a17:90a:a096:b0:1df:58d7:5b20 with SMTP id r22-20020a17090aa09600b001df58d75b20mr2085451pjp.212.1652661121413;
        Sun, 15 May 2022 17:32:01 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902868400b0016160b3331bsm2176893plo.305.2022.05.15.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 17:32:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     phil@philpotter.co.uk
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220515205833.944139-1-phil@philpotter.co.uk>
References: <20220515205833.944139-1-phil@philpotter.co.uk>
Subject: Re: [PATCH 0/5] cdrom: patches for 5.19 merge window
Message-Id: <165266112040.697362.10355647770292207089.b4-ty@kernel.dk>
Date:   Sun, 15 May 2022 18:32:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 15 May 2022 21:58:28 +0100, Phillip Potter wrote:
> Please apply the patches from this series, including my own patch to
> remove the 'To Do' entry from drivers/cdrom/cdrom.c.
> 
> As previously discussed, Paul's block patch is included in this series
> too, and I've fixed it up to remove any parts that repeat changes
> already made by others, so it merges cleanly with upstream now.
> 
> [...]

Applied, thanks!

[1/5] cdrom: make EXPORT_SYMBOL follow exported function
      commit: eeef7565e8ba1718e8e1f835f145125fa6cc8494
[2/5] cdrom: remove the unused driver specific disc change ioctl
      commit: 03fea699b050805ad6ee111f9db04f223f3e835e
[3/5] cdrom: mark CDROMGETSPINDOWN/CDROMSETSPINDOWN obsolete
      commit: 8fa10ee183c3a1ecb53e81c95895ed5bc2a5530a
[4/5] block: remove last remaining traces of IDE documentation
      commit: e24ccaaf7ec44e647dc56c1af2bc8d1ab67b4a11
[5/5] cdrom: remove obsolete TODO list
      commit: 2e10a1d693b9f1c8921bd797838cff0be7cdd537

Best regards,
-- 
Jens Axboe


