Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7CCC64EC4
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 14:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCHOgs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 09:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjCHOgo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 09:36:44 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2A9CD66F
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 06:36:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i3so17838035plg.6
        for <linux-block@vger.kernel.org>; Wed, 08 Mar 2023 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678286196;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU9zfr0sSfDMF8EOQ6jauX+ahLmztKAP76LRaaO6mow=;
        b=Fbs+f7XWjkx4EqHPb0TlwAyQZ185YQctaYG47jre943R45uIHXbUlucC6nAZbBvWHX
         goq5qAcdRsr9ico/tWvRs+Ww6TmnWvKMn9gEtV4Gtw4Y5kIbLcmkVTvSC28Yp7RX8oif
         BIL6oVv/FRwpAx2Or9phACtlRCWhb7z+yn2LqMBFZd6htgmJErC6D3+To5/5iaFzaOAe
         6xwTB7JJ3duEVM/BxOhblP8en49hD0Ppzsc9mS2E4YFwXnV3Hd6qU63abdweSo6R+gMs
         LlOPy6w0Lf8EN65Ox2dnLdfYw1HHyCxep6BFY4+VpZ46k2D5M5FFXj+dUcpFy8YL687H
         im1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286196;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU9zfr0sSfDMF8EOQ6jauX+ahLmztKAP76LRaaO6mow=;
        b=fxSv2W1aH+IU/NEQnOaPOZ7vnzYAz4uSGyJpPt5XtvJptA8WXTk/0qyDXF+hw81MPY
         hWtidS6eA0qJr1qNF8XcE791Sd2qz7+jIFJAHzoRHXTjtsTKNpDmi/8H4bhTNRt/zZBH
         lM1h1ocO5uc1mjXJ/BkLJXHeJPJ+PfdvYmXGFcNBZVmuTt/jK1IdxA2wnMif5KNMNILk
         Z5T5SGn52LUZZEu56KguKJDbpgzlifdlGaItYZBOVAnkMQ2SzrfJJ2FJE7pQTmKTJTU3
         aOPoAtisjPUnkfxHosZ4T4mVDC2eJA1om/T/Bh55TGfvFVGhnx1ki18d2JFvuKEq+9Tf
         OKWA==
X-Gm-Message-State: AO0yUKUSF1cz5r9yJu8o12Qe7Nvo+d5cbxu1Qu2WhnbA4fnJXNMptVmh
        E4+LH7/gpHBWcDccgMHYmPGJCPOxYX+K/fUBf9I=
X-Google-Smtp-Source: AK7set8gk+M4PkzVS8H5/ctwv9YsnJEaEbiSgDwCH2uyaFrRYOEWehf71f7sAC2ty0F7Lx9iCnHLdg==
X-Received: by 2002:a05:6a20:3d24:b0:cc:fced:f740 with SMTP id y36-20020a056a203d2400b000ccfcedf740mr22413856pzi.0.1678286195808;
        Wed, 08 Mar 2023 06:36:35 -0800 (PST)
Received: from [127.0.0.1] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id v15-20020a62a50f000000b005b02ddd852dsm9734100pfm.142.2023.03.08.06.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:36:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Jakub Kicinski <kuba@kernel.org>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
In-Reply-To: <20230224021301.1630703-1-kuba@kernel.org>
References: <20230224021301.1630703-1-kuba@kernel.org>
Subject: Re: [PATCH -next 1/2] nbd: allow genl access outside init_net
Message-Id: <167828619510.180985.80953362723422693.b4-ty@kernel.dk>
Date:   Wed, 08 Mar 2023 07:36:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ebd05
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 23 Feb 2023 18:13:00 -0800, Jakub Kicinski wrote:
> NBD doesn't have much to do with networking, allow users outside
> init_net to access the family.
> 
> 

Applied, thanks!

[1/2] nbd: allow genl access outside init_net
      commit: 6a650ef04718aff580d6b352c38ca839991fd3ae
[2/2] nbd: use the structured req attr check
      commit: d09b3a9ff6c6ef74298e19b22b362bc0a6e4e9dd

Best regards,
-- 
Jens Axboe



