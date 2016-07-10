Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41280 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378AbcGJDlr (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sat, 9 Jul 2016 23:41:47 -0400
Date: Sun, 10 Jul 2016 05:41:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@fb.com,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] blk-mq: allow the driver to pass in an affinity
	mask
Message-ID: <20160710034144.GA15720@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de> <1465934346-20648-12-git-send-email-hch@lst.de> <20160704081540.GA2783@agordeev.lab.eng.brq.redhat.com> <20160704083849.GA3585@lst.de> <20160704093527.GB2783@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160704093527.GB2783@agordeev.lab.eng.brq.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jul 04, 2016 at 11:35:28AM +0200, Alexander Gordeev wrote:
> > mq_map is initialized to zero already, so we don't really need the
> > assignment for queue 0.  The reason why this check exists is because
> > we start with queue = -1 and we never want to assignment -1 to mq_map.
> 
> Would this read better then?
> 
> 	int queue = 0;
> 
> 	...
> 
> 	/* If cpus are offline, map them to first hctx */
> 	for_each_online_cpu(cpu) {
> 		set->mq_map[cpu] = queue;
> 		if (cpumask_test_cpu(cpu, affinity_mask))
> 			queue++;

It would read better, but I don't think it's actually correct.
We'd still assign the 'old' queue to the cpu that is set in the affinity
mask.
