Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31419 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbdKCPJc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Nov 2017 11:09:32 -0400
Date: Fri, 3 Nov 2017 09:13:51 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 3/3] nvme: fix eui_show() print format
Message-ID: <20171103151351.GB11300@localhost.localdomain>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-4-git-send-email-javier@cnexlabs.com>
 <20171103125516.GC25186@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171103125516.GC25186@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Nov 03, 2017 at 01:55:16PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 03, 2017 at 11:02:50AM +0100, Javier Gonz�lez wrote:
> > Signed-off-by: Javier Gonz�lez <javier@cnexlabs.com>
> > ---
> >  drivers/nvme/host/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index ae8ab0a1ef0d..f05c81774abf 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2108,7 +2108,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
> >  								char *buf)
> >  {
> >  	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> > -	return sprintf(buf, "%8phd\n", ns->eui);
> > +	return sprintf(buf, "%8phD\n", ns->eui);
> >  }
> >  static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
> 
> This looks correct.  I wonder what the old code printed - does someone
> have a device with an EUI-64 at hand to quickly cross check what we
> did before?

It just prints the same as the 'ph' format, which would look like this:

  01 02 03 04 05 06 07 08

The change will make it look like this:

  01-02-03-04-05-06-07-08

I think that was the original intention.

Reviewed-by: Keith Busch <keith.busch@intel.com>
