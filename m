Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52909 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1423455AbdD1OCH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:02:07 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>
Subject: [PATCH v2 0/6] Fixup mtip32xx for scheduling
Date: Fri, 28 Apr 2017 08:01:49 -0600
Message-ID: <1493388117-15185-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Round two of this patchset to cleanup. Changes since the first
posting:

- Mark internal commands as REQ_OP_DRV_IN. Doesn't really matter
  what the data direction is, the important bit is that we need
  to ensure the request is seen as a passthrough.

- Remove redundant active = 1 setting in mtip_commands_active().

- Utilize blk-mq timeout infrastructure, to avoid racing with
  cleanup.

-- 
Jens Axboe
