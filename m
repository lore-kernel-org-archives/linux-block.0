Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51951 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754389AbdDJP4P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 11:56:15 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <osandov@fb.com>, <hch@lst.de>, <bart.vanassche@sandisk.com>
Subject: [PATCH 0/3] blk-mq: unify hardware queue run handlers
Date: Mon, 10 Apr 2017 09:54:53 -0600
Message-ID: <1491839696-24783-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We currently have three of them, one normal work queue item, and two
delayed work queue items. The two delayed items differ in that one of
them only runs the queue it was previously stopped, that's it. The
non-delayed one is identical to the non stopped checking delayed
variant.

Sending this out for early review, as I'll be heading on vacation
shortly. This is untested, just compiled.

This shrinks the size of a hardware queue from 832 bytes (13 cachelines)
to 704 bytes (11 cachelines) on my setup. That's quite a substantial
win.

Patches are against my 4.12 branch.

-- 
Jens Axboe
