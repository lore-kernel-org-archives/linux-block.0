Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F18FC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5DA20838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T05NLasS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5DA20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLFQl1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:41:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39555 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeLFQl1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:41:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so686924qkh.6
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=dDKxzRufLq2l/KUcjLYGwNn+V+t9xfDaF13eY9VsG18=;
        b=T05NLasS8PeE7g5vc0QigIvQtR31DMFVSNRDO14UxowSgsthj1wfGp0VHvbDDswuvN
         Jga/dHwl61OvIbhh37gDyXaywbDPNiFnNhIYH0qawXHiIy7kc057O9xA3FSeRboKp4zi
         Q7j8MUBKC3vFGEMoHiTHWrhlA0LdjvwtDtoPu0NhZzBfYWKh6U9c9m7l2zuhAjxdyDZ8
         ZCg3RqOEICJ4N0keYRag+LdSZjNJ67bFqUm8YnlI9i0LWszEUcoskDKJQ+Jired8NVkH
         h6Uam428U8jMq7kqfQ93EsJNy/lrxY24AkIn9hMglUsWSM3CndlhNyOVA+jkoWXFrC4I
         TLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=dDKxzRufLq2l/KUcjLYGwNn+V+t9xfDaF13eY9VsG18=;
        b=s1Wxm620S1WJzqPzJlPjO1y53EDw15hgxg9BvxUKK6/VgeCNUnqA0J+d0JIv3vkVB6
         H6/zee+LRN792jgw51t69lvRE3XOrvpXP8g7JDyK8n9X43z3bfv0GwbQxvNhkPn5TIYC
         hzy6horZIcvTLFmkeJUACHIF8uWOBygsa+BXS2ap52Ka1fbcQC7gCGfSkxGJvLmdFkSq
         KOYwy/0DEeTktqappmtcQ64eSY9RiUomfUC/2rlIGkIUAPeVh+DvoWY6N2rRj532TxBI
         bJrVNULM6XiNRcNo/nQ4K1GcPl8AP1+J+0zQ91OiKgF0MrgVvvwHokkeqCJXf0Y4H/Ca
         UCnQ==
X-Gm-Message-State: AA+aEWY31RgZQubkQrWYhLoOcfcIEhfXkHHk1g5Vwp6XcBAWls00k0KY
        KLD411pV8NBN3x4+Znr01PY=
X-Google-Smtp-Source: AFSGD/W17mz4S53yZKKuqpQH//ve0SsuQHHHY2UBVtKTt4sK+JAV70LT19TkcodD1yLykQZxIBDL8Q==
X-Received: by 2002:a37:34d0:: with SMTP id b199mr26373292qka.284.1544114486120;
        Thu, 06 Dec 2018 08:41:26 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z30sm588863qtz.26.2018.12.06.08.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:41:24 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v4 0/7] per-cpu in_flight counters for bio-based drivers
Date:   Thu,  6 Dec 2018 11:41:15 -0500
Message-Id: <20181206164122.2166-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey,

This v4 addresses the compile issues on various archs when CONFIG_SMP
isn't set (by introducing appropriate wrappers in genhd.h)

Testing with this v4 I was unable to reproduce the issue you reported
where iostat always reports 0 for avgqu-sz -- but please let me know
if you still see problems like that.

Thanks,
Mike

Mike Snitzer (2):
  dm rq: leverage blk_mq_queue_busy() to check for outstanding IO
  block: stop passing 'cpu' to all percpu stats methods

Mikulas Patocka (5):
  dm: dont rewrite dm_disk(md)->part0.in_flight
  block: delete part_round_stats and switch to less precise counting
  block: switch to per-cpu in-flight counters
  block: return just one value from part_in_flight
  dm: remove the pending IO accounting

 block/bio.c               | 36 ++++++++++++++++-----
 block/blk-core.c          | 80 +++++++----------------------------------------
 block/blk-merge.c         |  4 +--
 block/blk-mq.c            | 12 +++----
 block/blk-mq.h            |  3 +-
 block/genhd.c             | 55 ++++++++++++++++++--------------
 block/partition-generic.c | 10 ++----
 drivers/md/dm-core.h      |  2 --
 drivers/md/dm-rq.c        |  9 +++---
 drivers/md/dm.c           | 36 +++++++++------------
 drivers/md/md.c           |  7 ++---
 include/linux/genhd.h     | 55 +++++++++++++++++++-------------
 12 files changed, 137 insertions(+), 172 deletions(-)

-- 
2.15.0

