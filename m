Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:34425 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750837AbdE2JF4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 May 2017 05:05:56 -0400
Date: Mon, 29 May 2017 12:05:48 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Javier Gonzalez" <javier@cnexlabs.com>
Subject: Re: [PATCH] ligtnvm: if LUNs are already allocated fix return
Message-ID: <20170529090548.GA33534@dhcp-216.srv.tuxera.com>
References: <20170513195038.GA8782@hercules.tuxera.com>
 <0BEA8552-A2D0-4B70-A9CF-98A019726FCC@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <0BEA8552-A2D0-4B70-A9CF-98A019726FCC@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Matias,

On Mon, May 15, 2017 at 06:31:58AM +0000, Javier Gonzalez wrote:
> > 
> > On 13 May 2017, at 21.50, Rakesh Pandit <rakesh@tuxera.com> wrote:
> > 
> > While creating new device with NVM_DEV_CREATE if LUNs are already
> > allocated ioctl would return -ENOMEM which is wrong.  This patch
> > propagates -EBUSY from nvm_reserve_luns which is correct response.
> > 
> > Fixes: ade69e243 ("lightnvm: merge gennvm with core")
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> > ---
> > drivers/lightnvm/core.c | 11 ++++++-----
> > 1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> > index 6a4aa60..440deb5 100644
> > --- a/drivers/lightnvm/core.c
> > +++ b/drivers/lightnvm/core.c
> > @@ -235,7 +235,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
> > 	struct nvm_target *t;
> > 	struct nvm_tgt_dev *tgt_dev;
> > 	void *targetdata;
> > -	int ret;
> > +	int ret = 0;
> > 
> > 	tt = nvm_find_target_type(create->tgttype, 1);
> > 	if (!tt) {
> > @@ -252,8 +252,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
> > 	}
> > 	mutex_unlock(&dev->mlock);
> > 
> > -	if (nvm_reserve_luns(dev, s->lun_begin, s->lun_end))
> > -		return -ENOMEM;
> > +	ret = nvm_reserve_luns(dev, s->lun_begin, s->lun_end);
> > +	if (ret)
> > +		goto err;
> > 
> > 	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
> > 	if (!t) {
> > @@ -314,8 +315,8 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
> > 	mutex_lock(&dev->mlock);
> > 	list_add_tail(&t->list, &dev->targets);
> > 	mutex_unlock(&dev->mlock);
> > -
> > -	return 0;
> > +err:
> > +	return ret;
> > err_sysfs:
> > 	if (tt->exit)
> > 		tt->exit(targetdata);
> > --
> > 2.9.3
> 
> Looks good.
> 
> Reviewed-by: Javier Gonz�lez <javier@cnexlabs.com>
> 

May you review/approve this so that it gets queued ?
