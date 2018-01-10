Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:36879 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeAJQyh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jan 2018 11:54:37 -0500
Date: Wed, 10 Jan 2018 08:54:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org
Subject: Re: [PATCH v2] block: silently forbid sending any ioctl to a
 partition
Message-ID: <20180110165433.GA3084@infradead.org>
References: <20180110155452.26563-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180110155452.26563-1-pbonzini@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 10, 2018 at 04:54:52PM +0100, Paolo Bonzini wrote:
> After the first few months, the message has not led to many bug reports.
> It's been almost five years now, and in practice the main source of
> it seems to be MTIOCGET that someone is using to detect tape devices.
> While we could whitelist it just like CDROM_GET_CAPABILITY, this patch
> just removes the message altogether.
> 
> The patch also removes the "safe but not very useful" ioctl whitelist,
> as suggested by Christoph.  I doubt anything is using most of those
> ioctls _in general_, let alone on a partition.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Nice, thanks!

Reviewed-by: Christoph Hellwig <hch@lst.de>
