Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752248AbdBCNpw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Feb 2017 08:45:52 -0500
Date: Fri, 3 Feb 2017 14:45:47 +0100
From: Jan Kara <jack@suse.cz>
To: Richard Weinberger <richard@nod.at>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 22/24] ubifs: Convert to separately allocated bdi
Message-ID: <20170203134547.GA5844@quack2.suse.cz>
References: <20170202173422.3240-1-jack@suse.cz>
 <20170202173422.3240-23-jack@suse.cz>
 <26c70615-f98c-23a6-abb7-de675fb658b6@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26c70615-f98c-23a6-abb7-de675fb658b6@nod.at>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu 02-02-17 21:34:32, Richard Weinberger wrote:
> Jan,
> 
> Am 02.02.2017 um 18:34 schrieb Jan Kara:
> > Allocate struct backing_dev_info separately instead of embedding it
> > inside the superblock. This unifies handling of bdi among users.
> > 
> > CC: Richard Weinberger <richard@nod.at>
> > CC: Artem Bityutskiy <dedekind1@gmail.com>
> > CC: Adrian Hunter <adrian.hunter@intel.com>
> > CC: linux-mtd@lists.infradead.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Is this series available at some git tree, please?

I've pushed it out to:

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdi

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
