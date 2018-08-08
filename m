Return-Path: <prvs=751fb83b8=roger.pau@citrix.com>
Date: Wed, 8 Aug 2018 17:19:41 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Juergen Gross <jgross@suse.com>
CC: <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <axboe@kernel.dk>,
	<boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2 1/5] xen/blkback: don't keep persistent
 grants too long
Message-ID: <20180808151941.cse6louxgeyguz45@mac>
References: <20180808142528.31029-1-jgross@suse.com>
 <20180808142528.31029-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180808142528.31029-2-jgross@suse.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 08, 2018 at 04:25:24PM +0200, Juergen Gross wrote:
> Persistent grants are allocated until a threshold per ring is being
> reached. Those grants won't be freed until the ring is being destroyed
> meaning there will be resources kept busy which might no longer be
> used.
> 
> Instead of freeing only persistent grants until the threshold is
> reached add a timestamp and remove all persistent grants not having
> been in use for a minute.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Roger Pau Monn� <roger.pau@citrix.com>

Thanks, Roger.
