Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F080CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F4E2053B
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409570AbfJYQu0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:50:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33483 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409568AbfJYQuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:50:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id c184so1959774pfb.0
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 09:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syNrOfb9Q7f5mhuUJblvs9iqQxdsYjyJP048Bqy1Znw=;
        b=cLPm4gbMW278Bm5lspfi5gq/lQWMsJTGINgLuRupVXovboa0O2bNBTUtITEgdCX+LZ
         Syhxa4PWDVr3AD/QHzfAQiGn6nAxh/W2m52FaPsdQXB9np/IGw1RcFIIn71B8gfFPtws
         OsGXhWVLoFfpfLo3rQZ4HtXjQVFjqAmev8jOIrPBPTUADt3aNs9eu8wKxYXfwzQ9gaLc
         1U45SB77ZfBECjuEetXbZZkXIL76KgewsCR3wcQ2TKIhHlBFX35cX6YbnBLMh1mVaICz
         PxalIEsP+MLSgC582y1ya44E7ONgTQUg1P1KdMKm82/6Nt4k0m7nXsrCCs6W9my/l9Aa
         mqQg==
X-Gm-Message-State: APjAAAUjsVWmLRHQvRYgwSUe0D60ezzrm7/q8yfg1yhhT3pcBQXyQyiM
        8jb/qHxy1qsjeWmbcPBIlTHTz/b9
X-Google-Smtp-Source: APXvYqzG1wpWxiK20p/eGGtwn4nZq35Q5dXSIIHdEft5H9rLmXh2o5P3XZy4fn02lsVDGFR/fR85Kg==
X-Received: by 2002:a65:6898:: with SMTP id e24mr5596139pgt.358.1572022218087;
        Fri, 25 Oct 2019 09:50:18 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c8sm4088158pfi.117.2019.10.25.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:50:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] Reduce the amount of memory required for request queues
Date:   Fri, 25 Oct 2019 09:50:07 -0700
Message-Id: <20191025165010.211462-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series reduces the amount of memory required for request queues
and also includes a patche that is the result of reviewing code related
to the modified code. Please consider these patches for kernel version v5.5.

Thanks,

Bart.

Changes compared to v1:
- Dropped the blk_poll() patch from this series.

Bart Van Assche (3):
  block: Remove the synchronize_rcu() call from
    __blk_mq_update_nr_hw_queues()
  block: Reduce the amount of memory required per request queue
  block: Reduce the amount of memory used for tag sets

 block/blk-mq.c | 75 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 28 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

