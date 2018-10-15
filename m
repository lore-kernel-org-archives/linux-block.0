Return-Path: <vliaskovitis@suse.com>
Message-ID: <b0b793a6cdfd634e126fbb00554ca68a780a00bd.camel@suse.com>
Subject: Re: [PATCH v2] xen/blkfront: avoid NULL blkfront_info dereference
 on device removal
From: Vasilis Liaskovitis <vliaskovitis@suse.com>
To: Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, jgross@suse.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, axboe@kernel.dk
Date: Mon, 15 Oct 2018 16:25:56 +0200
In-Reply-To: <20181015140201.elir7ettk7sz4aix@mac.bytemobile.com>
References: <20181015132508.23293-1-vliaskovitis@suse.com>
	 <20181015140201.elir7ettk7sz4aix@mac.bytemobile.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-10-15 at 16:02 +0200, Roger Pau Monné wrote:
> 
> > This results in a NULL pointer BUG when blkfront_remove and
> > blkif_free
> > try to access the failing device's NULL struct blkfront_info.
> > 
> > 
> I guess this is a candidate for backporting?
> 

yes, I think so. At least for kernels >=4.5, which could face this
issue due to commit c31ecf6c12 (this frees the struct blkinfo in the
failing path of talk_to_blkback).

thanks, 

- Vasilis
