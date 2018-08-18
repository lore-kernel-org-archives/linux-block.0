Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:49998 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeHRMaD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Aug 2018 08:30:03 -0400
Date: Sat, 18 Aug 2018 17:22:53 +0800
From: kbuild test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kbuild-all@01.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Steve Wise <swise@opengridcomputing.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH] block: fix rdma queue mapping
Message-ID: <201808181744.BIqmnwvW%fengguang.wu@intel.com>
References: <20180817223823.19566-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817223823.19566-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Sagi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on v4.18 next-20180817]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sagi-Grimberg/block-fix-rdma-queue-mapping/20180818-103103
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> block/blk-mq-rdma.c:105:34-35: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
