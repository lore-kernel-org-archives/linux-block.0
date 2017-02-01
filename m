Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:40845 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdBAJxW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2017 04:53:22 -0500
Date: Wed, 1 Feb 2017 01:53:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] block: Make blk_get_backing_dev_info() safe without
 open bdev
Message-ID: <20170201095320.GD17386@infradead.org>
References: <20170131125429.14303-1-jack@suse.cz>
 <20170131125429.14303-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170131125429.14303-5-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But can you also add another patch to kill off blk_get_backing_dev_info?
The direct dereference is short and cleaner.  Additionally the bt_bdi
field in XFS could go away, too.
