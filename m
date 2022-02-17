Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53916C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 02:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiBQCvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:51:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiBQCvb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 21:51:31 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD1A2A82D0
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:51:18 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so4174585pjm.2
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ygPHPbF+JM1VSIp9L0YK19a1Zl9G0fw5oTIn4PoZQuc=;
        b=tzCUK/ie5JvW4W+gZx0pkewJfJxRVciAYwFcZvP518sP/EUMcHO6CknrT7wC8A9bJW
         YeM2lxrWKoVsqJVqEUpJY/BotW3Dk/5HWNw3LX/RIkqaOjYEpfbQnrtkruNsPLkLqPLp
         vJYJjN0Z7JpKq7r5fvS7Hth4okCAbMM49V1DuPRc7M6d4zmfC/I7h42+bbqIeD7MUiza
         rICVExg/O3PpLUO8gsxPk8IAlcPQuQTTwDYAM5Nsmo9+4ukkEzouD8EFcvV/Lm0P1ljl
         Ysn2ylx0u4y+gKiMBb/Kjk9y5QoVluUgUa6IZFc5oPUlPeJHt585A8lGVJHT9C5Osbc3
         2BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ygPHPbF+JM1VSIp9L0YK19a1Zl9G0fw5oTIn4PoZQuc=;
        b=Dl69Fi8awlPopnKuhKl4sZQuS0zgN4Gq0JQxnETVCncJ6BOQL2zmLA4whBQsy1nMbw
         Gz8rMc1NwZx5yHDIw43vT7krp3qm7LxrGzrTLyeawwjH9DtXqAD9V+rTv5weXfe2eTa4
         tTFvEBgoloSpo1lpVaIcq/XuUd0Gwlf0LA5k9mO8WXFJ6sC+t6J8rlhzhGC//ZnZwMgb
         6oj9Jm6IDJW8xvRDIZArLP2NaFoR3Y8C68xt/Gsho946MfHaY8fz/7jawJDP7842Ak4X
         l+B4qcy16/NEoKKfQxEB9Qwt9kTcH81v3rh/Cd8JiOHADyYDSGDBaOIBTX1l7Pnouhc+
         +66Q==
X-Gm-Message-State: AOAM5328mUvEymeiPPl0hONXJqZB5i3DZurly6D24q3MWL+lBQivMDjo
        KImHUThbVm9KitTv+cZ8nKRnwg==
X-Google-Smtp-Source: ABdhPJx/d5Bh0+8ltGNPgHCISLu5X+nsGk9x+ixVq6Z6U2cy7oVwV6oPQrYJbHUjysuBhGun7nrmGA==
X-Received: by 2002:a17:902:b28c:b0:14d:863e:be80 with SMTP id u12-20020a170902b28c00b0014d863ebe80mr849114plr.141.1645066277924;
        Wed, 16 Feb 2022 18:51:17 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id on17sm369872pjb.30.2022.02.16.18.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:51:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     paolo.valente@linaro.org, gaoyahu19@gmail.com
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220107065859.25689-1-gaoyahu19@gmail.com>
References: <20220107065859.25689-1-gaoyahu19@gmail.com>
Subject: Re: [PATCH] block/bfq_wf2q: correct weight to ioprio
Message-Id: <164506627698.51985.1047407543344769592.b4-ty@kernel.dk>
Date:   Wed, 16 Feb 2022 19:51:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 7 Jan 2022 14:58:59 +0800, gaoyahu19@gmail.com wrote:
> From: Yahu Gao <gaoyahu19@gmail.com>
> 
> The return value is ioprio * BFQ_WEIGHT_CONVERSION_COEFF or 0.
> What we want is ioprio or 0.
> Correct this by changing the calculation.
> 
> 
> [...]

Applied, thanks!

[1/1] block/bfq_wf2q: correct weight to ioprio
      commit: c766ace687d7ba1cbb485759f19ef33b35fb1b4a

Best regards,
-- 
Jens Axboe


