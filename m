Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754686AbcLAKBQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2016 05:01:16 -0500
Date: Thu, 1 Dec 2016 02:01:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Cc: axboe@fb.com, keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH V2 5/5] nvmet: add support for the Write Zeroes command
Message-ID: <20161201100115.GE8791@infradead.org>
References: <1480537742-15190-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1480537742-15190-5-git-send-email-chaitanya.kulkarni@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480537742-15190-5-git-send-email-chaitanya.kulkarni@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
