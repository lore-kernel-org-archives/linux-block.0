Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48341 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S939656AbdD1OcA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:32:00 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <ming.lei@redhat.com>, <hch@lst.de>
Subject: [PATCH v2a 0/6]: Fixup mtip32xx for scheduling
Date: Fri, 28 Apr 2017 08:31:45 -0600
Message-ID: <1493389911-19512-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since I fat-fingered the previous posting of v2, here's a v2a that
is what v2 should have been. No changes since v2, just for easier
review. Sorry about that.

To recap, changes since v1:

- Mark internal commands as REQ_OP_DRV_IN. Doesn't really matter
  what the data direction is, the important bit is that we need
  to ensure the request is seen as a passthrough.

- Remove redundant active = 1 setting in mtip_commands_active().

- Utilize blk-mq timeout infrastructure, to avoid racing with
  cleanup.

-- 
Jens Axboe
