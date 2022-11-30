Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60152C4321E
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 21:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiK3VYI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 16:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiK3VYH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 16:24:07 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569D38DBC7
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 13:24:06 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d18so7176494pls.4
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 13:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6Lsc5JX1EsfCIVKdUidgufDfSH65QaOowzu3Qg9HsI=;
        b=qPJmcAzGa/f0joAwMeKTF+3HlX8XsIqSiVl3cTzCtxtsmtSe8KH8Va1t6zVvf/Xf/5
         Vnr3i4Sl6hbirRT+fpyt32KCzapXpCDQ7MqiJli7N/RA8YNRWnmi+QbwS46hHmHbnrE/
         LoNrxldZDJexQEPQzOExL9eP7V4b6uuQNtvnhlSNj5yFQkY0KgwXghCnCc9OK9eJIZSF
         JkYC5TqiDFyNirVR/VzKXpJ/W5fQEMrGIKW1r6FpMOtDQO+n62HsEwJ00S7DbeWR7nkF
         MfxYyjSLNvtLYyg/mm8Llomq4Qb+M2aoTYCUmelDImwt+Fj6wdvagx0VADg4TvGAdujx
         8FXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6Lsc5JX1EsfCIVKdUidgufDfSH65QaOowzu3Qg9HsI=;
        b=FABoNy9mLWPcuDGywHBS0Uv3Mw+ZjGr1/q8VOyzeNjc0ZDgL9u0hf3cAn7ckcT3g9F
         NPHmzEzsaQmx3J9WujG0uY72YQuQEWxYuH2rnjTPAevRJu/I9rJlAApp+0KOYLRvyk67
         uvDf/wm2sb1m+Tdgdd55kOAyvrHxTbZQWCT3bZolPzeJ6bX/clzcx6mL8yUpJvPsdNsj
         gRzCqoXZaKKWOPw86UBL/P2VzgPS6HVGIOSQzvS+p1PPmCwo+uOSMozQTWQGmodxCr4j
         HUNsyCVg72C/C7gSuJsWOa2JjZXA9C90Ps/wPivE08Z9kNHkmkmy0ghc9skLgxhXoVCk
         KAGQ==
X-Gm-Message-State: ANoB5pksqfpcayZVIFcoIz8wIQH0r+aX2ewoCRMkEzbPy4RGfm1WosSc
        0+t8T9WZPtORvWspdMRKN4YD7g==
X-Google-Smtp-Source: AA0mqf5HDMBEtQPCd1mTu/rQ28XjuK7ZuwBNgSuDgb7a8vXqx5pSTF7cDW9Qxo9dvSBps67LvmfAXQ==
X-Received: by 2002:a17:902:ab89:b0:185:3659:1ce9 with SMTP id f9-20020a170902ab8900b0018536591ce9mr42143363plr.26.1669843445775;
        Wed, 30 Nov 2022 13:24:05 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:400::5:ace1])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b00176b63535adsm1946942plh.260.2022.11.30.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:24:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     pbonzini@redhat.com, Pankaj Raghav <p.raghav@samsung.com>,
        stefanha@redhat.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>, gost.dev@samsung.com,
        mst@redhat.com, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com
In-Reply-To: <20221130123001.25473-1-p.raghav@samsung.com>
References: =?utf-8?q?=3CCGME20221130123126eucas1p2cd3287ee4e5c03642f1847c50?=
 =?utf-8?q?af0e4f2=40eucas1p2=2Esamsung=2Ecom=3E?=
 <20221130123001.25473-1-p.raghav@samsung.com>
Subject: Re: [PATCH] virtio-blk: replace ida_simple[get|remove] with
 ida_[alloc_range|free]
Message-Id: <166984344282.477505.2826968238507327804.b4-ty@kernel.dk>
Date:   Wed, 30 Nov 2022 14:24:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d377f
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 30 Nov 2022 13:30:03 +0100, Pankaj Raghav wrote:
> ida_simple[get|remove] are deprecated, and are just wrappers to
> ida_[alloc_range|free]. Replace ida_simple[get|remove] with their
> corresponding counterparts.
> 
> No functional changes.
> 
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: replace ida_simple[get|remove] with ida_[alloc_range|free]
      commit: 92a34c461719eb4a3f95353bb7b27a3238eb7478

Best regards,
-- 
Jens Axboe


