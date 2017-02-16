Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:10250 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933077AbdBPUxR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 15:53:17 -0500
Date: Thu, 16 Feb 2017 13:43:36 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: keith.busch@intel.com, jonathan.derrick@intel.com, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] block/sed-opal: tone down not supported warnings
Message-ID: <20170216204335.GA3732@sbauer-Z170X-UD5>
References: <20170216201053.1190-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170216201053.1190-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 16, 2017 at 09:10:52PM +0100, Christoph Hellwig wrote:
> Not having OPAL or a sub-feature supported is an entirely normal
> condition for many drives, so don't warn about it.  Keep the messages,
> but tone them down to debug only.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>
