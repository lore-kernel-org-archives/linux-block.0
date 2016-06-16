Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55604 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501AbcFPPWo (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 16 Jun 2016 11:22:44 -0400
Date: Thu, 16 Jun 2016 17:22:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@fb.com,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: automatic interrupt affinity for MSI/MSI-X capable devices V2
Message-ID: <20160616152237.GB13615@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de> <b8cdfc80-fa77-b7cc-69b8-fb6037114087@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b8cdfc80-fa77-b7cc-69b8-fb6037114087@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 16, 2016 at 11:45:55AM +0200, Bart Van Assche wrote:
> Is my interpretation correct that for an adapter that supports two 
> interrupts and on a system with eight CPU cores and no hyperthreading this 
> patch series will assign interrupt vector 0 to CPU 0 and interrupt vector 1 
> to CPU 1?

Yes - same as the existing blk-mq queue distribution.

> Are you aware that drivers like ib_srp assume that interrupts 
> have been spread evenly, that means assigning vector 0 to CPU 0 and vector 
> 1 to CPU 4?

which will make them run into a conflict with the current blk-mq
assignment.  That's exactly the point why we're trying to move things
to a core location so that everyone can use the same mapping.
