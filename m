Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50349 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbcKQK3m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2016 05:29:42 -0500
Date: Thu, 17 Nov 2016 02:29:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@fb.com, martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: Re: [PATCH 1/5] block: add async variant of blkdev_issue_zeroout
Message-ID: <20161117102939.GC8295@infradead.org>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-2-git-send-email-chaitanya.kulkarni@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479279039-25818-2-git-send-email-chaitanya.kulkarni@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 15, 2016 at 10:50:35PM -0800, Chaitanya Kulkarni wrote:
> Similar to __blkdev_issue_discard this variant allows submitting
> the final bio asynchronously and chaining multiple ranges
> into a single completion.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
