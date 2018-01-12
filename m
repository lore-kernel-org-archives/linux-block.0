Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932625AbeALCxr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jan 2018 21:53:47 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-mq: support physical CPU hotplug
Date: Fri, 12 Jan 2018 10:53:04 +0800
Message-Id: <20180112025306.28004-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This two patches support physical CPU hotplug, so that we can make blk-mq
scale well when new physical CPU is added or removed, and this use case
is normal for VM world.

Also this patchset fixes the following warning reported by Christian
Borntraeger:

	https://marc.info/?l=linux-block&m=151092973417143&w=2

Christoph Hellwig (2):
  genirq/affinity: assign vectors to all possible CPUs
  blk-mq: simplify queue mapping & schedule with each possisble CPU

 block/blk-mq.c        | 19 ++++++++-----------
 kernel/irq/affinity.c | 30 +++++++++++++++---------------
 2 files changed, 23 insertions(+), 26 deletions(-)

-- 
2.9.5
