Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B3BC3DA66
	for <linux-block@archiver.kernel.org>; Fri, 18 Aug 2023 01:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356802AbjHRBR3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 21:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356868AbjHRBRO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 21:17:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324433A9F
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 18:17:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf095e1becso633545ad.1
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 18:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692321428; x=1692926228;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rOWh71R2unsmK0j18LXUVFqJ8OAoWTJeI+ndUPvXeI=;
        b=ZTS6fgNIGlcr8R7FOud+NC/deBiPoZ1OfG4zLqCQA3jEFU5bqr9ZrccyJKZN8251G2
         mt3YVWglWPQ+PoGr+V9Elwd/iHFVWotmUBWoTTpLDpJqWZcmmjsWQqZtKr2Tx5Ng6QBJ
         JaU5O57Z8hEGukbgSoUY65rqJQ7DbbWvfoGulguQvKJ6WUhy6U8IZq06DWEe8VJh1q/r
         rhKBUDuK0aYsXiJfwntmcIL/2oqtBP2ImRlYKpOUaxefGMUGNz+qLr/GfWlPreURsZDM
         j57QwEpbiHjQSYXwWTNG2LHD6+xyyK7M+OEMFKi0sZ89MJrV3ulYd8coCowlm4HmZKrP
         dSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692321428; x=1692926228;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rOWh71R2unsmK0j18LXUVFqJ8OAoWTJeI+ndUPvXeI=;
        b=dtsKscvVJoh5jmvQ/fkPxXknWBuL/O1JNs6wo1099V+cKd2GGPhVqwlVT4+k+PhTix
         4KD3rLBAhIiVp7hJImFHcss3OP9aWl991rkVuE9VxPpcR7NJFKDJzHXyakIZ9wmG56G/
         zwbpjc2bkk2gaGIergrkoarV4NKhDuY/CjXhHqhQS6kVQBTfhTnSqPkNnL4vA43NpOgX
         K5XvIKvJYx2/SEbxeUA35ruQgact7+jIqruOvguDSs6x+AiH2KeJCD+z5y/D6TdYkWbM
         kqy2T4R/EAQ4SdBj8zQX3u9fMrLe3T2JtdJ/xTYnYjC70bhdpQ0edOuM7OOjI+lOEn4H
         9E5w==
X-Gm-Message-State: AOJu0Ywjv59kWHoMXkntYZuiJYW17vq/Gi9yNacWBpu0JV2ICOOZFn4L
        PJBPqp9Hw9jbEYwbx7DHf0vsMA==
X-Google-Smtp-Source: AGHT+IEPvuAZTF/J4BLjkzC2XooD6Ry1mwWHeucKb32CCzjPzbPPVJ6IH03SeRCWu7Un32tb1Uy72w==
X-Received: by 2002:a17:902:e54b:b0:1bf:349f:b85c with SMTP id n11-20020a170902e54b00b001bf349fb85cmr970086plf.1.1692321428716;
        Thu, 17 Aug 2023 18:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001b890009634sm391358pla.139.2023.08.17.18.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 18:17:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        kernel-team@meta.com, ebiggers@kernel.org,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     stable@vger.kernel.org
In-Reply-To: <20230817141615.15387-1-sweettea-kernel@dorminy.me>
References: <20230817141615.15387-1-sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v5] blk-crypto: dynamically allocate fallback profile
Message-Id: <169232142755.701491.1403250038127170415.b4-ty@kernel.dk>
Date:   Thu, 17 Aug 2023 19:17:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 17 Aug 2023 10:15:56 -0400, Sweet Tea Dorminy wrote:
> blk_crypto_profile_init() calls lockdep_register_key(), which warns and
> does not register if the provided memory is a static object.
> blk-crypto-fallback currently has a static blk_crypto_profile and calls
> blk_crypto_profile_init() thereupon, resulting in the warning and
> failure to register.
> 
> Fortunately it is simple enough to use a dynamically allocated profile
> and make lockdep function correctly.
> 
> [...]

Applied, thanks!

[1/1] blk-crypto: dynamically allocate fallback profile
      commit: cc7de17e2fe6b778a836032e7e5f9991dec40a25

Best regards,
-- 
Jens Axboe



