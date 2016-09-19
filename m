Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52365 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757003AbcISNvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 09:51:06 -0400
Date: Mon, 19 Sep 2016 06:51:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/14] blk-mq: Fix memory leaks on queue cleanup
Message-ID: <20160919135104.GA9763@infradead.org>
References: <cover.1474183901.git.agordeev@redhat.com>
 <6bbad3e6321685525574d6c0f01b875375351b81.1474183901.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6bbad3e6321685525574d6c0f01b875375351b81.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 18, 2016 at 09:37:11AM +0200, Alexander Gordeev wrote:
> Some data are leaked when blk_cleanup_queue() interface
> is called.

I don't think this is correct - we free them in blk_mq_release.
