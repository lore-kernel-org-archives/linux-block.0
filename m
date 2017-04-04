Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:50358 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbdDDGYY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Apr 2017 02:24:24 -0400
Date: Tue, 4 Apr 2017 08:24:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com
Subject: Re: [PATCH v3] blk-mq: remap queues when adding/removing hardware
        queues
Message-ID: <20170404062423.GA8924@lst.de>
References: <20170331204603.GB11462@vader> <9753ebd0c51a9d49f110a6d0d00888170905d97a.1490993257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9753ebd0c51a9d49f110a6d0d00888170905d97a.1490993257.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
