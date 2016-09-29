Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbcI2SoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2016 14:44:05 -0400
Date: Thu, 29 Sep 2016 11:44:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/6] skd: use pci_alloc_irq_vectors
Message-ID: <20160929184403.GB16811@infradead.org>
References: <1473600688-24043-1-git-send-email-hch@lst.de>
 <1473600688-24043-4-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473600688-24043-4-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 11, 2016 at 03:31:25PM +0200, Christoph Hellwig wrote:
> Switch the skd driver to use pci_alloc_irq_vectors.  We need to two calls to
> pci_alloc_irq_vectors as skd only supports multiple MSI-X vectors, but not
> multiple MSI vectors.
> 
> Otherwise this cleans up a lot of cruft and allows to a lot more common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Jens, is this something you could pick up for 4.9?  I'd like to get get
rid of all users of pci_enable_msi_range in this merge window.
