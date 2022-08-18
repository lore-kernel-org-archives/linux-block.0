Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB53C00140
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 13:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbiHRNi1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244787AbiHRNi1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 09:38:27 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E9C27CD9
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 06:38:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id x64so1095511iof.1
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=8JryTZJNmVWftlwTMNbthawYc3h5N+iWyPdLImn/rhU=;
        b=ANqNZEUHI7+wP4NYhu071IcgKY/pbUo0Jc7YUGZDe5EjyYYFFTq19ZfItZNiOi9yHT
         qYWwsIg6ApohVdq8GbdRMeaejcgBpmPhbt/w45CsEK+VfDz1cRHvFQRGKqmRGsVuRFAE
         l/EnFWvqHHV/kQ3w9mdlbOBIml+B4NYIXwMQOSdffkdKSdbbWkS63wtPcP7plpOk3T/T
         gxiiRmhSd5VyoEFkG8gL7BQWRurl41qAEuHOhE8ttv11oPJGXBPiWap7k0TX1FoBhTq5
         Z7+uqHY1Pc8BTVJWlLR/ygv29g9WsJYm29GaAJgpuWoNS8kidRgCTCHza/dC/GNXYUd5
         KTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8JryTZJNmVWftlwTMNbthawYc3h5N+iWyPdLImn/rhU=;
        b=NZsgIdQtbq3VJnPkMnlmFmnvGapwBRae+GVcQEDD4A5+kkITdlx25gJ8crLct23Urr
         kU4eyT8cDP69DjsVFYPKjZoVCt9JCd6npd4FicosrYzZKlDLr3F91FSX+YQfjcJJHumD
         bX8SpFp233yB4/HHDU2VhUDDTE1s8D31dca1OH0qPfyWUa1TXbQ/PA8URJ+P6aQEpcO+
         vJvUFzBLzYwHInHA4QuSj0d7cmaGw+2w25Omwx05J+HuD89fTZFzT8qq5WhrCUhvr8tX
         QV5QPgP5BJHGqwrLMpCzbItrEBwGgPF3PK2dM0AW3NLyjI8lkpGc8uOF8mtMb0ARNr31
         YUfQ==
X-Gm-Message-State: ACgBeo0MVB5z5oAXGXuwZOWhkn1lMQsH9cn/X041KQpOFv3OyG6CxyFP
        d5dyzNC5EkV0VhcBj48s2V/Khw==
X-Google-Smtp-Source: AA6agR5GO6dK3qh5UFIJI0QSIsZKPHlzjRYAMGhwn/k21OENaC9qZYx7DI7DYUIuf04jS3IvLjKoGw==
X-Received: by 2002:a05:6638:2708:b0:346:8b3d:c18e with SMTP id m8-20020a056638270800b003468b3dc18emr1448630jav.272.1660829903737;
        Thu, 18 Aug 2022 06:38:23 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b16-20020a05663801b000b0034602e741f0sm629071jaq.67.2022.08.18.06.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:38:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yukuai1@huaweicloud.com
Cc:     yukuai3@huawei.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, linux-block@vger.kernel.org
In-Reply-To: <20220818063555.3741222-1-yukuai1@huaweicloud.com>
References: <20220818063555.3741222-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] blk-mq: remove unused function blk_mq_queue_stopped()
Message-Id: <166082990303.8966.13019066479952675350.b4-ty@kernel.dk>
Date:   Thu, 18 Aug 2022 07:38:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 18 Aug 2022 14:35:55 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> blk_mq_queue_stopped() doesn't have any caller, which was found by
> code coverage test, thus remove it.
> 
> 

Applied, thanks!

[1/1] blk-mq: remove unused function blk_mq_queue_stopped()
      commit: a8239f0342bae5a51acca967ba95b9a8ad56dd62

Best regards,
-- 
Jens Axboe


