Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44100 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756164AbcISNte (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 09:49:34 -0400
Date: Mon, 19 Sep 2016 15:49:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, tglx@linutronix.de,
        keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] blk-mq: provide a default queue mapping for PCI
        device
Message-ID: <20160919134932.GB28585@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de> <1473862739-15032-11-git-send-email-hch@lst.de> <20160919073313.GB31001@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160919073313.GB31001@agordeev.lab.eng.brq.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 19, 2016 at 09:33:14AM +0200, Alexander Gordeev wrote:
> Considering this code is to be used by any device - an assumption
> that queue number and interrupt vector are always equal seems
> questionable. I.e. what about non-contiguous MSI-Xs?

It's just a generic default - see the discussion with Jens in the
intro mail for the thread for anyother example that can't be handled
easily.  If we get enough devices for a given scheme we can add another
common helper, in the worst case we'll need driver code for the scheme.
