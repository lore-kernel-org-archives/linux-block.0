Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D22C7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A0120659
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="LUuP4xab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfGPUTe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:19:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37144 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPUTe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 16:19:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so20988292qto.4
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=DGHA/Ra6cSM/HqX6wIRlE75nXAiCAbGbOSBY8rLIup8=;
        b=LUuP4xabiFYcyzZFVfHeouXKki/TcVaHMECdlXBej78x7ODzhll4sfXmOqX5eVRQ0P
         g0gUPDu/wOKeAHrcMv9JqCSCfb1aDAY+FJls/AJ7GtMres7bVFEzKKmvH6a77Zs1fuqv
         awgI2p+ytq+QBDXKUWRh3Fo3wxCYU0VXQb74pNk5ftnLeLjxBqfQj7fXpxxj7c8MHA+s
         IpnBli4PM04w1kT2KUaZ0vk+SybZbB9nZpZeA7Qdaomc9xZplGUuyguWAizRC12I6yIp
         0l3gsyu+7GMNGxUyXHZ/28xxQwSq+MPvW4VZ8jZvuClhIMWCQhqGL0JfutbC060Wew6k
         NnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=DGHA/Ra6cSM/HqX6wIRlE75nXAiCAbGbOSBY8rLIup8=;
        b=BjzN3jUl0PcXLO9ZtCBl1RE2nzlgawUeHTEE1yf482TYNP0widnuX2vDCXc9B3AOl3
         WQFaOSsRfuUlYSKCiP+mxzejcbmsMHj/xqE1srbl1XXRAMwpPsuF5LZLaPdL2tmGjCge
         8fmlIERFsGgixZ5txv+x5i9kD9HkDpMYiMO/mtJbB2qU8mClkknfQkKtwc8/1vVAFFSO
         l4h2vu8Pox+9GfQ8xTXyFY8uYyMIDASfWGgWnH5Gf+qmTlvnGKgVmRJLrYZFzfLvM2fT
         2LrRyTmi7CBH2/cRJvUOAycV/V9k9o2aSOXtz0sYdbGKJnIHHQ6OUMxiGEIoVfhaBEzO
         h3KQ==
X-Gm-Message-State: APjAAAX02ES0C0EiFUDdGdjr66zUPSTi85Bw0jErm7dTGREf58GCvErI
        2eMqzrt5uloiAegLHcrjoeP6E/00Zsg=
X-Google-Smtp-Source: APXvYqxqP92A61A4W54HQ3bBTiHuHGEhIRRThkGaxPkbbNpXGr82do40RBXAfvWR1Mt3HrXGW3+ZFQ==
X-Received: by 2002:ac8:4413:: with SMTP id j19mr24352631qtn.281.1563308373616;
        Tue, 16 Jul 2019 13:19:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d7f3])
        by smtp.gmail.com with ESMTPSA id x1sm9226859qkj.22.2019.07.16.13.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:19:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 0/5][v3] rq-qos memory barrier shenanigans
Date:   Tue, 16 Jul 2019 16:19:24 -0400
Message-Id: <20190716201929.79142-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the patch series to address the hang we saw in production because of
missed wakeups, and the other issues that Oleg noticed while reviewing the code.

v2->v3:
- apparently I don't understand what READ/WRITE_ONCE does
- set ourselves to TASK_UNINTERRUPTIBLE on wakeup just in case
- add a comment about why we don't need a mb for the first data.token check
  which I'm sure Oleg will tell me is wrong and I'll have to send a v4

v1->v2:
- rename wq_has_multiple_sleepers to wq_has_single_sleeper
- fix the check for has_sleepers in the missed wake-ups patch
- fix the barrier issues around got_token that Oleg noticed
- dropped the has_sleepers reset that Oleg noticed we didn't need

Thanks,

Josef
