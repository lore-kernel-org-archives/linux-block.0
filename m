Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49221 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945152AbcJaR73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 13:59:29 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: block device direct I/O fast path
Date: Mon, 31 Oct 2016 11:59:23 -0600
Message-Id: <1477936765-8828-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

this small series adds a fasth path to the block device direct I/O
code.  It uses new magic created by Kent to avoid allocating an array
for the pages, and as part of that allows small, non-aio direct I/O
requests to be done without memory allocations or atomic ops and with
a minimal cache footprint.  It's basically a cut down version of the
new iomap direct I/O code, and in the future it might also make sense
to move the main direct I/O code to a similar model.  But indepedent
of that it's always worth to optimize the case of small, non-I/O
requests as allocating the bio and biovec on stack and a trivial
completion handler will always win over a full blown implementation.

