Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41390 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdBVHNo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 02:13:44 -0500
Date: Wed, 22 Feb 2017 08:13:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv4 4/4] block/sed: Embed function data into the function
        sequence
Message-ID: <20170222071342.GA17472@lst.de>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com> <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +	if (!lock_held)
> +		mutex_lock(&dev->dev_lock);

No conditional locking, please.  I guess I causesd this by asking you
to remove __opal_lock_unlock, but it seems we'd either need to keep it
in the end.

Except for that the series looks fine to me.

Jens: given that 1-3 are the important fixes how about you pick those
up ASAP?  They all also had my Reviewed-by for previous postings.
