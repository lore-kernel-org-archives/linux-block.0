Return-Path: <prvs=7490ff4ab=roger.pau@citrix.com>
Date: Mon, 6 Aug 2018 18:20:37 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Juergen Gross <jgross@suse.com>
CC: <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>, <axboe@kernel.dk>,
	<boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 4/4] xen/blkback: remove unused pers_gnts_lock from
 struct xen_blkif_ring
Message-ID: <20180806162037.g32ilxvvzdfnwu7i@mac>
References: <20180806113403.24728-1-jgross@suse.com>
 <20180806113403.24728-6-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180806113403.24728-6-jgross@suse.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 06, 2018 at 01:34:03PM +0200, Juergen Gross wrote:
> pers_gnts_lock isn't being used anywhere. Remove it.

That was likely a leftover from when the list of persistent grants was
shared between rings.

> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Roger Pau Monn� <roger.pau@citrix.com>

Thanks, Roger.
