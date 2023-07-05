Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C25EB64DA
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 21:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjGEVtA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 17:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjGEVsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 17:48:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603A91FD2
        for <linux-block@vger.kernel.org>; Wed,  5 Jul 2023 14:48:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-682b1768a0bso30715b3a.0
        for <linux-block@vger.kernel.org>; Wed, 05 Jul 2023 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688593702; x=1691185702;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOPvhh+ov5YJbwQGH/Di2AOKn8vSvodS2CRBdcRd+fM=;
        b=ITkRoDCXLj1jUWk2q4/LpYokNYS2nOFUbwRAPT/S73wHao3WOAvvsEGXySRsycJSPm
         /vkcz9XK6F+d4rsFgNs+/h9Gax0CgFP9shjoYf+Csht+D/aNLZE/yvgXAtOoVsKwrbpa
         fBctavs2/IZkE4wpnrIbZyYn13XmDq1n7kLEpa5hRgiUD9J3TEpzeYyhszNDIpTl1Jmi
         5dRWkKLXRs/koe+s2Rr93DLOCQFXrnoB4KX9L/5YJ4PvN3Ahaj4Za00lkh/z/Fgfx4fa
         3GQBZgMY+MUPv3zoTc2KV5u94QuxluKoavKGxpYGFa1Xk4y0M+usDVqWJRnjon2vA6Gd
         tjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688593702; x=1691185702;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOPvhh+ov5YJbwQGH/Di2AOKn8vSvodS2CRBdcRd+fM=;
        b=ERBP5eNzbMztSFUd/0/FFbETQAV6T8mVeyQk+ZFiEGOUaJQAJa9hVVBthUKdecsQz+
         X3vOzRzFnE+TyRBYX1DYny/mxpgr8ihsHaAc3AE+tZD3FVGN2N4uqmeuVYSz4v0hDY+B
         NGBeWE8k925PCo23QMpnEVbef6eamJ0pekAQTEyQqeRGreTjWjKLqLzEPbFnn+7czPyQ
         DbHADsehy2RSGLwVHBSdBLEJAkI+v3MphgpZvnM8aMUHi+Qi3ARUfXWQDQIZo2DDa8tQ
         LQwfQMvl/H0M+7/JWWCRAu01CJ0ptSkM+sObOuhCIY/FyZUloJa/PWP0XwcMCLQGcB1E
         KiqQ==
X-Gm-Message-State: ABy/qLaMU7MCgyiJk75zv2k4ssswcMITRYfqNSDs9JPiCA/bbZeM3RKo
        9Of+XOfGEtshpBVegOhgbueiaw==
X-Google-Smtp-Source: APBJJlH2ZqRP11QkNFCo9JfQxpUtuhUf7s+3LhTDPi7Xc+3dYYUlgngnznYruHc3MSBJm+YpmKXLdg==
X-Received: by 2002:a05:6a20:7da6:b0:12e:2fdb:7865 with SMTP id v38-20020a056a207da600b0012e2fdb7865mr171579pzj.0.1688593702110;
        Wed, 05 Jul 2023 14:48:22 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v23-20020aa78517000000b0064f95bc04d3sm18895pfn.20.2023.07.05.14.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 14:48:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     dm-devel@redhat.com, Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230610061139.212085-1-ebiggers@kernel.org>
References: <20230610061139.212085-1-ebiggers@kernel.org>
Subject: Re: [PATCH] blk-crypto: use dynamic lock class for
 blk_crypto_profile::lock
Message-Id: <168859370102.821139.12959799730929938922.b4-ty@kernel.dk>
Date:   Wed, 05 Jul 2023 15:48:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 09 Jun 2023 23:11:39 -0700, Eric Biggers wrote:
> When a device-mapper device is passing through the inline encryption
> support of an underlying device, calls to blk_crypto_evict_key() take
> the blk_crypto_profile::lock of the device-mapper device, then take the
> blk_crypto_profile::lock of the underlying device (nested).  This isn't
> a real deadlock, but it causes a lockdep report because there is only
> one lock class for all instances of this lock.
> 
> [...]

Applied, thanks!

[1/1] blk-crypto: use dynamic lock class for blk_crypto_profile::lock
      commit: de9f927faf8dfb158763898e09a3e371f2ebd30d

Best regards,
-- 
Jens Axboe



