Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6372C04E69
	for <linux-block@archiver.kernel.org>; Mon, 14 Aug 2023 21:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjHNVnA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Aug 2023 17:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjHNVmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Aug 2023 17:42:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F2D12E
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 14:42:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6878db91494so955464b3a.0
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692049363; x=1692654163;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HokS0Ay8nEZeEvLtY3kgB7gREbBGYmdmip7sM3/qZ0c=;
        b=DAW3jYLO1aY5rAnZUWMNaUhIlMAYySEnNnsvMYtTq5t95sWt6AjWe6SZvfmVQBrKCO
         lj7pVkR2nd/E7wkJih48ridFoM+1jwxuUUiNT6CnHzSPoOxAHE3LPshmBVtYOYxhTTJX
         fpCgCxpKMCSIQIZiEIEjz3vY31Bh947ZzkxA3AvloByrMVjq2e4ZnN4FpQrh8DMPHDOl
         pVI7TESmfl2fU/bHYSk9GaGEOtZiD+HB1MUPncHKgInbqu4CYn2FltI/nhVnVQupNVSI
         P/Do+TXuQuh29AplsZyk1a7Z+mEQ7+may2xa8RczSYiOWMD1sSSD+K72DeT/kj/e+HHU
         sl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692049363; x=1692654163;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HokS0Ay8nEZeEvLtY3kgB7gREbBGYmdmip7sM3/qZ0c=;
        b=cXyGWgDIfc4M0PWFkVPgu2M3U+w4BB72KCfkhDsfFmddxVBDd050nX3OjyoZZtwJGl
         lZIF+sya558ic8oT10Zk5Mo8XvOfKJF00pDzP/9sSNfiKCYlYo9VizPhOzlcSD5AfmvF
         lK6Alf0ARClPeQxrOKQQPa0F83NqQqGndA2C2oazt65YjLNeQ01/be0/4Mx/4HuNTWZo
         ufOp8K/IckjxQjzESekzYcFuH72GNL960Mu2vCm5cI+VwDk0EBJrU7NWmDIaJZOaidhi
         txuiHh4lhBIL3lrZoCgAR0utmf0Z43BDl6pycdiatXRSS+Nx52NtvSMRRu/MQk7Bcty/
         WL0w==
X-Gm-Message-State: AOJu0Yy/gemMgbiZ29/xe3/MV+LKk7QCZL3dsC3C8tny+q8XYuk+GxpS
        +HCTk3SvsEd8YiC4nYNfGX5bvA==
X-Google-Smtp-Source: AGHT+IHLNdgUyk1B0TuKyBoCN80Q6dxGq7WvVUcgQizu9WGr9aTDFaNFJH7Mrfki8rSFWEdmPdfB7g==
X-Received: by 2002:a05:6a20:8f0b:b0:140:ca4c:740d with SMTP id b11-20020a056a208f0b00b00140ca4c740dmr17424290pzk.4.1692049363226;
        Mon, 14 Aug 2023 14:42:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c9-20020a62e809000000b0064aea45b040sm8322132pfi.168.2023.08.14.14.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:42:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
In-Reply-To: <20230813182636.2966159-1-kent.overstreet@linux.dev>
References: <20230813182636.2966159-1-kent.overstreet@linux.dev>
Subject: Re: [PATCH 0/3] bcachefs block layer prereqs
Message-Id: <169204936207.419413.14562602017463272186.b4-ty@kernel.dk>
Date:   Mon, 14 Aug 2023 15:42:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sun, 13 Aug 2023 14:26:33 -0400, Kent Overstreet wrote:
> aiming for v6.6.
> 
> The "block: Don't block on s_umount from __invalidate_super()" patch has
> been dropped for now - but we may want this later as there's a real bug
> it addresses, and with the blockdev holder changes now landing I suspect
> other filesystems will be hitting the same issue as bcachefs.
> 
> [...]

Applied, thanks!

[1/3] block: Add some exports for bcachefs
      commit: 7ba3792718709d410be5d971732b9251cbda67b6
[2/3] block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
      commit: 168145f617d57bf4e474901b7ffa869337a802e6
[3/3] block: Bring back zero_fill_bio_iter
      commit: 649f070e69739d22c57c22dbce0788b72cd93fac

Best regards,
-- 
Jens Axboe



