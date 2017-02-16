Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32754 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933032AbdBPU4s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 15:56:48 -0500
Date: Thu, 16 Feb 2017 13:47:07 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: keith.busch@intel.com, jonathan.derrick@intel.com, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] block/sed-opal: allocate struct opal_dev dynamically
Message-ID: <20170216204707.GB3732@sbauer-Z170X-UD5>
References: <20170216201053.1190-1-hch@lst.de>
 <20170216201053.1190-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170216201053.1190-2-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 16, 2017 at 09:10:53PM +0100, Christoph Hellwig wrote:
> Insted of bloating the containing structure with it all the time this
> allocates struct opal_dev dynamically.  Additionally this allows moving
> the definition of struct opal_dev into sed-opal.c.  For this a new
> private data field is added to it that is passed to the send/receive
> callback.  After that a lot of internals can be made private as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Don't know if we need both but:

Tested-by: Scott Bauer <scott.bauer@intel.com>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>
