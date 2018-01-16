Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:11220 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeAPBKd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 20:10:33 -0500
Date: Mon, 15 Jan 2018 18:13:45 -0700
From: Keith Busch <keith.busch@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
        lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [LSF/MM TOPIC] blk-mq priority based hctx selection
Message-ID: <20180116011345.GB32369@localhost.localdomain>
References: <20180115163952.GB26120@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180115163952.GB26120@cmpxchg.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For the storage track, I would like to propose a topic for differentiated
blk-mq hardware contexts. Today, blk-mq considers all hardware contexts
equal, and are selected based on the software's CPU context. There are
use cases that benefit from having hardware context selection criteria
beyond which CPU a process happens to be running on.

One example is exlusive polling for the latency sensitive use cases.
Mixing polled and non-polled requests into the same context loses part of
the benefit when interrupts unnecessarilly occur, and coalescing tricks
to mitigate this have undesirable side effects during times when
HIPRI commands are not issued.

Another example is for hardware priority queues, where not all command
queues the hardware provides may be equal to another. Many newer storage
controllers provide such queues with different QoS guarantees, and Linux
currently does not make use of this feature.

The talk would like to discuss potential new blk-mq APIs needed for
a block driver to register its different priority queues, changes to
blk-mq hwctx selection, and implications for low level drivers that
utilize IRQ affinity to set up current mappings.

Thanks,
Keith
