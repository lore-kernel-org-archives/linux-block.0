Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:49931 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbdITTZf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Sep 2017 15:25:35 -0400
Date: Wed, 20 Sep 2017 22:25:33 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
CC: <mb@lightnvm.io>, <axboe@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Subject: Re: [PATCH 08/20] lightnvm: pblk: sched. metadata on write thread
Message-ID: <20170920192533.GA25404@dhcp-216.srv.tuxera.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
 <1498471049-25505-9-git-send-email-javier@cnexlabs.com>
 <20170920182834.GA25232@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20170920182834.GA25232@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 20, 2017 at 09:28:34PM +0300, Rakesh Pandit wrote:
> Hi Javier,
> 
> one small issue I found for error path while going through changes:
> 
> On Mon, Jun 26, 2017 at 11:57:17AM +0200, Javier Gonz�lez wrote:
> ..
> > +static int pblk_lines_alloc_metadata(struct pblk *pblk)
> > +{
[..]
> > +		if (!l_mg->sline_meta[i])
> > +			goto fail_free_smeta;
> 
> For this error path the the goto label at end doesn't free up
> resources correctly.  It needs a
> 
> while (--index >= 0)...
> 
> logic with appropriate adjustment.
> 
> > +	}
[..]
> > +	if (!l_mg->vsc_list)
> > +		goto fail_free_emeta;
> > +
> > +	for (i = 0; i < l_mg->nr_lines; i++)
> > +		l_mg->vsc_list[i] = cpu_to_le32(EMPTY_ENTRY);
> > +
> > +	return 0;
> > +
> > +fail_free_emeta:
> > +	while (--i >= 0) {
> > +		vfree(l_mg->eline_meta[i]->buf);
> 
> This would need l_mg->emeta_alloc_type check to decide whether
> allocation was done with kmalloc or vmalloc.
> 
> > +		kfree(&l_mg->eline_meta[i]);
> > +	}
> > +
> > +fail_free_smeta:
> > +	for (i = 0; i < PBLK_DATA_LINES; i++)
> > +		pblk_mfree(&l_mg->sline_meta[i], l_mg->smeta_alloc_type);
> > +
> > +	return -ENOMEM;
> > +}
> > +
> 
> Thanks,

I failed to see earlier that it has been merged already.  Will post a
patch in a while.

Thanks,
