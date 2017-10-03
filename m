Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:60251 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdJCH5X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 03:57:23 -0400
Date: Tue, 3 Oct 2017 00:56:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: factor out __blkdev_issue_zero_pages()
Message-ID: <20171003075659.GA8345@infradead.org>
References: <1506013972-23049-1-git-send-email-idryomov@gmail.com>
 <1506013972-23049-2-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506013972-23049-2-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
