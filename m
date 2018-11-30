Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FFAC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5A920863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5A920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725749AbeLAJdQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:33:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeLAJdP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 04:33:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D29E307D866;
        Fri, 30 Nov 2018 22:22:29 +0000 (UTC)
Received: from localhost (unknown [10.16.197.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7FB56012E;
        Fri, 30 Nov 2018 22:22:25 +0000 (UTC)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 0/6] per-cpu in_flight counters for bio-based drivers
Date:   Fri, 30 Nov 2018 17:22:20 -0500
Message-Id: <20181130222226.77216-1-snitzer@redhat.com>
In-Reply-To: <20181128004211.368810060@debian.vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 30 Nov 2018 22:22:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This v2 the product of more thorough review and testing (on my part)
of Mikulas' original patchset.

Not seeing a major performance win in general but no loss either.  DM
devices do see a huge boost in IOPS thanks to being able to eliminate
the inefficient md->pending IO accounting that it was doing, see:
https://www.redhat.com/archives/dm-devel/2018-November/msg00415.html

Happy to iterate on this patchset further as needed, all
review/suggestions are very much appreciated.

Thanks,
Mike

Mike Snitzer (1):
  dm rq: leverage blk_mq_queue_busy() to check for outstanding IO

Mikulas Patocka (5):
  dm: dont rewrite dm_disk(md)->part0.in_flight
  block: delete part_round_stats and switch to less precise counting
  block: switch to per-cpu in-flight counters
  block: return just one value from part_in_flight
  dm: remove the pending IO accounting

 block/bio.c               | 28 ++++++++++++++++----
 block/blk-core.c          | 67 +++++------------------------------------------
 block/blk-merge.c         |  3 +--
 block/blk-mq.c            | 12 ++++-----
 block/blk-mq.h            |  3 +--
 block/genhd.c             | 59 +++++++++++++++++++++++------------------
 block/partition-generic.c | 10 +++----
 drivers/md/dm-core.h      |  2 --
 drivers/md/dm-rq.c        |  9 +++----
 drivers/md/dm.c           | 36 +++++++++++--------------
 include/linux/genhd.h     | 13 +++++----
 11 files changed, 98 insertions(+), 144 deletions(-)

-- 
2.15.0

