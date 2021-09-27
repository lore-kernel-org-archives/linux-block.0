Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6EEC433FE
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F76A610E8
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbhI0WFZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:05:25 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:54864 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237859AbhI0WFO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:05:14 -0400
Received: by mail-pj1-f46.google.com with SMTP id me1so13446213pjb.4
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWPDIqUc0l0F8dGvfUPkfQYdLuhLXoQm0wENyPTxnUc=;
        b=2V67yR8Rdoag0Y17HCT9SPZjC+g1C6BkliXOGqXsU4SYt5MeYepzOwJcWbdMgEFMuA
         2jLXyi1vb9HCAJlBC4fjorc1mpjh70KFyAl24glTeRr0i1EJWKUqyeJl0gD8ZfkJsFU6
         fFWluSSLMOjbMpgusAYIWYssSpr4G0VhZw6WAzbj5jZHODwg6sLp82g4roIZAoWGunpE
         TkcduIaXbc8oOpyQhOUwO2b9NRvWqv88IaiVtI+xddUYqkiWLTMGwXaIOK4+AWXND560
         fqZveDU0j9MKO7rT4BALl3xaxZiyg3u9N1brXEpeL1YZn9pu4wyWUEJ7Xfn2HGOP5XmV
         Qhbw==
X-Gm-Message-State: AOAM532oGEXxyYbD4K9pQxaDpQKXFL1kOFj4BaD/C6a48utKX54Uez64
        YDaR+RFFViwlFevWQK8vI6k=
X-Google-Smtp-Source: ABdhPJzs+1qT6xtzzlFoAJFxIdei9uzw2DnV7E4SPydXl2txdu9ztaSXJft9h8l+t+MaQjQ/3alfRw==
X-Received: by 2002:a17:902:8a8c:b0:13e:45bc:e9a9 with SMTP id p12-20020a1709028a8c00b0013e45bce9a9mr341692plo.11.1632780215920;
        Mon, 27 Sep 2021 15:03:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3e98:6842:383d:b5b2])
        by smtp.gmail.com with ESMTPSA id y13sm381587pjm.5.2021.09.27.15.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:03:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/4] Restore I/O priority support in the mq-deadline scheduler
Date:   Mon, 27 Sep 2021 15:03:24 -0700
Message-Id: <20210927220328.1410161-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series includes the following changes compared to the v5.14-r7
implementation:
- Fix request accounting by counting requeued requests once.
- Test correctness of the request accounting code by triggering a kernel
  warning from inside dd_exit_sched() if an inconsistency has been detected.
- Switch from per-CPU counters to individual counters.
- Restore I/O priority support in the mq-deadline scheduler. The performance
  measurements in the description of patch 4/4 show that the peformance
  regressions in the previous version of this patch have been fixed. This has
  been achieved by using 'jiffies' instead of ktime_get() and also by skipping
  the aging mechanism if all queued requests have the same I/O priority.

Please consider this patch series for kernel v5.16.

Thanks,

Bart.

Changes compared to v1:
- Renamed 'aging_expire' into 'prio_aging_expire'.
- Renamed dd_dispatch_aged_requests() into dd_dispatch_prio_aged_requests().
- Adjusted a source code comment.

Bart Van Assche (4):
  block/mq-deadline: Improve request accounting further
  block/mq-deadline: Add an invariant check
  block/mq-deadline: Stop using per-CPU counters
  block/mq-deadline: Prioritize high-priority requests

 block/mq-deadline.c | 220 ++++++++++++++++++++++++++++----------------
 1 file changed, 143 insertions(+), 77 deletions(-)

