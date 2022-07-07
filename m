Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DC3C43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 23:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiGGX34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiGGX34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 19:29:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC61D339
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 16:29:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso272357pjh.1
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2022 16:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=bKyH9XXaCex1IfNYUixgyB7gDQswAfFasHYrlIpKD6Q=;
        b=4Cgq4/Ne9ZYfyNsa5EocFee0pyhs1RupT0QavjYC87SEj/TMP+/B2BpuPIjUg50Cwz
         mOHWc3TdqblyY8/IA77BqwH3NdOGMDBv0m1/djkUks0gQwvDZ8tYiv+iZL3V+X5pWvpg
         2iB3hPptVrV3vQTmh8vc6UMkL+eF7C5s5sGzDflsefBkk/jZhFUZYH+bw8y5wUy9rxjx
         dtA70S2sZfHpmklnpQRdegT+QTQfzCQOp3S1iqIf18uiqFpYX7e75/hA7pWF4emhE4ro
         UzJR7PtFPQNjZETo8guhQTWapWlXwnPqREnWrT8wOIChiSm0tfNUWQYQ/jg0B4ib9qjH
         xoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=bKyH9XXaCex1IfNYUixgyB7gDQswAfFasHYrlIpKD6Q=;
        b=gVW1U95DvrhcuYA4kbcDet50/gMUdkzg0cQbgXBN5FPFRv6kc9CK9gnIiity1kQuni
         AbWC2iRFXpYmmHJoVzu93eB3/NFzFj92biJQ3b1bitF6OkyezZMgP3TmxWkiP62CJcg2
         BqFnFh5cmMXbthIbrv6Q7fJxRQd7L+nYoyK6fx1Cf7IHRvpTnYIBy1gnXVfp6vzQ1x1J
         oRCXs7ceWJjiH03CLvHITRvM/bZtM0vEy5SnEvaANp5tD5fVX0iksJZwo3/8PaGjenp+
         HBl4G08rw48XEtOrnHUDXDnlfr8cRxEAy5NfSfpdKVC36IeyoxYwAewFxVogrTYTNXGx
         UMZw==
X-Gm-Message-State: AJIora/NYTqRIfZoCn8mGRSf3KcxZbHYYHTvcNXIvYHSUN4uoTw9mzaV
        v4RePwe5IFG4jWB57JCVx+Tt5A==
X-Google-Smtp-Source: AGRyM1ta5syxrM4Nqni/uFm5yb4PqzfacNOr2Wx9NxL/aU0fC6scap4RHnYsOXc4QPExJy7tThCaFg==
X-Received: by 2002:a17:90b:292:b0:1ef:a490:3480 with SMTP id az18-20020a17090b029200b001efa4903480mr360317pjb.219.1657236595108;
        Thu, 07 Jul 2022 16:29:55 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j3-20020a635503000000b00415b0c3f0b1sm254441pgb.69.2022.07.07.16.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:29:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     haris.iqbal@ionos.com, linux-block@vger.kernel.org
Cc:     hch@infradead.org, bvanassche@acm.org, sagi@grimberg.me,
        jinpu.wang@ionos.com
In-Reply-To: <20220707143122.460362-1-haris.iqbal@ionos.com>
References: <20220707143122.460362-1-haris.iqbal@ionos.com>
Subject: Re: [PATCH for-next 0/2] Misc RNBD update
Message-Id: <165723659418.61909.14939220850942760210.b4-ty@kernel.dk>
Date:   Thu, 07 Jul 2022 17:29:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 7 Jul 2022 16:31:20 +0200, Md Haris Iqbal wrote:
> Please consider to include following change for next merge window.
>  - Fixes a minor bug
>  - Removes a list, and replaces its use with an existing xarray
> 
> Md Haris Iqbal (2):
>   block/rnbd-srv: Set keep_id to true after mutex_trylock
>   block/rnbd-srv: Replace sess_dev_list with index_idr
> 
> [...]

Applied, thanks!

[1/2] block/rnbd-srv: Set keep_id to true after mutex_trylock
      commit: 5ba7b490d9fce87b2aea9de27e13da6ef5300a17
[2/2] block/rnbd-srv: Replace sess_dev_list with index_idr
      commit: cf9db9e0f6fd15aa044d32e4018c3a572534a9a7

Best regards,
-- 
Jens Axboe


