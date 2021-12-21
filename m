Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543AEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 16:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbhLUQeg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbhLUQee (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 11:34:34 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C957C061574
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:34:34 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q5so1883247ioj.7
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=vLP4eiroe55V6lUMRm6orfW7+CR+Oeoc1rOve2nNZ1A=;
        b=tNYo3RdkE+4sQL2+DmrX2sHPr2YFc7lHg5RasUtAfG8airdALSBeV+dW8sEQ0kYVjM
         n7JAhYsOD2nuqKnWIBHdA1KPM8QgGI1sxxFuX7i6eHBwNolS2FgKDIDiFSUNP65NK88b
         20T4OhXizHMvOfgUqh+m8JNpbTtWIiLAFCyTtbRb+kbhlybj8rFi3uMa/yrMliYJgSA2
         NyhoP5qFQd8BqVw2aBt3dFOQLlSH+iZmIfZ8U6KC3Kwc/uoAhLYWwU9koYNRcY3+rDRn
         TKkiCtU+snGcT0Hz8GMC0vwXJSJ/l6qrSOPZfFxisW5GF7igz2NnuogfPtO6C81RJ6Bi
         UKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=vLP4eiroe55V6lUMRm6orfW7+CR+Oeoc1rOve2nNZ1A=;
        b=sqBvbyfvWeXZvC24KXN63SkIkrttMbE3zL8duQEpFQwL4rJThi8rIwoeHVScrvHVnC
         T96lgtW8S6RUMffoZHN/kzccB86AMHptpcme5/2zoCl4mDR8eAlx61BMSou3GsESAL3y
         YHNg17R/RrCwEfJZrybB41xr9cs64t08tmIFJU4CsDzmO6hMLwAy0W+ZnKRo5YS5hGOz
         bv7FXWOhlpbd+w/XvuyO3HguiJNJlYsiJU1w7HPwzNBZTvSYC986sjGlUO+Ez16wkMly
         nZDxC6vLu1ROBvHI1+KcO8UPUgeL1flSbOStNvP9FlnvLBUmLEOVjHYO/FzHXNjfcopy
         IMRg==
X-Gm-Message-State: AOAM533cxrz9ItpOJ+jv7KH8hxwDopxixEw9AG6v+DYj8d0qKvSiH0jK
        R8EdBvNwCLv1GkmUDZobuvyrwg==
X-Google-Smtp-Source: ABdhPJwqbSVKPEFE7DDgb9nqb0RrZnTl6cdeDKrHhd7/Zy5cnub3TPsQYBohxTj3kxKtIgGbxf7pMg==
X-Received: by 2002:a05:6602:42:: with SMTP id z2mr2058449ioz.208.1640104474045;
        Tue, 21 Dec 2021 08:34:34 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm13598872iow.9.2021.12.21.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 08:34:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block <linux-block@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <b1b19379-23ee-5379-0eb5-94bf5f79f1b4@i-love.sakura.ne.jp>
References: <b1b19379-23ee-5379-0eb5-94bf5f79f1b4@i-love.sakura.ne.jp>
Subject: Re: [PATCH] block: check minor range in device_add_disk()
Message-Id: <164010447356.608284.16828138439159731604.b4-ty@kernel.dk>
Date:   Tue, 21 Dec 2021 09:34:33 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 17 Dec 2021 23:51:25 +0900, Tetsuo Handa wrote:
> ioctl(fd, LOOP_CTL_ADD, 1048576) causes
> 
>   sysfs: cannot create duplicate filename '/dev/block/7:0'
> 
> message because such request is treated as if ioctl(fd, LOOP_CTL_ADD, 0)
> due to MINORMASK == 1048575. Verify that all minor numbers for that device
> fit in the minor range.
> 
> [...]

Applied, thanks!

[1/1] block: check minor range in device_add_disk()
      commit: e338924bd05d6e71574bc13e310c89e10e49a8a5

Best regards,
-- 
Jens Axboe


