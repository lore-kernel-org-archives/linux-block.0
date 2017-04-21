Return-Path: <prvs=277bcc1d4=roger.pau@citrix.com>
Date: Fri, 21 Apr 2017 12:46:22 +0100
From: Roger Pau Monne <roger.pau@citrix.com>
To: Christoph Hellwig <hch@infradead.org>
CC: NeilBrown <neilb@suse.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 08/11] xen-blkfront: remove bio splitting.
Message-ID: <20170421114622.ymoprc7a4h3g6xqi@dhcp-3-128.uk.xensource.com>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672984.27388.11947154313852245586.stgit@noble>
 <20170421113620.GK12523@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170421113620.GK12523@infradead.org>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 21, 2017 at 04:36:20AM -0700, Christoph Hellwig wrote:
> Btw, I really don't understand why this code even looks at bios over
> just requeueing the request.  Can someone explain that bit to me?

This was done because Linux could migrate from a host supporting indirect
descriptors to a host not supporting them, and so the maximum number of
segments per request could change, and the requests already on the queue might
need to be split.

Roger.
