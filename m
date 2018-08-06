Return-Path: <prvs=7490ff4ab=roger.pau@citrix.com>
Date: Mon, 6 Aug 2018 11:17:31 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Jens Axboe
	<axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blkfront: use true and false for boolean values
Message-ID: <20180806091731.tnyjv6d2e4tyl7uk@mac>
References: <20180805000859.GA20132@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180805000859.GA20132@embeddedor.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Sat, Aug 04, 2018 at 07:08:59PM -0500, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Roger Pau Monn� <roger.pau@citrix.com>

Thanks, Roger.
