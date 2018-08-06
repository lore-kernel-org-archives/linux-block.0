Return-Path: <prvs=7490ff4ab=roger.pau@citrix.com>
Date: Mon, 6 Aug 2018 18:18:59 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Juergen Gross <jgross@suse.com>
CC: <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>, <axboe@kernel.dk>,
	<boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 3/4] xen/blkfront: reorder tests in xlblk_init()
Message-ID: <20180806161859.gqcc4xze5jbbuu4v@mac>
References: <20180806113403.24728-1-jgross@suse.com>
 <20180806113403.24728-5-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180806113403.24728-5-jgross@suse.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 06, 2018 at 01:34:02PM +0200, Juergen Gross wrote:
> In case we don't want pv block devices we should not test parameters
> for sanity and eventually print out error messages. So test precluding
> conditions before checking parameters.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Roger Pau Monn� <roger.pau@citrix.com>

Thanks, Roger.
