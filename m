Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB143ECAAD3
	for <linux-block@archiver.kernel.org>; Mon,  5 Sep 2022 17:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiIERp6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Sep 2022 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiIERp5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2022 13:45:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD643A4A8
        for <linux-block@vger.kernel.org>; Mon,  5 Sep 2022 10:45:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fs14so4170208pjb.5
        for <linux-block@vger.kernel.org>; Mon, 05 Sep 2022 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=fN2poczNO4P13BKJaZtYSL/rwX/e6BTTCS2EzB4E0v8=;
        b=pHUaXaSQoL8jqLEKD/XWgSZnpuFr8VhQmSopIJV2aaC52GfIUkiLfCHYQqWzMbl4GC
         +HAlFVNSK8pNncKBIi1PWDuC6W2wBLxLXIjGF5JUwSQVQnvCtFT6n+V7Ezi/drU5yzZi
         URrTGL3JNeQbS2nXEvOHeH/EN8SEKoD/ykek0+7tn34LdRJm8A/emGoFpUl5bDA1IBgj
         2k55UVuU1iVfFIiCHdaRTjygJsPFMc1UqMJfUzEDgKB4kmCYCC/lAb+lDKhxIN/SfGKX
         u0OeWJmxEMSMJeMk39ZeMC7RDUKqYcMkJFDi3LAihErbxYzSjkUJ9PMmam2Hn8N4Huhj
         qhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fN2poczNO4P13BKJaZtYSL/rwX/e6BTTCS2EzB4E0v8=;
        b=gFhj6RdSZOJLxiZmpVnvJ1jnbaz0jV3VkYW/ulMH2hE2j1TfgYxkOWeIFoMNL54ybg
         wPzOFzlmTVqtOI15Z0mRpHHQEP7uwdeRkBBEAH/JnYVRSxk+agqlOHFNVaCCYXH2wNC3
         auUPMhwsUYcJOvtKry1gC2zod/8OHmdjcLqwGus+seVmWXuinrsBvJFIwkJ0X1deSLPL
         jBy3+G/XwFIGhn5ceB8oyCy77aX/5VMlTdPvt8208E3zDoc87FKlp5I/cibc7NdF78Wf
         ykXSy8UTOwJLNuDgrb8dEc6U3XIazAyx3tVGA3Ww3obvvhZi/OW8i7NT0GmVSMS/K8GD
         0o2A==
X-Gm-Message-State: ACgBeo3cb+Er5C5KAbmeE6BLfFT4qfJIgIA5up1q/8xykewNxAqe4KP4
        U6Ud8KM/Dpk7velYxXtjk2PCRKyUrEIviQ==
X-Google-Smtp-Source: AA6agR6SjOCWjsQrJQXiTpx9Bwg3YbtybxReMeVWCNzMQ2FnK/gnc6ZukdOds0OdLdWCeNBP1oyGbA==
X-Received: by 2002:a17:90a:6305:b0:1fd:bef9:d49 with SMTP id e5-20020a17090a630500b001fdbef90d49mr20200421pjj.221.1662399955645;
        Mon, 05 Sep 2022 10:45:55 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902710c00b0016ee4b0bd60sm7797272pll.166.2022.09.05.10.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:45:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220905101950.4606-1-linmiaohe@huawei.com>
References: <20220905101950.4606-1-linmiaohe@huawei.com>
Subject: Re: [PATCH] blk-mq: remove unneeded needs_restart check
Message-Id: <166239995485.374909.15044704517203408.b4-ty@kernel.dk>
Date:   Mon, 05 Sep 2022 11:45:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 5 Sep 2022 18:19:50 +0800, Miaohe Lin wrote:
> If code reaches here, needs_restart must be true. Remove this unneeded
> needs_restart check. No functional change intended.
> 
> 

Applied, thanks!

[1/1] blk-mq: remove unneeded needs_restart check
      commit: 6d5e8d21e8997b0efa409e46db22a27b5cbba6aa

Best regards,
-- 
Jens Axboe


