Return-Path: <konrad.wilk@oracle.com>
Date: Thu, 18 Oct 2018 19:54:17 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, axboe@kernel.dk
Subject: Re: [PATCH v2] xen/blkfront: avoid NULL blkfront_info dereference on
 device removal
Message-ID: <20181018235417.GB36047@konrads-mbp.lan>
References: <20181015132508.23293-1-vliaskovitis@suse.com>
 <20181015140201.elir7ettk7sz4aix@mac.bytemobile.com>
 <b0b793a6cdfd634e126fbb00554ca68a780a00bd.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <b0b793a6cdfd634e126fbb00554ca68a780a00bd.camel@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 15, 2018 at 04:25:56PM +0200, Vasilis Liaskovitis wrote:
> On Mon, 2018-10-15 at 16:02 +0200, Roger Pau Monn� wrote:
> > 
> > > This results in a NULL pointer BUG when blkfront_remove and
> > > blkif_free
> > > try to access the failing device's NULL struct blkfront_info.
> > > 
> > > 
> > I guess this is a candidate for backporting?
> > 
> 
> yes, I think so. At least for kernels >=4.5, which could face this
> issue due to commit c31ecf6c12 (this frees the struct blkinfo in the
> failing path of talk_to_blkback).

OK, applied with Cc: stable@vger.kernel.org
> 
> thanks, 
> 
> - Vasilis
> 
> 
