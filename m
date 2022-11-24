Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7CFC433FE
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 13:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiKXNmq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Nov 2022 08:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiKXNmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 08:42:44 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869E193C5
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 05:42:42 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g5so1410976pjd.4
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 05:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1jGmBYO2coIk+YiWgjLEKdQpFEQM8fxdl9zq3nflQ8=;
        b=mZmuA5ykdap1VPPXgdZWkfHcGR1yDXZDK519UlkWAibZe0vMYC/2Ed5ZRP1W8em1xb
         XvmrxJfO87J51qvyC98sgSuWeI+8/QSlkLYgxY4V82loPw1D2lEq1eCAHw1JSfiJ8vJl
         PojrvB5+c1tyQovvUneLF+TgXqx96Hdh0uJhIjscoajXwxPfpnjzJBSa5uL0Z6ecBobC
         MV0m7irDL7HthJwh0T3hSQSOrCABYCeb+ZaqxR3iIHrn03DL8ZCc4rEJYfzShmbxabsk
         M9lc0Y4vjNlqio0FUkHSFdSvfLKSQIw3MoRHh+6R8dB2BKRkvaO6bOrdklI/oGCk9ooT
         iGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1jGmBYO2coIk+YiWgjLEKdQpFEQM8fxdl9zq3nflQ8=;
        b=UZDqUpqCJPcXdfAdjNOjCn3fDZT/p7Ye3aMYYQuS7I19wuL5KsuvK0mv9AvbwyD74O
         yJpdyPHHQzEF7eUOCYMBhhZonVRAmfapNE8t0jCsJRxKqDzdInEZUJ+8xxs+i5zxDgq3
         no+GvYW+r3sE3kBF3/PtS/tS1HP8fL7KN3riTcmN1fdQZpYQamVIdNz+E7y0RBzlE+O7
         rUNrubfRGCcLiR11YPVFNOP3aecilWC9EiglXfGkqTfDnUvnUMxwPrexWNo045y5aNFC
         JovaYyVvkWt+PLJsFuAl7fDxwVKU33swPxqbkWIcqMq3eU6w/yS7ctowHKgcVeAwBxQ2
         IjFA==
X-Gm-Message-State: ANoB5pla6mKnwillMoTRUv+M6qWjSXV0CzhBl4myF1QFb9wsDF4g6eq2
        72lBVT2FbRpMf7e7bZSKlrDugA==
X-Google-Smtp-Source: AA0mqf5hOVm39dvfhv/TonnoKs+8s/v7Amp1bDadVoB6yXnkfrdiTPgHpIHr1RwzBEljJMxjj31KfQ==
X-Received: by 2002:a17:90a:9bcb:b0:206:f02a:cb4b with SMTP id b11-20020a17090a9bcb00b00206f02acb4bmr35694797pjw.159.1669297362019;
        Thu, 24 Nov 2022 05:42:42 -0800 (PST)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id t3-20020a6549c3000000b00477bdc1d5d5sm1080592pgs.6.2022.11.24.05.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 05:42:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     christoph.boehmwalder@linbit.com, linux-block@vger.kernel.org,
        liwei391@huawei.com, lars.ellenberg@linbit.com,
        drbd-dev@lists.linbit.com
In-Reply-To: <20221124015817.2729789-1-bobo.shaobowang@huawei.com>
References: <20221124015817.2729789-1-bobo.shaobowang@huawei.com>
Subject: Re: [PATCH v4 0/2] drbd bugfix and cleanup.
Message-Id: <166929736095.99094.10688536519822817206.b4-ty@kernel.dk>
Date:   Thu, 24 Nov 2022 06:42:40 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 24 Nov 2022 09:58:15 +0800, Wang ShaoBo wrote:
> drbd bugfix and cleanup.
> 
> v4:
>   - solve conflict in applying patch [2/2] to for-6.2/block branch
> 
> v3:
>   - add out_* label for destroy_workqueue().
> 
> [...]

Applied, thanks!

[1/2] drbd: remove call to memset before free device/resource/connection
      commit: 6e7b854e4c1b02dba00760dfa79d8dbf6cce561e
[2/2] drbd: destroy workqueue when drbd device was freed
      commit: 8692814b77ca4228a99da8a005de0acf40af6132

Best regards,
-- 
Jens Axboe


