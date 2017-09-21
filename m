Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:26586 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbdIUKPG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 06:15:06 -0400
Date: Thu, 21 Sep 2017 13:15:04 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
CC: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: fix error path in
 pblk_lines_alloc_metadata
Message-ID: <20170921101504.GA27665@dhcp-216.srv.tuxera.com>
References: <20170920195019.GA25759@dhcp-216.srv.tuxera.com>
 <032D1EF1-4F4A-45E1-BE6C-B8C9C9E0F6F7@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <032D1EF1-4F4A-45E1-BE6C-B8C9C9E0F6F7@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 21, 2017 at 11:56:46AM +0200, Javier Gonz�lez wrote:
> > On 20 Sep 2017, at 21.50, Rakesh Pandit <rakesh@tuxera.com> wrote:
> > 
> > Use appropriate memory free calls based on allocation type used and
> > also fix number of times free is called if kmalloc fails.
> > 
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> > ---
> > drivers/lightnvm/pblk-init.c | 8 ++++++--
> > 1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> > index 7cf4b53..470ef04 100644
> > --- a/drivers/lightnvm/pblk-init.c
> > +++ b/drivers/lightnvm/pblk-init.c
> > @@ -624,12 +624,16 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
> > 
> > fail_free_emeta:
> > 	while (--i >= 0) {
> > -		vfree(l_mg->eline_meta[i]->buf);
> > +		if (l_mg->emeta_alloc_type == PBLK_VMALLOC_META)
> > +			vfree(l_mg->eline_meta[i]->buf);
> > +		else
> > +			kfree(l_mg->eline_meta[i]->buf);
> > 		kfree(l_mg->eline_meta[i]);
> > 	}
> > 
> > +	i = PBLK_DATA_LINES;
> > fail_free_smeta:
> > -	for (i = 0; i < PBLK_DATA_LINES; i++)
> > +	while (--i >= 0)
> > 		kfree(l_mg->sline_meta[i]);
> 
> It is safe to use kfree on NULL pointers. No need to do this. You can
> either send a new patch, or we can change it when picking it up.

Yes, that would be great if this is adjusted while picking up.

> 
> > 
> > 	return -ENOMEM;
> > --
> > 2.5.0
> 
> Rest looks good.
> 
> 
> Reviewed-by: Javier Gonz�lez <javier@cnexlabs.com>
> 

Thanks,
