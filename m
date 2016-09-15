Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55693 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754122AbcIOOcK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 10:32:10 -0400
Date: Thu, 15 Sep 2016 16:32:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, tglx@linutronix.de,
        agordeev@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: blk-mq: allow passing in an external queue mapping V3
Message-ID: <20160915143202.GA26221@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de> <20160915144050.GD16556@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160915144050.GD16556@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks for all the testing and the review Keith, as well as the
fixes earlier.

Jens, what do you think of the series?

Thomas has added the first 5 patches to

https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=irq/for-block

so it would be great if we could pull that into a block branch and
get the rest into the block tree sooner or later.
