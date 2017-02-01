Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbdBAJsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2017 04:48:31 -0500
Date: Wed, 1 Feb 2017 01:48:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] block: Use pointer to backing_dev_info from
 request_queue
Message-ID: <20170201094824.GB17386@infradead.org>
References: <20170131125429.14303-1-jack@suse.cz>
 <20170131125429.14303-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170131125429.14303-3-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
