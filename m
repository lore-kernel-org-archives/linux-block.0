Return-Path: <prvs=751fb83b8=roger.pau@citrix.com>
Date: Wed, 8 Aug 2018 17:35:28 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Juergen Gross <jgross@suse.com>
CC: <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <axboe@kernel.dk>,
	<boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2 4/5] xen/blkback: move persistent grants
 flags to bool
Message-ID: <20180808153528.kbpauyeq6qgey5vh@mac>
References: <20180808142528.31029-1-jgross@suse.com>
 <20180808142528.31029-5-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180808142528.31029-5-jgross@suse.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 08, 2018 at 04:25:27PM +0200, Juergen Gross wrote:
> The struct persistent_gnt flags member is meant to be a bitfield of
> different flags. There is only PERSISTENT_GNT_ACTIVE flag left, so
> convert it to a bool named "active".
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Roger Pau Monn� <roger.pau@cirrix.com>

Thanks.
