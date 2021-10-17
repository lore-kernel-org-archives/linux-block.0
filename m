Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92866C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 13:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E3E61054
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 13:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbhJQNLQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242195AbhJQNLQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 09:11:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AC0C061768
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 06:09:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n7so13235177iod.0
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjTUcswak3wNQ07o/cAA8ASagn3sBBiKAFFVV9MPLGY=;
        b=MwYh/MTjBldn0NaUlbNgR+bcry9YjTzvURoZXaW+a9oo5sUUdgdqfyydnOpDdMzrKw
         U4P+chtvI/2JY1Wwxx2QVMBsxeyBFfzLmGcHGkqPn9CtbKjybaCVuQ5K9b7S+if0OMFk
         825/rIcJ3cU1iPDEnm+hWd1EZNHiXx5bkc3XwvenQ2dRefWE1Z+lggkHbJ/SFKma/K1W
         p4lPuKauOH7qYxskb7Qr4dCXf83U6YacRrhVi3s+WlZLNCfUf58w3YGmqo4Ey8GCyuKb
         QoZSprQWh/1V3VYF8WLfmWk43vD1H+XELwcA88a+JZxdjBmXAt5jgAHL3kXgHfnmq0dd
         VdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjTUcswak3wNQ07o/cAA8ASagn3sBBiKAFFVV9MPLGY=;
        b=UH9IEuOmCyY7TmkuInKmRGxQPa2PRQ3upP79pPeVDHhCZTZtQsFZ+I5OalZe/ABHTq
         PllZDnGBWYyVk0KY6FY2qZ/L6xi2FNJXHpXGPesLzXJR7lDxGtRcX9aUbqrSum1UQ0Ew
         N63FoYsIaO1AhNpCKX8QO8zMY/Au0KPEGalpUzkx0dSSTc2WScVRIeDwiR6nTjOLDnzE
         EtBDFCWfcv0kHMrtFtiS/f76IBQUI7zainNNDwjVkcG5mFrODfvgpaxmhZsWDcVeOce4
         BK/rZ81GpAOlgE/+BHWHxW6Le9Xzi4qbZdm4toYyaNhpnTi+HiwbL7PwSDUBvrtERgj3
         WizA==
X-Gm-Message-State: AOAM5329V9hfznO9+oyWJjYLJ6AXw4YUMDD8btyexExNDRd7QM0Xrfcn
        88DmzrnrKdHEfoc2Bqw60XxhiQ==
X-Google-Smtp-Source: ABdhPJzN6fYK76DGdE6l3EFetuuFFi39nbjL8hMx6HKtI6Yzsc1ASDS9Y6dYEhdQI2ysQiVvoCKnAQ==
X-Received: by 2002:a5d:9d56:: with SMTP id k22mr10556215iok.177.1634476146412;
        Sun, 17 Oct 2021 06:09:06 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k4sm5410856ilv.9.2021.10.17.06.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 06:09:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH BUGFIX 0/1] block, bfq: fix bug 214503
Date:   Sun, 17 Oct 2021 07:09:03 -0600
Message-Id: <163447613966.93968.4244205080477398010.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211015144336.45894-1-paolo.valente@linaro.org>
References: <20211015144336.45894-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 15 Oct 2021 16:43:35 +0200, Paolo Valente wrote:
> this patch fixes bug 214503 [1]. Commit 2d52c58b9c9b ("block, bfq:
> honor already-setup queue merges") has not to do with this bug, and
> can be restored.
> 
> Thanks,
> Paolo
> 
> [...]

Applied, thanks!

[1/1] block, bfq: reset last_bfqq_created on group change
      (no commit info)

Best regards,
-- 
Jens Axboe


