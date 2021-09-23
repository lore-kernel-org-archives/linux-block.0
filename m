Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D073C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 23:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E2C61242
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 23:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbhIWXZj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 19:25:39 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:34400 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhIWXZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 19:25:39 -0400
Received: by mail-pg1-f169.google.com with SMTP id f129so7984548pgc.1
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 16:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o506yJuFKAwdjbP7tAU5o29HdbQoaMX/fnruo9Q0654=;
        b=VfQEttJtUxoQs2xoDpBVNVkpq/NGrd2terai4q0YutmbHF03RGFJ0Wg/vVJ1oK/9sq
         9Qmz9TL4BSRmFoa4hAKp1ISc6Uly4um1A+YHeEDLOuRGuj2CumApQyz5sTB4C3x392Cz
         +OUYtUDpYuut5z+in21zuMbIg3/xuOSPzua0CSKrJZTk38VU/jAVdLe7nfU9ib8WJ38B
         go5MYWhll8rohtSfrM9MUyKq8Cz+as6yv6ZZWDNhdq9sAGRSTHh9Vw67HRL1oVCu8ewd
         NMyjDh3pwzjr47WyYog352JnbiksYgHPs/M8TzUxgqCKI/oBHBawXPTXHqn6yvxONIlC
         aZbg==
X-Gm-Message-State: AOAM531rpRDj1hhcg9uPoXBgE35/H3RJlSbLP6PkjQSorxmw+pVNeZLM
        FZlX7QYxWqebCPIWTlgJn2I=
X-Google-Smtp-Source: ABdhPJzK9ZmoDyz8ThEI6oVaL2YToP/fg6TJhblu1u+uDQpltsC7MzYbi1XDrF3kekN7Kh8iIou2pA==
X-Received: by 2002:a63:4417:: with SMTP id r23mr1125958pga.177.1632439446623;
        Thu, 23 Sep 2021 16:24:06 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:bf91:ebe7:eabf:7473])
        by smtp.gmail.com with ESMTPSA id m2sm7984387pgd.70.2021.09.23.16.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 16:24:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] Restore I/O priority support in the mq-deadline scheduler
Date:   Thu, 23 Sep 2021 16:23:54 -0700
Message-Id: <20210923232358.3907118-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series includes the following changes:
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

Bart Van Assche (4):
  block/mq-deadline: Improve request accounting further
  block/mq-deadline: Add an invariant check
  block/mq-deadline: Stop using per-CPU counters
  block/mq-deadline: Prioritize high-priority requests

 block/mq-deadline.c | 221 ++++++++++++++++++++++++++++----------------
 1 file changed, 143 insertions(+), 78 deletions(-)

