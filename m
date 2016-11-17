Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50123 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbcKQK24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2016 05:28:56 -0500
Date: Thu, 17 Nov 2016 02:28:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@fb.com, martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: Re: [PATCH 5/5] nvmet: add support for the Write Zeroes command
Message-ID: <20161117102854.GB8295@infradead.org>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
> +				GFP_KERNEL, &bio, false))

FYI, the NVMe working group has recently clarified that Write Zeroes
can deallocate the underlying LBAs, so we can pass true instead of false
here.
