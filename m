Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbdAMIeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 03:34:21 -0500
Date: Fri, 13 Jan 2017 00:34:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        osandov@osandov.com, bart.vanassche@sandisk.com
Subject: Re: [PATCH 01/10] block: move existing elevator ops to union
Message-ID: <20170113083420.GB16676@infradead.org>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484170803-9311-2-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 11, 2017 at 02:39:54PM -0700, Jens Axboe wrote:
> Prep patch for adding MQ ops as well, since doing anon unions with
> named initializers doesn't work on older compilers.

My gut feeling tells me MQ schedulers shouldn't share elevator_type.
I'll play around a bit with the code later to see if my gut was right.
