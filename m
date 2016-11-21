Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52481 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbcKUNCS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2016 08:02:18 -0500
Date: Mon, 21 Nov 2016 05:02:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [RFC, PATCH] pktcdvd: don't scribble over the bvec array
Message-ID: <20161121130217.GA23406@infradead.org>
References: <1477551884-25062-1-git-send-email-hch@lst.de>
 <20161107154251.GA12856@infradead.org>
 <23bc2d63-4835-0ccc-5605-59bae2f35fa5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23bc2d63-4835-0ccc-5605-59bae2f35fa5@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 07, 2016 at 08:50:38AM -0700, Jens Axboe wrote:
> I'll apply this for 4.10, and mark the driver as
> unmaintained/deprecated.

Btw, I didn't see this part in the tree yet.
