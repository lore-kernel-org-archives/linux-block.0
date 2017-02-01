Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:36947 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753189AbdBASLi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 13:11:38 -0500
Date: Wed, 1 Feb 2017 19:11:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shaohua Li <shli@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        bhelgaas@google.com, hch@lst.de, axboe@fb.com
Subject: Re: [PATCH V2 1/3] blk-mq: allocate blk_mq_tags and requests in
        correct node
Message-ID: <20170201181136.GA11852@lst.de>
References: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
