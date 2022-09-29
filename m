Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60CDC433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 13:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiI2NqR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 09:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiI2NqQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 09:46:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51D314C9F3
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:46:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f23so1306407plr.6
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=2NmMPfrLwNDN7SSPMkf5/THhCrc6UTJhInI4Nxzzt0Q=;
        b=n+uLtq47eVOp18ZchpCS0neH9ChI/nE5U1XFoNfhfOKwCxrh9SdS6Y0mNnacivdRko
         /a56HVPyhZT/4PJDV0/inc23FsEM3ZwQiFThMqhNn1mik5h5KOXdPdvIPGo8CSkPQyTM
         CaG4BRXf8WIoQwyaYn89HtVcPlTt25LKWXR9G24VKdYNApi90Xtigq2vKn7cu7co0hWD
         uYz5pyngI6NGirgh458XER1veBJTg19mdKy2LylWX6WiNZBv7ihBXFeMktUxrgSrqCso
         zFtwmaS9woqBBAJEHwHyQnKOUhA7PzQiTkFm+Z+/yxxomXy7XRBmJwdEsr2LX9GXAu61
         cOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2NmMPfrLwNDN7SSPMkf5/THhCrc6UTJhInI4Nxzzt0Q=;
        b=DVouBJ6DYSft9E7cHG95nvz4pbMKJg79NHPjKczF7xkHxYJL3r9TQMbfcPNnnn26hy
         kEuy0ZQhZGXPCQM0x4L3QsraqEUHy5D0/Q9CWc51xrUSbuXO97QlhBmolelf4N7iC/Ga
         SGBV7Od8S8i1xt0E1b6ZLM2X5663tvLUjvCYHVh0Dy/zcX1qhfDKkpFNYIJlckpfSTAF
         g0RVi/uJ/ljVmzEWHdxJxnvAEAKxmT5p0l0rDyDo3A7rQsUc0EBm84Y4a7ULVnxjKYz3
         ZzKbhRxqpvmc3S0sScbtvycQRHGEvqZvPN77eRPg+9jmsgaTdX0Lh7XVCQW+knokcvoW
         fOcg==
X-Gm-Message-State: ACrzQf3jsssRof5tUxltq0Ryusqjf9gqCM3cGkymAd3/4qWxhYl0UUUJ
        g3ObB4aNmRffrLcofT2aUWfZKnwnABPvNg==
X-Google-Smtp-Source: AMsMyM6mzjIkRH/D3HisdQlNM4P4joF1J3xZOJ8x4UKMcUj/wSTS84476mRPTC0WBTUCxquAV6Cp5A==
X-Received: by 2002:a17:90b:3910:b0:203:dd3d:5f8a with SMTP id ob16-20020a17090b391000b00203dd3d5f8amr16408314pjb.210.1664459174971;
        Thu, 29 Sep 2022 06:46:14 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i132-20020a62878a000000b0053651308a1csm6199082pfe.195.2022.09.29.06.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 06:46:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Cc:     damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        gost.dev@samsung.com
In-Reply-To: <20220929074745.103073-1-p.raghav@samsung.com>
References: <CGME20220929074747eucas1p1821a5b79ad24cb559b7b6ec324239e9e@eucas1p1.samsung.com>
 <20220929074745.103073-1-p.raghav@samsung.com>
Subject: Re: (subset) [PATCH v3 0/2] plugging cleanup v3
Message-Id: <166445917417.14399.5673156998220031673.b4-ty@kernel.dk>
Date:   Thu, 29 Sep 2022 07:46:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 29 Sep 2022 09:47:43 +0200, Pankaj Raghav wrote:
> 1st patch modifies blk_mq_plug() function to disable plugging for
>  write and write zeroes in zoned block devices.
> 
> 2nd patch uses the blk_mq_plug function in the block layer consistently.
> 
> The patches are based on next-20220923.
> 
> [...]

Applied, thanks!

[1/2] block: adapt blk_mq_plug() to not plug for writes that require a zone lock
      commit: 8cafdb5ab94cda3ebb0975be16e2d564a05132ea

Best regards,
-- 
Jens Axboe


