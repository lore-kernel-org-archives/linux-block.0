Return-Path: <jthumshirn@suse.de>
Date: Tue, 7 Jun 2016 10:38:21 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, keith.busch@intel.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/10] nvme.h: add RTD3R, RTD3E and OAES fields
Message-ID: <20160607083820.stlhphzuy27rx5ze@c203.arch.suse.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
 <1465248052-17811-2-git-send-email-hch@lst.de>
 <20160607081009.xd7wsyfuv4swuf4p@c203.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160607081009.xd7wsyfuv4swuf4p@c203.arch.suse.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 07, 2016 at 10:10:09AM +0200, Johannes Thumshirn wrote:
> On Mon, Jun 06, 2016 at 11:20:43PM +0200, Christoph Hellwig wrote:
> > These have been added in NVMe 1.2 and we'll need at least oaes for the
> > NVMe target driver.
> > 
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > Reviewed-by: Jay Freyensee <james.p.freyensee@intel.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  include/linux/nvme.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> > index 7d51b29..ff5ebc3 100644
> > --- a/include/linux/nvme.h
> > +++ b/include/linux/nvme.h
> > @@ -107,7 +107,10 @@ struct nvme_id_ctrl {
> >  	__u8			mdts;
> >  	__le16			cntlid;
> >  	__le32			ver;
> > -	__u8			rsvd84[172];
> > +	__le32			rtd3r;
> > +	__le32			rtd3e;
> > +	__le32			oaes;
> 
> Just out of curiosity, why not CTRATT as well?

OK found the patch adding it myself.

Sorry,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
