Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] blk-mq: two fixes about updating hw queues
Date: Thu, 27 Sep 2018 18:43:02 +0800
Message-Id: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens

This patch set fixes two defects during update hw queues.

1st patch refactor the blk-mq debugfs and sysfs register during
blk_mq_update_nr_hw_queues.

2nd patch should be able to fix the panic reported in follwing link
https://marc.info/?l=linux-block&m=153799465603723&w=2

Jianchao Wang (2)
blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues
blk-mq: fallback to previous nr_hw_queues when updating fails

block/blk-mq.c | 79 ++++++++++++++++++++++++++++++++++------------------------
1 file changed, 47 insertions(+), 32 deletions(-)

Thanks
Jianchao
