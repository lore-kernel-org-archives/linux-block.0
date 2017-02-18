Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47488 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbdBRIg5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Feb 2017 03:36:57 -0500
Date: Sat, 18 Feb 2017 09:36:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 5/5] block/sed: Eliminate state variable
Message-ID: <20170218083642.GC11798@lst.de>
References: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com> <1487376029-22662-6-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487376029-22662-6-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I would just fold it into the previous patch.
