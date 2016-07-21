Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45130 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbcGUF7g (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 21 Jul 2016 01:59:36 -0400
Date: Wed, 20 Jul 2016 22:59:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Damien Le Moal <damien.lemoal@hgst.com>
Subject: Re: [PATCH 1/6] blk-sysfs: Add 'chunk_sectors' to sysfs attributes
Message-ID: <20160721055935.GD14568@infradead.org>
References: <1468934439-93579-1-git-send-email-hare@suse.de>
 <1468934439-93579-2-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468934439-93579-2-git-send-email-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 19, 2016 at 03:20:34PM +0200, Hannes Reinecke wrote:
> The queue limits already have a 'chunk_sectors' setting, so
> we should be presenting it via sysfs.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Looks fine for 4.8 independent of any ZBC implications:

Reviewed-by: Christoph Hellwig <hch@lst.de>
