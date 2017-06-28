Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:49670 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbdF1OP0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 10:15:26 -0400
Date: Wed, 28 Jun 2017 16:15:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, bvanassche@acm.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        vladimirk@mellanox.com
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
Message-ID: <20170628141524.GA1894@lst.de>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 03:44:40PM +0300, Max Gurtovoy wrote:
> This patch performs sequential mapping between CPUs and queues.
> In case the system has more CPUs than HWQs then there are still
> CPUs to map to HWQs. In hyperthreaded system, map the unmapped CPUs
> and their siblings to the same HWQ.
> This actually fixes a bug that found unmapped HWQs in a system with
> 2 sockets, 18 cores per socket, 2 threads per core (total 72 CPUs)
> running NVMEoF (opens upto maximum of 64 HWQs).
> 
> Performance results running fio (72 jobs, 128 iodepth)
> using null_blk (w/w.o patch):

Can you also tests with Sagi's series to use the proper IRQ
level mapping?
