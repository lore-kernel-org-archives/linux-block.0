Return-Path: <konrad.wilk@oracle.com>
Date: Tue, 18 Apr 2017 11:05:33 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <jbacik@fb.com>, James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 16/25] xen-blkfront: don't use req->errors
Message-ID: <20170418150533.GA12001@char.us.oracle.com>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-17-hch@lst.de>
 <20170418150051.muglaxwfydaxypd6@dhcp-3-128.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170418150051.muglaxwfydaxypd6@dhcp-3-128.uk.xensource.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 18, 2017 at 04:00:51PM +0100, Roger Pau Monn=E9 wrote:
> On Thu, Apr 06, 2017 at 05:39:35PM +0200, Christoph Hellwig wrote:
> > xen-blkfron is the last users using rq->errros for passing back error=
 to
> > blk-mq, and I'd like to get rid of that.  In the longer run the drive=
r
> > should be moving more of the completion processing into .complete, bu=
t
> > this is the minimal change to move forward for now.
> >=20
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>=20
> Acked-by: Roger Pau Monn=E9 <roger.pau@citrix.com>
>=20

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thanks!
