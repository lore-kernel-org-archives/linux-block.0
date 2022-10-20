Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27122C43217
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 01:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiJTBa7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 21:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiJTBa6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 21:30:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5255015F311
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 18:30:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z20so18880538plb.10
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 18:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BDKoCuiX9gLdyLhtKOYiwtgCSx3wnswv+GarFhOTZU=;
        b=JHS0tpXqLX5GdsoQR5MFjpSHLMbrcGQDL5yQISyBkWOTUWPO0WuLbO2XI4+GI76j4i
         p8YfWzmnFz32jjnoZqPPRsAtgOlNrcCWhOqSXINc49JKDAa9chl7qBcw66j6ZkQL1a+U
         SEWjGiRmPD2p+N+wS4HHHOXafEtOkdYUa53PSGWZJGKQX3Aw4Lzv/HftVgCc1NhnZ7yk
         kVLuSxoL0iGQOq+yVx+lP3Zpn9dGGgFUxt4HtIrbhTlsUPHS5D7FJFSmz61fKZ5BWwKu
         e/Cz0w9imbnAvZv/rua2FppYhGCTHHJ2iDwrCiciBcElkVm8X6WzCgQmko9CyCI8cQ/C
         dwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BDKoCuiX9gLdyLhtKOYiwtgCSx3wnswv+GarFhOTZU=;
        b=j4CSF1HbCnyeWjLXrdOZ0xq3dW8NRbFQIRDdBvSVW+JGQ69N0PzsUtDVZ8IuB28wQ2
         RjR3Hzz2P3fotI4eo/zPPmWVhNWK1LuVOPdovJPQyfjZNk2mHEK13WA6rqpTaOVFFea9
         sdI5UCOJviJ3HqKP0pXeYbcYMwg6XIeaYAfEhJhNXw/gs7LvnDFn/MHMTOA4DxKs7snz
         5wH8cTlVKJsbP/znE53/B4++8BofEkCiA2cRCpLXJbPz/dkO41nBQWo6x+tdn3rd7kCv
         tnN6HgbzAleUommrwHkyn8k1p6z+4Vs8JWzE07U/7F1jMCWHz/IphMjps2PfGjGazFhd
         G8wg==
X-Gm-Message-State: ACrzQf0xK5SmiS/gEYFf51B+g7o6uCneGBYPCb6z/2kxrh9yflTkZTAl
        n0kLams/nakalr7WFB5vnyz2wg==
X-Google-Smtp-Source: AMsMyM7WDF8L7Gcohi5cKDVOBbvJUV/wbv2310vXAaOcpxqGAZO4eKF+4zl5qMZAfPZjQfR3gdSNqA==
X-Received: by 2002:a17:902:bf46:b0:179:eba5:90ba with SMTP id u6-20020a170902bf4600b00179eba590bamr11376463pls.16.1666229275351;
        Wed, 19 Oct 2022 18:27:55 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a2b8b00b0020ada6ed6c7sm521379pjd.41.2022.10.19.18.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:27:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, zys.zljxml@gmail.com
Cc:     Yushan Zhou <katrinzhou@tencent.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20221018100132.355393-1-zys.zljxml@gmail.com>
References: <20221018100132.355393-1-zys.zljxml@gmail.com>
Subject: Re: [PATCH] ublk_drv: use flexible-array member instead of zero-length array
Message-Id: <166622927442.148655.12986325074372768712.b4-ty@kernel.dk>
Date:   Wed, 19 Oct 2022 18:27:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 18 Oct 2022 18:01:32 +0800, zys.zljxml@gmail.com wrote:
> From: Yushan Zhou <katrinzhou@tencent.com>
> 
> Eliminate the following coccicheck warning:
> ./drivers/block/ublk_drv.c:127:16-19: WARNING use flexible-array member instead
> 
> 

Applied, thanks!

[1/1] ublk_drv: use flexible-array member instead of zero-length array
      commit: 72495b5ab456ec9f05d587238d1e2fa8e9ea63ec

Best regards,
-- 
Jens Axboe


