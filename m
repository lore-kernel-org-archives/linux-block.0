Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:50117 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbdGFJzI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Jul 2017 05:55:08 -0400
Date: Thu, 6 Jul 2017 12:55:04 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Christoph Hellwig <hch@infradead.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: OOPS from cciss_ioctl in 4.12+git
In-Reply-To: <20170705225134.GA31786@infradead.org>
Message-ID: <alpine.LRH.2.20.1707061236010.6514@math.ut.ee>
References: <alpine.LRH.2.20.1707051555130.20086@math.ut.ee> <20170705225134.GA31786@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> Hi Meelis,
> 
> can you try the patch below?

Yes, the OOPS is gone and everything seems to be working.

> Also we're trying to move people away from the cciss driver, can you
> check if the hpsa SCSI driver works for you as well?

I have older adapter:

Compaq Computer Corporation Smart Array 64xx [0e11:0046] (rev 01)

That does not seem to be supported by hpsa AFAICS.

-- 
Meelis Roos (mroos@linux.ee)
