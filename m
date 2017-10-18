Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933230AbdJRGfO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2017 02:35:14 -0400
Date: Tue, 17 Oct 2017 23:35:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/2] block: factor out __blkdev_issue_zero_pages()
Message-ID: <20171018063510.GA29263@infradead.org>
References: <1508162350-21978-1-git-send-email-idryomov@gmail.com>
 <1508162350-21978-2-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508162350-21978-2-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
