Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35786 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbdBFRDQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Feb 2017 12:03:16 -0500
Date: Mon, 6 Feb 2017 18:03:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Joe Korty <joe.korty@ccur.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] genirq: allow assigning affinity to present but
        not online CPUs
Message-ID: <20170206170313.GB31902@lst.de>
References: <t6NbP-2IT-5@gated-at.bofh.it> <t6NbP-2IT-13@gated-at.bofh.it> <20170204015809.GA16203@zipoli.ccur.kvm> <20170205164023.GA9281@lst.de> <20170206170304.GF24601@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206170304.GF24601@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Feb 06, 2017 at 12:03:05PM -0500, Keith Busch wrote:
> Can we use the online CPUs and create a new hot-cpu notifier to the nvme
> driver to free/reallocate as needed? We were doing that before blk-mq. Now
> blk-mq can change the number hardware contexts on a live queue, so we
> can reintroduce that behavior to nvme and only allocate what we need.

That could be a next step, but given how badly I keep messing up core
IRQ bits we'll probably want to wait for two rewrites of those bits
from Thomas before moving on :)
