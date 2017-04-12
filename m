Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36235 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbdDLJnN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 05:43:13 -0400
Date: Wed, 12 Apr 2017 11:43:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 13/25] mtd: Convert to dynamically allocated bdi
 infrastructure
Message-ID: <20170412094311.GB11138@quack2.suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
 <20170329105623.18241-14-jack@suse.cz>
 <20170412081406.GM9830@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170412081406.GM9830@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed 12-04-17 01:14:06, Christoph Hellwig wrote:
> > +	sb->s_bdi = bdi_get(mtd_bdi);
> > +	sb->s_iflags |= SB_I_DYNBDI;
> 
> FTI, while I think this is a faithful conversion of the existing code,
> the single bdi for all MTD devices looks rather bogus to me..

Yeah, I don't understand why they don't allocate backing_dev_info per
superblock as other places do but I didn't dare to change that since there
are user visible consequences of that. I suspect they don't really want
anything from the bdi and allocate it only so that other parts of the
kernel are happy.

> Otherwise this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
