Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdBAMwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2017 07:52:22 -0500
Date: Wed, 1 Feb 2017 04:52:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] block: Make blk_get_backing_dev_info() safe without
 open bdev
Message-ID: <20170201125221.GA28442@infradead.org>
References: <20170131125429.14303-1-jack@suse.cz>
 <20170131125429.14303-5-jack@suse.cz>
 <20170201095320.GD17386@infradead.org>
 <20170201122814.GF11567@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201122814.GF11567@quack2.suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 01, 2017 at 01:28:14PM +0100, Jan Kara wrote:
> OK, I'll do that. Another cleanup I was considering is to remove all other
> embedded occurences of backing_dev_info and make the structure only
> dynamically allocated. It would unify the handling of backing_dev_info and
> allow us to make bdi_init(), bdi_destroy(), etc. static inside
> mm/backing_dev.c. What do you think?

Yes, that would be great.  I have vague memories trying to do that
a long time ago, but I don't remember why it didn't go anywhere.
