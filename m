Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:51168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbdDLIRr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 04:17:47 -0400
Date: Wed, 12 Apr 2017 01:17:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 19/25] nilfs2: Convert to properly refcounting bdi
Message-ID: <20170412081746.GS9830@infradead.org>
References: <20170329105623.18241-1-jack@suse.cz>
 <20170329105623.18241-20-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170329105623.18241-20-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 29, 2017 at 12:56:17PM +0200, Jan Kara wrote:
> Similarly to set_bdev_super() NILFS2 just used block device reference to
> bdi. Convert it to properly getting bdi reference. The reference will
> get automatically dropped on superblock destruction.

I really wish we could get rid of this open coding in block based
file systems..

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
