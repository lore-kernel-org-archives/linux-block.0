Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9097C04A94
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 13:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjHJNUJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjHJNUJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 09:20:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A51026AB
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 06:20:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6879986a436so171595b3a.0
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691673607; x=1692278407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Lmg27TdWe9D57yW06yucm6FqMocbrRUzae5+o2eDG4=;
        b=OsQjnMQEKHP2wG5ihB3Db+xWkOi4zO96Q9thFsrze5NwkgPatkg64omkJpZSu8nX2d
         IeXLZZPjQsLbgt/1KkgVA4Vj63F6sD16NniAK1rAYAmFqDivGbQJMaQyw+h/OzU4ODmU
         mhlfGzzVqV3q0OAF3gnBDQrUXfb6qJTfwFFGz+s3H2gmYTlJX2SKlK49RFnxhAO+BPPR
         MbEZROTQSjt0OeIOo0EMuCyImcAq5vcoAL8WUYMI94xIEo1QLRYdBmWuVuN0xjP5B+jG
         +O9s490lYcZHILM+e+1grwpgQlLBadasKGET/9Tykpd/F+FclQ1qyvI/cm3VgddOh5b0
         nkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673607; x=1692278407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Lmg27TdWe9D57yW06yucm6FqMocbrRUzae5+o2eDG4=;
        b=KwEiwSh54L2W0csNfvWh8RIUb3+CmtNPKGpKx9bkjyXYGkmDdrBhQlmEIcflksw8rD
         aJJyEWFwFUNkN1WFSCdMK4WQiVC47Pi3IUIfoUqcKqB3Vnbw2xIFR28eW34el2JpYcqJ
         lPNenjeNbzqOf1kO0ZrlYQ8UhM7lSS/VVbGrLUW36FlQnGa06atBqlllkelMMNXgoYdd
         n2CgtSouvzH1jMkfn7rCfsT/GhhkXbF1sqWkImvdH+3joyf36HiFQooXXeOLdSx5eULC
         ir7DL23NXJ1LKksBa5bo/KY8HIKlA8C8RJbBL9NELJbKr/D5SanvK+hxarpqXhAxtAjE
         sboA==
X-Gm-Message-State: AOJu0YyuTS0FGMqHMZ9iR5MB9hMv6dkjSFtneGKcTVrmtR+xDexCh5nz
        etokfcJqfuofjjN/+SxpsBRhb1yS90gGPab9xAI=
X-Google-Smtp-Source: AGHT+IGsdlV36Y3IOef08XTKp2KtMyqkbsLL3JgiSwZOtPvM46YzRYq9Mrg5xCyoHTIJ8yp9rnUk4w==
X-Received: by 2002:a05:6a21:78a9:b0:13d:fff1:c672 with SMTP id bf41-20020a056a2178a900b0013dfff1c672mr3107607pzc.4.1691673607490;
        Thu, 10 Aug 2023 06:20:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c24-20020aa781d8000000b00687ce7c6540sm1527065pfn.99.2023.08.10.06.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:20:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, a.hindborg@samsung.com,
        Li Zetao <lizetao1@huawei.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230810084836.3535322-1-lizetao1@huawei.com>
References: <20230810084836.3535322-1-lizetao1@huawei.com>
Subject: Re: [PATCH -next] ublk: Fix signedness bug returning warning
Message-Id: <169167360643.227591.12399433177776480320.b4-ty@kernel.dk>
Date:   Thu, 10 Aug 2023 07:20:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 10 Aug 2023 16:48:36 +0800, Li Zetao wrote:
> There are two warnings reported by smatch:
> 
> drivers/block/ublk_drv.c:445 ublk_setup_iod_zoned() warn:
> 	signedness bug returning '(-95)'
> drivers/block/ublk_drv.c:963 ublk_setup_iod() warn:
> 	signedness bug returning '(-5)'
> 
> [...]

Applied, thanks!

[1/1] ublk: Fix signedness bug returning warning
      commit: c8659bbb15cd42577a9b16a23b527436b028c8b2

Best regards,
-- 
Jens Axboe



