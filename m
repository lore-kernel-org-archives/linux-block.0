Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:41511 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbdFPHhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 03:37:01 -0400
Date: Fri, 16 Jun 2017 00:36:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] loop: Add PF_LESS_THROTTLE to block/loop device
 thread.
Message-ID: <20170616073658.GA20514@infradead.org>
References: <149758925866.10006.12779875832895865043.stgit@noble>
 <149758932925.10006.1411305319375332201.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149758932925.10006.1411305319375332201.stgit@noble>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

why isn't loop using kthread_create_worker()?  Why isn't the less
throttle a flag to kthread_create_worker()?  I hate all this open
coding..
