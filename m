Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46255 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757072AbdDFNzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 09:55:25 -0400
Date: Thu, 6 Apr 2017 06:55:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/6] RFC add blkdev tests v2
Message-ID: <20170406135524.GA12230@infradead.org>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I still disagree with using xfstests for this.  Even if we were going
to treat the block devices nodes as yet another file system that's not
what the patches do - they create specific virtual devices to test
for each test.

I think the right way is to keep your patches as-is and copy the few
bits you use from xfstests into a new repository.
