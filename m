Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:20191 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbdIVJoT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 05:44:19 -0400
Date: Fri, 22 Sep 2017 12:44:17 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
CC: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] lightnvm: pblk: fix message if L2P MAP is in device
Message-ID: <20170922094417.GB31904@dhcp-216.srv.tuxera.com>
References: <20170921112655.GA28539@dhcp-216.srv.tuxera.com>
 <D3D2476A-E07C-4012-A731-27552AFFCD5D@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <D3D2476A-E07C-4012-A731-27552AFFCD5D@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 22, 2017 at 10:52:19AM +0200, Javier Gonz�lez wrote:
> > On 21 Sep 2017, at 13.26, Rakesh Pandit <rakesh@tuxera.com> wrote:
> > 
> > This usually happens if we are developing with qemu and ll2pmode has
> > default value.  Even in that case message seems wrong.
> > 
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> > ---
> > drivers/lightnvm/pblk-init.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> > index 470ef04..c5c1337 100644
> > --- a/drivers/lightnvm/pblk-init.c
> > +++ b/drivers/lightnvm/pblk-init.c
> > @@ -913,7 +913,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
> > 	int ret;
> > 
> > 	if (dev->identity.dom & NVM_RSP_L2P) {
> > -		pr_err("pblk: device-side L2P table not supported. (%x)\n",
> > +		pr_err("pblk: device-side L2P table supported. (%x)\n",
> > 							dev->identity.dom);
> > 		return ERR_PTR(-EINVAL);
> > 	}
> > --
> > 2.5.0
> 
> You're right. This is inherited from rrpc.
> 
> Can we instead write "pblk: full host-side L2P table not supported"?
> People will not know about the hybrid device/host L2P as time goes by
> and it will just be confusing. I'm not even sure this will be part of
> the 2.0 spec, so it will probably go away with time...
> 

Sure.  I was confused the first time.  This is better.

It would be great if this is done while picking up.  I can repost as
well if need be.

Thanks,
