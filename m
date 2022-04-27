Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71E2C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 14:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbiD0Oon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 10:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiD0Ook (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 10:44:40 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B6534B86
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 07:41:28 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e15so3489442iob.3
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=aKqOi2YxxgVMYrT/iMU227sAyZ3FZV58U8M3nF1WuNE=;
        b=tiIRUA3tr38eZE/JFWO/cio3PgqEpC8xi0+AWAjkClai38fMT7rtoSAEezo0nAULjw
         Hr72iHq2mpHjVU2IUm0aHnNGGN4DOGD6RdqxnVFniNhh3zZkCFR2jq9JYl+jPjqFS7no
         GZNtzlD/INFWl4IaiMyiQzLuxg2cfRzyn/e/XnPRw6pDAXE5J/ZgBf1E4TYm8kbo5AfC
         9mpEy3eWhLcO2eyOpcFReatZ3EI02FxESpD1Wh3SQzjDI17jtH7jW5Mjyj+OcKk0zGBK
         RRdXw/mU4ow40cJ1nFFTg9ojGColhLHGX5NcsZKlov/knSQ9Dd/egGtD7VCAq1xqgOKj
         UZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=aKqOi2YxxgVMYrT/iMU227sAyZ3FZV58U8M3nF1WuNE=;
        b=iDJyKv53a13Bh9uQkP5EWXsok4XEIDoGbkKJSP29O4DvvEBNpUzF8tJIIpdogcqml0
         GKM9y7T8YIxM6tgFGbOF+uuSU30W2y4/IejYtcBomq6zMq0zpB7V/Iwc7DIf7fQYgHfW
         aSLgii8delAZb/mZH6MnuAKbmNl3u9B37amDL2pTemqVTccxwADj8AThLihEAnd7wnrD
         reKWCketYRIUKyM2MxssnEEz2aD10xjgbjHHDZg3yd65T7i3dyOMqpTbW8f7Sv3TFXNP
         970P5sdkjD34/kNktHylkRTBVAgcRGMn71J0GdXzRtc4cjhGMBz4LJGbG4qH2Dp5IupY
         +Zlw==
X-Gm-Message-State: AOAM531uyJvCYDfVLtQUT1sDlA2/vq8GwKiZD28yFPGmJ1H0TZCxZedn
        TmHNjwt+7ykI3kxORazIO242rjwTy8rLgw==
X-Google-Smtp-Source: ABdhPJygX6DgElavYTVsAEod2epfkSAshtz+9yF4fNKo8e5vFnaACFmGEszqzVQV5wz/x6koPY+vnQ==
X-Received: by 2002:a5d:94c2:0:b0:60b:bd34:bb6f with SMTP id y2-20020a5d94c2000000b0060bbd34bb6fmr11639151ior.32.1651070487499;
        Wed, 27 Apr 2022 07:41:27 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 123-20020a6b1581000000b00657b48baeb8sm1182576iov.41.2022.04.27.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:41:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org
Cc:     riel@surriel.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org
In-Reply-To: <YmjODd4aif9BzFuO@slm.duckdns.org>
References: <YmjODd4aif9BzFuO@slm.duckdns.org>
Subject: Re: [PATCH block-5.18] iocost: don't reset the inuse weight of under-weighted debtors
Message-Id: <165107048684.42574.6493116001052820883.b4-ty@kernel.dk>
Date:   Wed, 27 Apr 2022 08:41:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Apr 2022 19:01:01 -1000, Tejun Heo wrote:
> When an iocg is in debt, its inuse weight is owned by debt handling and
> should stay at 1. This invariant was broken when determining the amount of
> surpluses at the beginning of donation calculation - when an iocg's
> hierarchical weight is too low, the iocg is excluded from donation
> calculation and its inuse is reset to its active regardless of its
> indebtedness, triggering warnings like the following:
> 
> [...]

Applied, thanks!

[1/1] iocost: don't reset the inuse weight of under-weighted debtors
      commit: 8c936f9ea11ec4e35e288810a7503b5c841a355f

Best regards,
-- 
Jens Axboe


