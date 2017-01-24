Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55470 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbdAXPKn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 10:10:43 -0500
Date: Tue, 24 Jan 2017 16:10:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH 01/16] block: fix elevator init check
Message-ID: <20170124151041.GB27705@lst.de>
References: <1485185361-29786-1-git-send-email-hch@lst.de> <1485185361-29786-2-git-send-email-hch@lst.de> <20170124150639.GA22198@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170124150639.GA22198@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 24, 2017 at 08:06:39AM -0700, Jens Axboe wrote:
> We check for REQ_PREFLUSH | REQ_FUA in so many places though, might not
> be a bad idea to keep the helper but just make it take the opf and fix
> up the other locations too. The fact that PREFLUSH|FUA is the magic to
> check for is somewhat tribal knowledge.

I'll see if I can come up with something sensible.  The current
helper using the bio and the magic 0 value is not exactly helpful.
