Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1DBC433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Jul 2022 12:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiGPMdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Jul 2022 08:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiGPMdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jul 2022 08:33:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B861EC51
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 05:33:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q5so5296105plr.11
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=o4csOc+rtB7OUTKym0l3RxG2wfhS0254EiN6uhE/JmQ=;
        b=2/NMJ6WlCAOj0nNYy32FujAraP5+NrISPHGUKecmoPyVl0OmmKR7kcJtpqR2NakGmc
         0WizbndmcjewSnvT2dCOGwQ55qmZvdkgVdqn6MNMtwd8FhHd3OIxrwrVkgbnc4u3rYqU
         4pFS7Xm4X8gnvSq6RgbyJ+iTYt7FKx9o5W8PMRQWde8uRJKASZ46F5Q8x/mGWWQ9HxQM
         klVQzScTANxG7U1YYRAPJ+sk63GH/qwoilViwM8XLfOXr4SDQvL18CNDWzY2/ZK18G9M
         VnFHeRwYu+p/QqyYxDyuBNiCzkkDAy6FwZnlwAODYvGsdle8+AqV8snnXy39hhJot2Rz
         zJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=o4csOc+rtB7OUTKym0l3RxG2wfhS0254EiN6uhE/JmQ=;
        b=jG2gqAsKBiG15n92VaWH2iHhH0Lqc+o07vBUFNF19CYD+QP+7J+0D79WPzMUDmaFbv
         FEKjhr86QFfGEeqFfYMrFbaMffKzoBkdbw7yzXSUWUu3sbRKlUKHcvr3SKFM4bdg/AMb
         HGw3y5klF1/E8vPeMsVat3delXLE0ABacYkybC0aJdP7s5bql7rhZ4kP/HgCMU8aaZyu
         jOW544PBGACwhnm9Z1Y6qsfbxKCBAIcNtX/cvMdb/0GUpw1xYGwwzkUKcCg54Ds07CXM
         /+K51APvSt6hFPACCkCVreHZ7Wul9bBaK8irGe3uIxv647mkyV11Ato5uxT0s071IA0q
         XwVA==
X-Gm-Message-State: AJIora9Ez1NkfXxr7OIkQNjCjROTnZgJEa5srjXW7EeMHa91k9JYzXzE
        /P8ZxxhkCXwZnm+SKwDL9m7gvbuJHBYdQw==
X-Google-Smtp-Source: AGRyM1uwCugYrV5gHHxlWUC3M6QBVGA2S0E6AOVw+P1TjDFHQj6fdRDNZcz5gfmUIsb3poGJB2SxEQ==
X-Received: by 2002:a17:90b:4c8c:b0:1ef:bff6:c964 with SMTP id my12-20020a17090b4c8c00b001efbff6c964mr20722243pjb.36.1657974801892;
        Sat, 16 Jul 2022 05:33:21 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k10-20020a17090a39ca00b001ef8ac4c681sm7654278pjf.0.2022.07.16.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 05:33:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     13667453960@163.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yijiangshan@kylinos.cn
In-Reply-To: <20220712094350.1379942-1-13667453960@163.com>
References: <20220712094350.1379942-1-13667453960@163.com>
Subject: Re: [PATCH] mtip32xx: replace ternary operator with min_t()
Message-Id: <165797480045.362401.4678527786770696731.b4-ty@kernel.dk>
Date:   Sat, 16 Jul 2022 06:33:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 12 Jul 2022 17:43:50 +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix the following coccicheck warning:
> 
> drivers/block/mtip32xx/mtip32xx.c:2264: WARNING opportunity for min().
> drivers/block/mtip32xx/mtip32xx.c:2328: WARNING opportunity for min().
> drivers/block/mtip32xx/mtip32xx.c:2357: WARNING opportunity for min().
> 
> [...]

Applied, thanks!

[1/1] mtip32xx: replace ternary operator with min_t()
      (no commit info)

Best regards,
-- 
Jens Axboe


