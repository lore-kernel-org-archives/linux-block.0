Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933878AbeAOQEJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 11:04:09 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] genirq/affinity: try to make sure online CPU is assgined to irq vector
Date: Tue, 16 Jan 2018 00:03:43 +0800
Message-Id: <20180115160345.2611-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

These two patches fixes IO hang issue reported by Laurence.

84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
may cause one irq vector assigned to all offline CPUs, then this vector
can't handle irq any more.

The 1st patch moves irq vectors spread into one function, and prepares
for the fix done in 2nd patch.

The 2nd patch fixes the issue by trying to make sure online CPUs assigned
to irq vector.


Ming Lei (2):
  genirq/affinity: move irq vectors spread into one function
  genirq/affinity: try best to make sure online CPU is assigned to
    vector

 kernel/irq/affinity.c | 77 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 25 deletions(-)

-- 
2.9.5
