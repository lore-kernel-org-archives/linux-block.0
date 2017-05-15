Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56933 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934572AbdEOP2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2017 11:28:44 -0400
From: Christoph Hellwig <hch@lst.de>
To: snitzer@redhat.com
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: dm fixes for 4.12-rc
Date: Mon, 15 May 2017 17:28:35 +0200
Message-Id: <20170515152839.23375-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Mike,

the first three patches sort out a few issues with how my dm cleanups and
the multipath fixes from Bart interacted.  The fourth is something I found
in an audit, it might or might not be worth to go into 4.12.  If not please
don't apply it yet as it will be needed as the baseline for some block work
I'll post in a few days.
