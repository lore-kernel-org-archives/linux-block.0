Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DF1C43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44A720824
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a5At+hnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44A720824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbeKXFTm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:42 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:43750 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389262AbeKXFTk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:40 -0500
Received: by mail-pl1-f170.google.com with SMTP id gn14so10963728plb.10
        for <linux-block@vger.kernel.org>; Fri, 23 Nov 2018 10:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=ZBykYjr+uWpVsUQaX3ivPEZS7AeKHKpN33X+aGrdDak=;
        b=a5At+hnHVbiUVhAaE8jAaHDKS34ls/hHn/H6XMyCSTBT95Fy9zk0GiCYaGCNahQ8Wn
         IuS3vlKCWyz2NzGMirMOYAeqUZYha+kPu2x8MefxZf/RkxTycJfa20ORO0DY2+jq0U9a
         U0fyL4dxKBW4gUVLRYuIOC9BQNGmHAdtHtP/zEA/qIvcXIgM8OsUgiNaKg+aZKx9rq8f
         rjuLtcUnpr7WEvdyzVxD8UYd3EdQ7SZz8mbPnS5Tt95TIPTs0ipaNdxLLxhb8AeSVl/N
         mcoA2CCe3LgoxqFlSGG+gr31h19Dhg9w7EkuUbvusi8wYiYESTIMaLOOVbLlS3tUH2DR
         CIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ZBykYjr+uWpVsUQaX3ivPEZS7AeKHKpN33X+aGrdDak=;
        b=ELZiamI7zeZyRg0tDZgm2rMVHWoNoYfBe8rrg7VP/bTu5VV00w0139/60/tMkPWgw9
         +cE/8Pi6pI3zKz6EPc+zTQxO6XP2XF3n+66bgB0QHjcUaxG9qwDz6OgMD0Ucw+wyuIxv
         j++HSO2T5hmaDeQS2LDfBJyDa/ROTWitwu/kZW6FHIUq+AyG2cSS8jJYRo+J/+S4u5Y2
         2UgadzrOkz9nqy8l/B5KQ7cPBt6YwBTpEA5j+IiPOVJ88Qma7pghgGjzrGWq5isRHJXU
         vb0XuUiDusn9bRKtBbbdmfy2vWbA+cPlg3g1MSAgZjI8Gu4C1mvOhLvsjLoOFBtQQiDA
         99mA==
X-Gm-Message-State: AA+aEWbYvWFLq+i4CqDh7fbwQl/MqIOB6IIEDfFRFsKL01i7W57wzkii
        W3x7LSn5vHg3eP4QKaEmpS9GsdtfLko=
X-Google-Smtp-Source: AFSGD/XUaP6NmqwpHWKuzwjiJWUy+NIyeqHTLyOtCA+YKV+sHNU8/D14KLkDH8ZB0oP5xpyzSpfwSw==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr1037854plr.56.1542998055395;
        Fri, 23 Nov 2018 10:34:15 -0800 (PST)
Received: from x1.thefacebook.com (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s37sm52294260pgm.19.2018.11.23.10.34.13
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:34:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET v4 0/6] Various block optimizations
Date:   Fri, 23 Nov 2018 11:34:05 -0700
Message-Id: <20181123183411.8708-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some of these are optimizations, the latter part is prep work
for supporting polling with aio.

Patches against my for-4.21/block branch. These patches can also
be found in my mq-perf branch, though there are other patches
sitting on top of this series (notably aio polling, as mentioned).

Changes since v3:

- Remove ->poll_queue() from nvme-fc
- Fold __nvme_rdma_recv_done() and nvme_rdma_recv_done()
- Drop merged patches
- Merge __blk_mq_poll() and blk_mq_poll()
- Add patch to never redirect polled completions

Changes since v2:

- Include polled swap IO in the poll optimizations
- Get rid of unnecessary write barrier for DIO wakeup
- Fix a potential stall if need_resched() was set and preempt
  wasn't enabled
- Provide separate mq_ops for NVMe with poll queues
- Drop q->mq_ops patch
- Rebase on top of for-4.21/block

Changes since v1:

- Improve nvme irq disabling for polled IO
- Fix barriers in the ordered wakeup for polled O_DIRECT
- Add patch to allow polling to find any command that is done
- Add patch to control whether polling spins or not
- Have async O_DIRECT mark a bio as pollable
- Don't plug for polling

-- 
Jens Axboe


