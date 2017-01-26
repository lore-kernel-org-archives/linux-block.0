Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60801 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753437AbdAZTs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 14:48:28 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <bart.vanassche@sandisk.com>, <hch@lst.de>, <osandov@fb.com>,
        <paolo.valente@linaro.org>, <hare@suse.com>
Subject: [PATCH 0/5] blk-mq: various blk-mq/blk-mq-sched fixes
Date: Thu, 26 Jan 2017 12:48:13 -0700
Message-ID: <1485460098-16608-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I've been diving into the problems that Hannes reported, both the
stalls related to shared tag maps and multiple hardware queues,
but also the cases where we get suboptimal merging.

This series attempts to fix that.

Hannes, this should be identical to what I sent you as a bundled up
patch earlier today. Would be great if you could run this through
your testing.

The patches are against for-4.11/block

