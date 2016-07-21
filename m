Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44534 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbcGUFyd (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 21 Jul 2016 01:54:33 -0400
Date: Wed, 20 Jul 2016 22:54:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Mike Snitzer <snitzer@redhat.com>, dm-devel-redhat.com@suse.de,
	Damien Le Moal <damien.lemoal@hgst.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 1/3] block: add flag for single-threaded submission
Message-ID: <20160721055431.GB14568@infradead.org>
References: <1468936978-9124-1-git-send-email-hare@suse.de>
 <1468936978-9124-2-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468936978-9124-2-git-send-email-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 19, 2016 at 04:02:56PM +0200, Hannes Reinecke wrote:
> Some devices (most notably SMR drives) support only
> one I/O stream eg for ensuring ordered I/O submission.
> This patch adds a new block queue flag
> 'BLK_QUEUE_SINGLE' to support these devices.

We'll need a blk-mq implementation of this flag as well before it can
be merged.
