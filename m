Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49239 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbdFPHhV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 03:37:21 -0400
Date: Fri, 16 Jun 2017 00:37:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: use filp_close() rather than fput()
Message-ID: <20170616073720.GB20514@infradead.org>
References: <149758925866.10006.12779875832895865043.stgit@noble>
 <149758932908.10006.10765671892098302463.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149758932908.10006.10765671892098302463.stgit@noble>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
