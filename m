Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Message-ID: <1509722197.15520.17.camel@perches.com>
Subject: Re: [PATCH 3/3] nvme: fix eui_show() print format
From: Joe Perches <joe@perches.com>
To: Christoph Hellwig <hch@lst.de>, Javier =?ISO-8859-1?Q?Gonz=E1lez?=
 <jg@lightnvm.io>
Date: Fri, 03 Nov 2017 08:16:37 -0700
In-Reply-To: <20171103125516.GC25186@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-4-git-send-email-javier@cnexlabs.com>
 <20171103125516.GC25186@lst.de>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, keith.busch@intel.com,
 Javier =?ISO-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-11-03 at 13:55 +0100, Christoph Hellwig wrote:
> On Fri, Nov 03, 2017 at 11:02:50AM +0100, Javier Gonz=E1lez wrote:
> > Signed-off-by: Javier Gonz=E1lez <javier@cnexlabs.com>
[]
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
[]
> > @@ -2108,7 +2108,7 @@ static ssize_t eui_show(struct device *dev, struc=
t device_attribute *attr,
> >  								char *buf)
> >  {
> >  	struct nvme_ns *ns =3D nvme_get_ns_from_dev(dev);
> > -	return sprintf(buf, "%8phd\n", ns->eui);
> > +	return sprintf(buf, "%8phD\n", ns->eui);
> >  }
> >  static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
> =

> This looks correct.  I wonder what the old code printed - does someone
> have a device with an EUI-64 at hand to quickly cross check what we
> did before?

It uses spaces between bytes and not dashes.

The code has been this way a couple years now.

I think this proposal, while it might fix an
unintentional output style, could also be an API
and could cause user breakage if changed.

Perhaps this should just become

	%8ph

without D



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
