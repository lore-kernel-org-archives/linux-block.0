Return-Path: <konrad.wilk@oracle.com>
Date: Tue, 18 Apr 2017 11:06:09 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <jbacik@fb.com>, James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 17/25] blk-mq: remove the error argument to
 blk_mq_complete_request
Message-ID: <20170418150609.GB12001@char.us.oracle.com>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-18-hch@lst.de>
 <20170418150321.s7yqpt63reutbs24@dhcp-3-128.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170418150321.s7yqpt63reutbs24@dhcp-3-128.uk.xensource.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 18, 2017 at 04:03:21PM +0100, Roger Pau Monn=E9 wrote:
> On Thu, Apr 06, 2017 at 05:39:36PM +0200, Christoph Hellwig wrote:
> > Now that we always have a ->complete callback we can remove the direc=
t
> > call to blk_mq_end_request, as well as the error argument to
> > blk_mq_complete_request.
> >=20
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>=20
> For blkfront:
>=20
> Acked-by: Roger Pau Monn=E9 <roger.pau@citrix.com>
>=20

And also
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
