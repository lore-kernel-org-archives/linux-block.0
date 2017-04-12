Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbdDLIIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 04:08:31 -0400
Date: Wed, 12 Apr 2017 01:08:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/25] bdi: Export bdi_alloc_node() and bdi_put()
Message-ID: <20170412080830.GC9830@infradead.org>
References: <20170329105623.18241-1-jack@suse.cz>
 <20170329105623.18241-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170329105623.18241-4-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 29, 2017 at 12:56:01PM +0200, Jan Kara wrote:
> MTD will want to call bdi_alloc_node() and bdi_put() directly. Export
> these functions.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
