Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EAEECAAD3
	for <linux-block@archiver.kernel.org>; Mon,  5 Sep 2022 17:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIERrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Sep 2022 13:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIERrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2022 13:47:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD4B32EE5
        for <linux-block@vger.kernel.org>; Mon,  5 Sep 2022 10:47:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so2469243pjh.3
        for <linux-block@vger.kernel.org>; Mon, 05 Sep 2022 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=WVOtoi3Xl4zMVlxrg/ajrIWarijXXcDxLSphEYBii0Q=;
        b=fbNdRXYnGU1a0b0HmEdmuTQiRLRxUM4iQT3TbjAnl5pNmsmY1xsjJ4HkgILXI2dw28
         NKAtvL6Kfz+P7hmnuPpJX3N933cU4sgyHkJURbcQPuHtSVlTjtib51u3jWNMP3VrirPw
         +cvH5xK3UsSPcL/oS0w4ZCCQ8Nyom3yjdFrHzQCauHY9L1GEGuVrNqnE/Aaa4De3i8Dy
         9mtvarhqTamjLmtSNa92+wTMYv3o/F0UqURas4Knnq5TxK+iEu43NJEQbnQCtu6U8Pcn
         dgXpNmbMYPQf/rRtD0V1drJBmWSh4F0OgLbZGGh9VgI8kDADOt79gJdciCjVBPd0KxFy
         inPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WVOtoi3Xl4zMVlxrg/ajrIWarijXXcDxLSphEYBii0Q=;
        b=7WABSVZeaqU2eILcE/t5a5+PY7sT0CG77n1dq8gAj3gmzKXUTmSmKIdSaVcurtP9zR
         6HzHsePqTOYwkuooCyBUAWntsji0IYyYv23MyH/AXf9jx5bIbX2p++u8d7EHJnNFK2Ra
         qcLESd2gA303/PLY0fIqsHMZLhqf70bo2yoNr20KSW9O69xhgtK9BH0J3ilFG/lxihxa
         eSILceiNMk6nCbc0jHgXArciZRq9CSSY3xLkmaHkzfGku33JHgfEKaFN/h73hzZMm+/F
         Xndfwr0DAqs5NOfQIGcoNK0IT/mNHtdNGC5mgIQqkhc2cpFlaEhBzTo0PunSRWl8x3gw
         l2IQ==
X-Gm-Message-State: ACgBeo1zJYlNj18Wttrc1G+i2xznuJhU2+fE17HhdEzrP8lfdqIBVl/s
        /zhRF8mWPSRKTR7dw38BpzkwK6m6dJkOkg==
X-Google-Smtp-Source: AA6agR6dV3qqxw4hGD8AtJjtplCcdeCS6WMK4TnfhJHX+ZEY1RvetFBBRwuVxxqC29+DN6Da5zmr6w==
X-Received: by 2002:a17:903:514:b0:172:dab0:b228 with SMTP id jn20-20020a170903051400b00172dab0b228mr49079639plb.170.1662400019942;
        Mon, 05 Sep 2022 10:46:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79981000000b00534bb955b36sm8130784pfh.29.2022.09.05.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:46:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     haris.iqbal@ionos.com, Guoqing Jiang <guoqing.jiang@linux.dev>,
        jinpu.wang@ionos.com
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220902100055.25724-1-guoqing.jiang@linux.dev>
References: <20220902100055.25724-1-guoqing.jiang@linux.dev>
Subject: Re: [PATCH V2 0/3] Small changes for rnbd-srv
Message-Id: <166240001917.375921.13185226804911913309.b4-ty@kernel.dk>
Date:   Mon, 05 Sep 2022 11:46:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2 Sep 2022 18:00:52 +0800, Guoqing Jiang wrote:
> Pls review if the new added comment in the first patch is appropriate.
> 
> Thanks,
> Guoqing
> 
> V2 changes:
> 
> [...]

Applied, thanks!

[1/3] rnbd-srv: add comment in rnbd_srv_rdma_ev
      commit: 095134fbc2d4126d0575485e52139967f0771e30
[2/3] rnbd-srv: make process_msg_close returns void
      commit: be2b2f6b62b55bbb30eb611c1730cd9056dbf7bd
[3/3] rnbd-srv: remove redundant setting of blk_open_flags
      commit: 8807707df7ef09d679df2b21894d49a06fd8ba7e

Best regards,
-- 
Jens Axboe


