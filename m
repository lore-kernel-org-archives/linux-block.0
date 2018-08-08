Return-Path: <prvs=751fb83b8=roger.pau@citrix.com>
Date: Wed, 8 Aug 2018 17:23:13 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Juergen Gross <jgross@suse.com>
CC: <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>, <axboe@kernel.dk>,
	<boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 2/5] xen/blkfront: cleanup stale persistent grants
Message-ID: <20180808152313.j4k6jbnw73xm2iht@mac>
References: <20180808142528.31029-1-jgross@suse.com>
 <20180808142528.31029-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180808142528.31029-3-jgross@suse.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 08, 2018 at 04:25:25PM +0200, Juergen Gross wrote:
> Add a periodic cleanup function to remove old persistent grants which
> are no longer in use on the backend side. This avoids starvation in
> case there are lots of persistent grants for a device which no longer
> is involved in I/O business.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Roger Pau Monn� <roger.pau@citrix.com>

Thanks, Roger.
