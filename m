Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:49193 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752971AbdBRQPc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Feb 2017 11:15:32 -0500
Date: Sat, 18 Feb 2017 17:14:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Scott Bauer <scott.bauer@intel.com>
Cc: linux-block@vger.kernel.org, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, hch@lst.de
Subject: Re: [PATCH] block/sed-opal: Introduce free_opal_dev to free the
        structure and clean up state
Message-ID: <20170218161457.GA17922@lst.de>
References: <1487352313-3539-1-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487352313-3539-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 17, 2017 at 10:25:13AM -0700, Scott Bauer wrote:
> Before we free the opal structure we need to clean up any saved
> locking ranges that the user had told us to unlock from a suspend.
> Also fixup a list_for_each to list_for_each_safe in the save path.
> 
> Signed-off-by: Scott Bauer <scott.bauer@intel.com>

This looks fine to me, but I think the fix to add_suspend_info
should be a separate patch:

Reviewed-by: Christoph Hellwig <hch@lst.de>
