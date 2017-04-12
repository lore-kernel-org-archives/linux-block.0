Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbdDLJdz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 05:33:55 -0400
Date: Wed, 12 Apr 2017 11:33:52 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 19/25] nilfs2: Convert to properly refcounting bdi
Message-ID: <20170412093352.GA11138@quack2.suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
 <20170329105623.18241-20-jack@suse.cz>
 <20170412081746.GS9830@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170412081746.GS9830@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed 12-04-17 01:17:46, Christoph Hellwig wrote:
> On Wed, Mar 29, 2017 at 12:56:17PM +0200, Jan Kara wrote:
> > Similarly to set_bdev_super() NILFS2 just used block device reference to
> > bdi. Convert it to properly getting bdi reference. The reference will
> > get automatically dropped on superblock destruction.
> 
> I really wish we could get rid of this open coding in block based
> file systems..

Well, nilfs has it because it has its own ->mount implementation (and
similarly gfs2). If someone has idea how common code out of those could be
factored out, bdi handling could be part of that...

> Otherwise looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
