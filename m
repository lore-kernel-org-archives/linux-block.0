Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F28C38142
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 18:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjAaSq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 13:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAaSq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 13:46:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E767E4A216
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 10:46:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id pj3so2231818pjb.1
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 10:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmFnKp1HO8q7aGLvan/Y18uSAg7b21OGsLdsNiQrDjo=;
        b=ojkcWALgfRsQzwgTopXw4nKTMmUs2DSRiKj7TIMfHtLo+WLgHQTBuEueCvDpnc0JVJ
         +K0YtSqMCAlnnSQkyxWP3bpzeOU5pj+BDdny8KCc8flpMrQ3oRkW2EFv0FDWpomCsieP
         NSkSAO8U9gjKgthbPq3W71o85EJI79banr08ZRJPHztnaFF+dLSX2JnbPd/UCXF3cnY3
         fHtVEkL+rhlzV9+hr3BpNahrBBQ3/BZV+BUjrKQqfrGMHXFw1S5QVx3pHmg7F46TuL4t
         rDCUzZ3DKB2Fb3w/+EBX1LqmHyO4wRqlGMX/WyrdA9CP1lTlKtHV+dZOLNGqzWwLENTy
         Wrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmFnKp1HO8q7aGLvan/Y18uSAg7b21OGsLdsNiQrDjo=;
        b=8KzYWN64SpyOMNCKn22xYYlDHVLY/V9YBK+/+QX9OLFAoM9iBMS1jIWO6kSvdPnirU
         lgZUkycXsP+p/QEaWxsaRhVbz54juxkwd12EVsVticmo1p4E935WZKermelXrSydcHFl
         Fgw27p5GvZ/+NQzR/NUltJs/qsbboNkqZgRe+6HXSYheEmzWrA4DeCxenmC0PAcdSq7F
         /dBsZ6xmbK05L2EYjyLeUAOsSrQrA7qm8FsrU/a58PWIQBpBUSMutpbBpfRSpE22jJRI
         uM0YAfyJsw2fp3YohPV62fs+PFX9E0oduqrgArGz5fjMPnUJilEd3eKvBRGbborZGG6R
         fhVA==
X-Gm-Message-State: AO0yUKXuoamUgifQiEe/ji4lojwxoTE8xtxrIVHvf5bkQLGLa3bfEHuc
        iaEEll8Ivoa1i2Ora0aVyq/fghLWPa0H9xWA
X-Google-Smtp-Source: AK7set8l3XHf4U9apgtyau/A4B/kPRWq5/fW6Zw2oY1ZcoUuK5SSxJCRjE8kgDCqYhkB++F9U7auBw==
X-Received: by 2002:a17:902:db05:b0:198:a5d9:f2fd with SMTP id m5-20020a170902db0500b00198a5d9f2fdmr1210399plx.6.1675190785159;
        Tue, 31 Jan 2023 10:46:25 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d90400b0017f756563bcsm10125545plz.47.2023.01.31.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:46:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
In-Reply-To: <20230130211233.831613-1-bvanassche@acm.org>
References: <20230130211233.831613-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Fix the blk_mq_destroy_queue() documentation
Message-Id: <167519078425.125182.15341503479385621565.b4-ty@kernel.dk>
Date:   Tue, 31 Jan 2023 11:46:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 30 Jan 2023 13:12:33 -0800, Bart Van Assche wrote:
> Commit 2b3f056f72e5 moved a blk_put_queue() call from
> blk_mq_destroy_queue() into its callers. Reflect this change in the
> documentation block above blk_mq_destroy_queue().
> 
> 

Applied, thanks!

[1/1] block: Fix the blk_mq_destroy_queue() documentation
      commit: 81ea42b9c3d61ea34d82d900ed93f4b4851f13b0

Best regards,
-- 
Jens Axboe



