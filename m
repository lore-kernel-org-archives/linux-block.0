Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46069 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751734AbdBBQGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 11:06:18 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@osandov.com>
Subject: [PATCH 0/2] blk-mq-sched: fix put_rq_private() lock inconsistency
Date: Thu, 2 Feb 2017 09:06:11 -0700
Message-ID: <1486051573-13445-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I tested the patch I sent to Paolo yesterday, and it seems to work
fine. I broke it up into two pieces, so the functional change is
restricted to patch #2.

Basically this fixes the case where we can invoke the blk-mq-sched
put request functions in an inconsistent state. Most of the time we
invoke them without any locks held, but for the case where we get
a successful request-to-request merge on the back of a bio-to-request
merge, we can invoke it with whatever lock the scheduler held when
it called blk_mq_sched_try_merge().

-- 
Jens Axboe

