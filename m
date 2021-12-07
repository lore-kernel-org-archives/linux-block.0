Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB0C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Dec 2021 16:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhLGQVh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbhLGQVe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Dec 2021 11:21:34 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0EFC061746
        for <linux-block@vger.kernel.org>; Tue,  7 Dec 2021 08:18:04 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id r2so14339624ilb.10
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=98f/j99AuJzhZ6H5G/BaaKmxrlUIJ+qa/P4gIH2gWOw=;
        b=se7fm4oskX7jefsflWX65qMvO6PKk5Vo6IwV/PRz7zFtyMYQE2iYOK+wEqcMZjY9o5
         S8JlXR/lfXvbuJxbpBCafNY3X9IjzakaxHaxWi+6u5yTDiqlf4xinpJGOtr+ARR4kuC/
         TUgwJYSg6a761I8ND1z2BOf3gmjtfygD2UFF5u9v53BvNAtsn4Ez9qxLVyUkyUeF6Kr4
         QcLbfhCZE3Cbb7ORBHhC0iCAx6xvBUnMhySVGFRuGoxEA9wGqsXA7ChauWsCcf9dF3yB
         s15PRFBIhzw2QiBoEHdZbNScPYUsAR+1CWyqDum1MsWOTjRcs7NN/TzPtgtrEG9sKbe1
         2GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=98f/j99AuJzhZ6H5G/BaaKmxrlUIJ+qa/P4gIH2gWOw=;
        b=vliJY6T3e9Bp5ebN/5YqGiD2v5zL1j0GeXcIgL64c912gpEif7FIMwIkikPpl3B1uI
         psng1ss3utGk2PjgaejWoQwqXVu3VF9sQnp2VNUXpRuBCnOOsWvr67KOUsL5UZK0CcCq
         OBeqCwAgrM/uGgD1reYvp6C5yoNXJ0nUuaLmw6j8cdtmMH7FwNte9insAkBwtE3Wv5tZ
         XTTTgHKHREYs+4MCa71PKfe8sCDIhxT8zvvtVL/H9spDGr2nr1nihexhEDFJdr5Z7G5e
         VlFO+C3sXv4IlRMVeHAFeNrTI51aeHPg+ORM+YxT1tm8Fxk6k0fV+f1/OWjrrlrmshI8
         e6HA==
X-Gm-Message-State: AOAM530pCVQnh3aqe7oYbyTta4loHuOpLjUDFf+RThABQm+GkNDYwwDH
        2SyuaWEc2X4Ct8UR3aCnDnpuZ6nA+2ZWox8m
X-Google-Smtp-Source: ABdhPJz111zaVwF/YHQfSDLhMEcjob8y5Likudp/zcGxdQ9NGB8pmN5q3jD2siCFohjNC35oN8G9ag==
X-Received: by 2002:a92:8751:: with SMTP id d17mr380244ilm.148.1638893883342;
        Tue, 07 Dec 2021 08:18:03 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w10sm95941ill.36.2021.12.07.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 08:18:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, kashyap.desai@broadcom.com,
        linux-kernel@vger.kernel.org, hare@suse.de, ming.lei@redhat.com
In-Reply-To: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
References: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH v2 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags
Message-Id: <163889388252.160645.10327363566878499665.b4-ty@kernel.dk>
Date:   Tue, 07 Dec 2021 09:18:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 6 Dec 2021 20:49:47 +0800, John Garry wrote:
> In [0] Kashyap reports high CPU usage for blk_mq_queue_tag_busy_iter()
> and callees for shared tags.
> 
> Indeed blk_mq_queue_tag_busy_iter() would be less optimum for moving to
> shared tags, but it was not optimum previously.
> 
> This series optimises by having only a single iter (per regular and resv
> tags) for the shared tags, instead of an iter per HW queue.
> 
> [...]

Applied, thanks!

[1/3] blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument
      (no commit info)
[2/3] blk-mq: Delete busy_iter_fn
      (no commit info)
[3/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags
      (no commit info)

Best regards,
-- 
Jens Axboe


