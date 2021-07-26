Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D8DC4338F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 11:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B45960F22
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 11:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhGZLTZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 07:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhGZLTY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 07:19:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C84FC061757
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 04:59:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id o5so16100388ejy.2
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 04:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+PppU75xGshLW5H7gsUBdhjYLJf6CGh89hC53XLqy8=;
        b=Zvvdujhhqu34oTwywUenY9bfeQeu+CIuzd6hPHwLdQKR50w/5LHFl8rm8DIZbh4m+Q
         6pWJCFG9ALVsaKxWAlw3mexNac67gnOII527PzvHgJyZ6UJu3xiAhJ+3NTHnLEPqAr/T
         rV2CHDHq+2DekWYgI1gOtzIz775vwq2DwvCrhmfRaJ9e93xZCJC/JRJfIHghMaQvieN6
         llPlE/n5tfQAPXXhyBqpch0etQIqqa6CKxvrFBbwTgD9OqNSY0keGSw6pzrLYia3CCW3
         SalxkynxrnGqEoitdfzN2TY3WE5ULdWviHtQeMubcg+d3gzgQ39UVPLC243RFyMH8oGd
         Jc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+PppU75xGshLW5H7gsUBdhjYLJf6CGh89hC53XLqy8=;
        b=dsCGXD42if++EzpKjdWDUeis3kYveBzbvARksL0Gb2miVDBt8/oXYy1I28iw3F1N0y
         te0qrdcgs8XU+PzDYtUYtHq5AahxC8el4A3i0u299/ZH8V96NQgQhTkY/z1bqlvbdgCW
         xMghiznrN2QB4YV44hueS77tSejhSd+ctr8LOUlMRLT0fr2rzEVuptvYIOmeYdBlQKU1
         mVyqH51GeZGf5n3SqDmc167Qmf1zHXzdOAtFK3W6LaStUInel4w1f6W8n+7312uzj+qi
         hacfURnH6Jdl8Cfj+ZiZfgEj2VKG/RbNCdVD6bAILixUTCHIzmT5NFjsD+YWZkKVt3c/
         9yyQ==
X-Gm-Message-State: AOAM532eBO2xFko+NKQalnJbvl7aA3hZUlnqgkdAjgkY1HRpBqusiiVi
        SR4TWZl1iHji2L3cQRVpobEVpJV6oTOytg==
X-Google-Smtp-Source: ABdhPJwg3qJW/CisIMbMhNLkW/Z2ZoE44PTlIlUKA/QvE0ouWY7supuThYGcMpDHQNJkPRCzYj8i3w==
X-Received: by 2002:a17:906:c831:: with SMTP id dd17mr11202848ejb.143.1627300791866;
        Mon, 26 Jul 2021 04:59:51 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49ed:6f00:7449:2292:4806:d4e5])
        by smtp.gmail.com with ESMTPSA id y8sm731408eds.91.2021.07.26.04.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:59:51 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 0/2] Misc RNBD update
Date:   Mon, 26 Jul 2021 13:59:48 +0200
Message-Id: <20210726115950.470543-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please consider to include following change for next merge window.
- one fix for wrong api usage.
- one sysfs_emit conversion for sysfs access.

Regards!

Gioh Kim (1):
  block/rnbd-clt: Use put_cpu_ptr after get_cpu_ptr

Md Haris Iqbal (1):
  block/rnbd: Use sysfs_emit instead of s*printf function for sysfs show

 drivers/block/rnbd/rnbd-clt-sysfs.c | 33 +++++++++++++----------------
 drivers/block/rnbd/rnbd-clt.c       |  2 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c | 14 ++++++------
 3 files changed, 23 insertions(+), 26 deletions(-)

-- 
2.25.1

