Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D7DC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627C320989
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXWkkbK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627C320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeLEUYg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:24:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34297 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLEUYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 15:24:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id a132so12710411qkg.1
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 12:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=cpburX7QYbxwsZAEzmCUGggkIuIFfAnxMAXHW5dlgL4=;
        b=qXWkkbK0wYPPKdMvk+o8thD+6vuA7nQTZ2ALtn5ZG6iu5VGnfQp0bnYihx6s1umcRm
         vHJTjndEpXCKfPTZyyJ2py8Yy4cT7okUZdSISS/UUwc+2MHnUhAEMaljas6hBwK+OPNQ
         D6NCPvjQiBjOSmRjKHtsTMxobgwYtlXlNF7mpNfmdvCjpvFv2YWyOeC5USuIPVbnoKjf
         wyB0mQATC0V3P+sb8ssAM5ia0k4PbCurudyGLvh5P2s4y1ED1FfTPTuGOHQsoFsFgI10
         zekuJHF/U3Qk1XaS7BSuh42yumxoVRpjiriVmRm8B+fLQjxqAGBiq7HLtlfpTfkmK1mt
         MHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=cpburX7QYbxwsZAEzmCUGggkIuIFfAnxMAXHW5dlgL4=;
        b=L1kMIU3IrhUeNSFYdb1kH7RA+B/eEsmjDEyKSq85ntk+bdTZ/OiK4KPDqhWuyxrDtW
         IE8ojBHxnHzEN0BthctANBv+sYZ5oKfPf39swOgCBB9mEHxwX64h+MFE0UJHXnl0Oc1D
         gvzZuUER1Pc4wDhmMKefkMIfS+T7NFGlDDVG7gtiwR8yk7t6P9MH9dH0kQ9mzs9V4tU1
         +bu9f9ZfYpDOZA+Z4GCssvm1rOCiy1B0utqVxmgf6bXfH9Jlo5wCng8hl8Zn3VH/DolX
         /dFjE0mUcs18rqKpFGWjyhEznq6HJnjD/rzDcSpeiOGIZGHoh1J32QdO/hF7+vUhHLbg
         +OvA==
X-Gm-Message-State: AA+aEWYajIz7tvIQEy6vHm/a8SfgxUShKUP5Jt0uFixxEBOWhGr++z1h
        2gXiegPRRrP5QXend84QaPM=
X-Google-Smtp-Source: AFSGD/Wil5U/LGnseJ5DlFxS84dgTZ3NQJbgwTr2w+h6pk5BvYcIuxzEFqKNW3j/1S7oTooW4eHtoQ==
X-Received: by 2002:a37:268b:: with SMTP id m11mr23336021qkm.131.1544041475601;
        Wed, 05 Dec 2018 12:24:35 -0800 (PST)
Received: from localhost (pool-68-160-144-192.bstnma.fios.verizon.net. [68.160.144.192])
        by smtp.gmail.com with ESMTPSA id e4sm12919171qka.31.2018.12.05.12.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:24:34 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 0/7] per-cpu in_flight counters for bio-based drivers
Date:   Wed,  5 Dec 2018 15:24:26 -0500
Message-Id: <20181205202433.95823-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This v3 adds "block: stop passing 'cpu' to all percpu stats methods"
before switching over to percpu counters.

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

 block/bio.c               | 36 ++++++++++++++----
 block/blk-core.c          | 80 ++++++---------------------------------
 block/blk-merge.c         |  4 +-
 block/blk-mq.c            | 12 +++---
 block/blk-mq.h            |  3 +-
 block/genhd.c             | 61 ++++++++++++++++++-----------
 block/partition-generic.c | 10 ++---
 drivers/md/dm-core.h      |  2 -
 drivers/md/dm-rq.c        |  9 ++---
 drivers/md/dm.c           | 36 ++++++++----------
 drivers/md/md.c           |  7 ++--
 include/linux/genhd.h     | 33 ++++++++--------
 12 files changed, 125 insertions(+), 168 deletions(-)

-- 
2.18.0

