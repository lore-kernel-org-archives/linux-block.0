Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:36839 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbdEBH2M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 03:28:12 -0400
Date: Tue, 2 May 2017 09:28:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH 4/6] mtip32xx: convert internal command issue to block
        IO path
Message-ID: <20170502072810.GA11582@lst.de>
References: <1493398473-29872-1-git-send-email-axboe@fb.com> <1493398473-29872-5-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493398473-29872-5-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But rather sooner than later we need to make this path at least go
through the normal end_request processing.  Without that we're just
bound to run into problems like we had with the tag changes again
when the driver is using the block layer APIs incompletely.
