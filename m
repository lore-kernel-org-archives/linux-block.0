Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9030 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbcIOO3o (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 10:29:44 -0400
Date: Thu, 15 Sep 2016 10:40:51 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, tglx@linutronix.de, agordeev@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: blk-mq: allow passing in an external queue mapping V3
Message-ID: <20160915144050.GD16556@localhost.localdomain>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 14, 2016 at 04:18:46PM +0200, Christoph Hellwig wrote:
> This series is the remainder of the earlier "automatic interrupt affinity for
> MSI/MSI-X capable devices" series, and make uses of the new irq-level
> interrupt / queue mapping code in blk-mq, as well as allowing the driver
> to pass in such a mask obtained from the (PCI) interrupt code.  To fully
> support this feature in drivers the final third in the PCI layer will
> be needed as well.

Thanks, this looks good and tests successfully on my hardware.

For the series:

Reviewed-by: Keith Busch <keith.busch@intel.com>
