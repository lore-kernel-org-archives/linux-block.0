Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:40428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbdDTFA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2017 01:00:26 -0400
Date: Wed, 19 Apr 2017 22:00:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 3/3] mtip32xx: use runtime tag to initialize command
 header
Message-ID: <20170420050024.GA18163@infradead.org>
References: <20170419003142.9581-1-ming.lei@redhat.com>
 <20170419003142.9581-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170419003142.9581-4-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 19, 2017 at 08:31:42AM +0800, Ming Lei wrote:
> mtip32xx supposes that 'request_idx' passed to .init_request()
> is tag of the request, and use that as request's tag to initialize
> command header.
> 
> After MQ IO scheduler is in, request tag assigned isn't same with
> the request index anymore, so cause strange hardware failure on
> mtip32xx, even whole system panic is triggered.
> 
> This patch fixes the issue by initializing command header via
> request's real tag.

This patch looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But we should also remove the request_idx parameter from the
init_request and exit_request methods given that they can't be
used once a scheduler is in use.
