Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:37882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbdBAJuN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2017 04:50:13 -0500
Date: Wed, 1 Feb 2017 01:50:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] block: Dynamically allocate and refcount
 backing_dev_info
Message-ID: <20170201095007.GC17386@infradead.org>
References: <20170131125429.14303-1-jack@suse.cz>
 <20170131125429.14303-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170131125429.14303-4-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 31, 2017 at 01:54:28PM +0100, Jan Kara wrote:
> Instead of storing backing_dev_info inside struct request_queue,
> allocate it dynamically, reference count it, and free it when the last
> reference is dropped. Currently only request_queue holds the reference
> but in the following patch we add other users referencing
> backing_dev_info.

Do we really need the separate slab cache?  Otherwise this looks
fine to me.
