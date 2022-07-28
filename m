Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D677C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 12:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbiG1Mjo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 08:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiG1Mjo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 08:39:44 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC3A6BD40
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 05:39:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VKfiKOB_1659011970;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VKfiKOB_1659011970)
          by smtp.aliyun-inc.com;
          Thu, 28 Jul 2022 20:39:39 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     ZiyangZhang@linux.alibaba.com, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Subject: [PATCH V4 0/2] ublk: add support for UBLK_IO_NEED_GET_DATA
Date:   Thu, 28 Jul 2022 20:39:14 +0800
Message-Id: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

1. Introduction:
UBLK_IO_NEED_GET_DATA is a new ublk IO command. It is designed for a user
application who wants to allocate IO buffer and set IO buffer address
only after it receives an IO request from ublksrv. This is a reasonable
scenario because these users may use a RPC framework as one IO backend
to handle IO requests passed from ublksrv. And a RPC framework may
allocate its own buffer(or memory pool).

This new feature (UBLK_F_NEED_GET_DATA) is optional for ublk users.
Related userspace code has been added in ublksrv[1] as one pull request.

We have add some test cases in ublksrv and all of them pass. The
performance result shows that this new feature does bring additional
latency because one IO is issued back to ublk_drv once again to copy data
from bio vectors to user-provided data buffer.

2. Background:
For now, ublk requires the user to set IO buffer address in advance(with
last UBLK_IO_COMMIT_AND_FETCH_REQ command)so the user has to
pre-allocate IO buffer.

For READ requests, this work flow looks good because the data copy
happens after user application gets a cqe and the kernel copies data.
So user application can allocate IO buffer, copy data to be read into
it, and issues a sqe with the newly allocated IO buffer.

However, for WRITE requests, this work flow looks weird because
the data copy happens in a task_work before the user application gets one
cqe. So it is inconvenient for users who allocates(or fetch from a
memory pool)buffer after it gets one request(and know the actual data
size). For these users, they have to memcpy from ublksrv's pre-allocated
buffer to their internal buffer(such as RPC buffer). We think this
additional memcpy could be a bottleneck and it is avoidable.

2. Design:
Consider add a new feature flag: UBLK_F_NEED_GET_DATA.

If user sets this new flag(through libublksrv) and pass it to kernel
driver, ublk kernel driver should returns a cqe with
UBLK_IO_RES_NEED_GET_DATA after a new blk-mq WRITE request comes.

A user application now can allocate data buffer for writing and pass its
address in UBLK_IO_NEED_GET_DATA command after ublk kernel driver returns
cqe with UBLK_IO_RES_NEED_GET_DATA.

After the kernel side gets the sqe (UBLK_IO_NEED_GET_DATA command), it
now copies(address pinned, indeed) data to be written from bio vectors
to newly returned IO data buffer.

Finally, the kernel side returns UBLK_IO_RES_OK and ublksrv handles the
IO request as usual.The new feature: UBLK_F_NEED_GET_DATA is enabled on
demand ublksrv still can pre-allocate data buffers with task_work.

3. Evaluation:
Related userspace code and tests have been added in ublksrv[1] as one
pull request. We evaluate performance based on this PR.

We have tested write latency with:
  (1)  No UBLK_F_NEED_GET_DATA(the old commit) as baseline
  (2)  UBLK_F_NEED_GET_DATA enabled/disabled
on demo_null and demo_event of newest ublksrv project.

Config of fio:bs=4k, iodepth=1, numjobs=1, rw=write/randwrite, direct=1,
ioengine=libaio.

Here is the comparison of lat(usec) in fio:

demo_null:
write:        28.74(baseline) -- 28.77(disable) -- 57.20(enable)
randwrite:    27.81(baseline) -- 28.51(disable) -- 54.81(enable)

demo_event:
write:        46.45(baseline) -- 43.31(disable) -- 75.50(enable)
randwrite:    45.39(baseline) -- 43.66(disable) -- 76.02(enable)

Looks like:
  (1) UBLK_F_NEED_GET_DATA does not introduce additional overhead when
      comparing baseline and disable.
  (2) enabling UBLK_F_NEED_GET_DATA adds about two times more latency
      than disabling it. And it is reasonable since the IO goes through
      the total ublk IO stack(ubd_drv <--> ublksrv) once again.
  (3) demo_null and demo_event are both null targets. And I think this
      overhead is not too heavy if real data handling backend is used.

Without UBLK_IO_NEED_GET_DATA, an additional memcpy(from pre-allocated
ublksrv buffer to user's buffer) is necessary for a WRITE request.
However, UBLK_IO_NEED_GET_DATA does bring addtional syscall
(io_uring_enter). To prove the value of UBLK_IO_NEED_GET_DATA, we test
the single IO latency (usec) of demo_null with:
  (1) UBLK_F_NEED_GET_DATA disabled; additional memcpy
  (2) UBLK_F_NEED_GET_DATA enabled

Config of fio:iodepth=1, numjobs=1, rw=randwrite, direct=1,
ioengine=libaio.

For block size, we choose 4k/64k/128k/256k/512k/1m. Note that with 1m block
size, the original IO request will be split into two blk-mq requests.

Here is the comparison of lat(usec) in fio:

                 2 memcpy, w/o NEED_GET_DATA     1 memcpy, w/ NEED_GET_DATA
4k-randwrite:               9.65                            10.06
64k-randwrite:              15.19                           13.38
128k-randwrite:             19.47                           17.77
256k-randwrite:             32.63                           25.33
512k-randwrite:             90.57                           46.08
1m-randwrite:               177.06                          117.26

We find that with bigger block size, cases with one memcpy w/ NEED_GET_DATA
result in lower latency than cases with two memcpy w/o NEED_GET_DATA.
Therefore, we think NEED_GET_DATA is suitable for bigger block size,
such as 512B or 1MB.

[1] https://github.com/ming1/ubdsrv

Since V3:

(1) Touch and clear UBLK_IO_FLAG_NEED_GET_DATA only when
    UBLK_F_NEED_GET_DATA is enabled.

Since V2:

(1) UBLK_IO_NEED_GET_DATA should support both built-in task_work_add() and
    io_uring_cmd_complete_in_task()

Since V1:

(1) Add tests to compare (1)2 memcpy, w/o NEED_GET_DATA and (2)1 memcpy,
    w/ NEED_GET_DATA to show value of UBLK_IO_NEED_GET_DATA.
(2) rebase on the newest version of ublk_drv

ZiyangZhang (2):
  ublk_cmd.h: add one new ublk command: UBLK_IO_NEED_GET_DATA
  ublk_drv: add support for UBLK_IO_NEED_GET_DATA

 drivers/block/ublk_drv.c      | 106 ++++++++++++++++++++++++++++++----
 include/uapi/linux/ublk_cmd.h |  18 ++++++
 2 files changed, 112 insertions(+), 12 deletions(-)

-- 
2.34.1

