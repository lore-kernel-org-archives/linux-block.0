Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdAMIRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 03:17:10 -0500
Date: Fri, 13 Jan 2017 00:16:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        osandov@osandov.com, bart.vanassche@sandisk.com
Subject: Re: [PATCH 02/10] blk-mq: make mq_ops a const pointer
Message-ID: <20170113081635.GA637@infradead.org>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-3-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484170803-9311-3-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine, even totally independent of any sched work, like most
of the cleanups following this one

Reviewed-by: Christoph Hellwig <hch@lst.de>
