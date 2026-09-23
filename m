Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2C53FD34
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175405; cv=pass; b=hWo5Gc2glfUoVx6RZWxZ0qf/Mmy0SezswGp9opgGFxVJd6jQiPSQV9xf/jgvXaxO6iFC4P7Nv9568SvLC4UKyIYS0FzhLR42N2Q44WLI4xgbtIH6Z1ArMY0FrAmEVt1CIPFnq5BMGWyuT/A5TAPwBMBriF047orKH7s8fk4q6hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175405; c=relaxed/simple;
	bh=KWjxpkS56vBdoY1mfq+LJ82QCdfp9oGXt1PZy19JPY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXFp4IozjvvikuocX5m5MWxdZZrJUyxIlUnZPd0qlcrayzBmK7bBVM3bnUQWgbTAngqtNBj6oSEZccUibhmifOHRZ3eNC4dy1vQf9jOauOcfkf0ej5tIHLaEhpRaUMVfYXYv8cl02nXrtgyU3VDWjLS/BdV3PSChOZvNRPjlzNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iejodJny; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=polX3o1/; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iejodJny";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="polX3o1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790175401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgl2fzrtLyoiFrBfNonxZVX3GZjaxX+KyLU7gYeHtiE=;
	b=iejodJnyID9u5TOT5LXICNL8o9nPiJ8LbMUyj41jD4U+qdRGIlqS5nZTZO4WOj0i6Agg6G
	hGoEDUpV2jJ653Nnsh8YkC/CMtk6X+2TCChMbL0aS2Eu6r77snzF2wcaiIN+UGdEuW3NKa
	MCmAF8V/wbSU3Vdkc1yfdu7pV75uu5U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-sRY-HJqAMs-ExS2nHC4IOQ-1; Wed, 23 Sep 2026 10:56:39 -0400
X-MC-Unique: sRY-HJqAMs-ExS2nHC4IOQ-1
X-Mimecast-MFC-AGG-ID: sRY-HJqAMs-ExS2nHC4IOQ_1790175399
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e745d5dabso9821575e9.0
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 07:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790175399; cv=none;
        d=google.com; s=arc-20260327;
        b=Wt8VzF+2wWmtoXmEwfxjVd4jyLfou3FCyuXLIkb3j61b0ituoXoBYOObWv6geaRQ+J
         Shg9CY/qR/NcSe6dAeW1ctjJH2Zhu3IZeOrtoP01IJ+yxZ0VXXSjhpT9CJmb4fTCfxsL
         kf68lHtrscMixsaXm/Wq6YE6KBYIYtxBUcr3JX6MFiPRCGff6HcdVUHlLPQTD89dStFB
         PDw7paq2o+vIkMv14uxGreNcqihYjovlmYQjXEqYJGpvM6f7gWEjTsW6JZ61TZG7vWXo
         JRlku91i/XS9DeNdwlnx9bTMHGH8Phoo+qhX5xoKRhLc+VwbFCYXK1Xqt5ehokfVx6nf
         vgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mgl2fzrtLyoiFrBfNonxZVX3GZjaxX+KyLU7gYeHtiE=;
        fh=1x8a1IEvrduKAfajCkbLRKKfEGd1oasmfBeRSvPf/UM=;
        b=ixXkeIfWlxfnrZROkWJ6NX93SmSvYOx89K1jmc77Z1FXHIHoGOAWGIYmwPcb8Esj+R
         0h9l2P6oPmy+MvhAa8e9UyW2hGUm0tc9df+rni87jTqoV7sB2nYd4Os0DngvrV3VkDvE
         C4UwiB6Re8V2usnmYBJZe0KV+Xri4ZlzLTOTDVLTaahX2MExwYBhYEC2SDNa02uI91xI
         k0RHu5Nn/bwuNqAF4e5V5cX/2BEpaWc2XHMrhthMiulBPOnRP/e5ktIOYSz+8nabENBZ
         dBtApnKZRr9d5fBM+E3VswgjCK/MFjYkqIAX66RZlAP/x+LfOg+G8NP1A7fMOhfHFGmT
         Oh1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790175399; x=1790780199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mgl2fzrtLyoiFrBfNonxZVX3GZjaxX+KyLU7gYeHtiE=;
        b=polX3o1/RuxlO+AvdVdblgD/cGKTVPdZCGWUzHwJ+9gnL7YhXp2yrxntKM99zp6AbY
         Ixhp4yEnMJhvIdWn/JINGsP3ngpzopjARgIpBOOLsIWVRSedVvTC88aH9GwfQ7pqdJzI
         RUSCRbzO6RFPUii68vdQGoNdODzEi0gStGPSUBvVqBDOix634jgm1cjzvb1dfptd49LQ
         1vge0pKzYj8WzaShMSjn096377yjOkSVKHGgPF5O5biS/3hG60MsGY60MxH3VYyNYeML
         ydF0kkad0g3DQq8vvThyi3nfEcGrjus8v7TU+uImcmxrzytQ6GD2Jq6CSZZ7zV2xu963
         1ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175399; x=1790780199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mgl2fzrtLyoiFrBfNonxZVX3GZjaxX+KyLU7gYeHtiE=;
        b=0tJme7tSKY48sknzHTmRHfZonzqaQrRdM7Os9Lxbwk2IFnLaIb+2cLHTmyxkkeMube
         MT0FtYqS1w2I0qqnoEH1M32dDTZw1GCNJEr/jbU0hpFNziSHr0G80pxhfoZI6lgvmhat
         0h4TUEeimOuX6HpM/M74wypyuDZqPt93nob7+DPuxa2P440xQePAPkpVGgKQkRxv0dK8
         NQyHDiDkeDaGy2H4ySjyEgE2zX4cv6KPhcst65zmkNdyH1qHq8+co7DvWOkiiTYPto54
         DXkRTRTaj+fg4t6rlL4iuiC9EbUj09XGjTtjLcoBXQPxI6RuGq8mMX9CfhptYKYR2U0o
         gp4g==
X-Forwarded-Encrypted: i=1; AKwUvBwfHqoUbL7zWzSzSvitxx87JOIW3TITHARZ/X5soIrx8igu2xqO2rVLKvIb5zzPN4FESfxU6KOHnTsZuA==@vger.kernel.org
X-Gm-Message-State: AFuF++n2FRGYUdbzTQX06mdxfrBfUse08z8g9LgNkXpnwnonbIdq08Kh
	XJEQVOvjmubeAlJd9m75+W5ahWnhSkM5cBX+5oL7EbJCx54njqftn0oB3Dje3Zj0N8P7XrKb5Ld
	c9lnqjw+RPT7mVJTHa3FrVLPLr3cq+FOEhsOZE4f+SGaTtgXAoTQTd3RvoXAU1btfIbYNFk0vKZ
	O0dtyoKtm3sP44lAzTogBoFTBb459uYAclppkKFAY=
X-Gm-Gg: AYBFou0rCcxH9hME/KoI+CtRzW2P3/CR6Co1MN8OW1sDrOuwjNKYLbqg2oLzWXcfZcW
	AR9Mt8wf0U/dH73dVuyHEchlznNb5GAM0A8AXY4kB6QAIfXsQ70OqBiR5EWK6rpPcwrgrIJ1KjA
	icLhFjzluvcJHI9IhNqLkUVcxrCMO3P30dVzj8/pFc8xjpzKyvrNvcs3cuE0FGoDU5VdutsuJWL
	GQi6pT9Xjlh4meKsA==
X-Received: by 2002:a05:600c:3b21:b0:49f:bd3c:bc25 with SMTP id 5b1f17b1804b1-49fdf25486bmr41518205e9.32.1790175398665;
        Wed, 23 Sep 2026 07:56:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3b21:b0:49f:bd3c:bc25 with SMTP id
 5b1f17b1804b1-49fdf25486bmr41517685e9.32.1790175398258; Wed, 23 Sep 2026
 07:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902200547.184734-1-jtaubepe@redhat.com> <20260902200547.184734-8-jtaubepe@redhat.com>
 <ab97f32b-31dd-4975-a8b2-b445110ae3a9@suse.de>
In-Reply-To: <ab97f32b-31dd-4975-a8b2-b445110ae3a9@suse.de>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Wed, 23 Sep 2026 10:56:27 -0400
X-Gm-Features: AclHuK-DXEgf8h50oy37YCFQPiuZykx03xaAenYlWJQtQSO7dJcvZ7KWpU5nfJA
Message-ID: <CADRr4bePoiDnWX_XrMWtQe=1g4Yrw1_dK86EV2k9XZR0HnL+UQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] nvme: fcloop: Add set_marginal_rport to sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, John Meneghini <jmeneghi@redhat.com>, 
	Bryan Gurney <bgurney@redhat.com>, Chris Leech <cleech@redhat.com>, 
	"Ewan D . Milne" <emilne@redhat.com>, shinichiro.kawasaki@wdc.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:03=E2=80=AFAM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 9/2/26 10:05 PM, Jesse Taube wrote:
> > To allow testing of multipath failover, add a sysfs attribute to set a
> > remote port as marginal. This will allow the fcloop LLDD to set the
> > marginal flag on a remote port, simulating a marginal link.
> >
> > Example:
> > Turn on marginal for a remote port matching wwnn and wwpn:
> > `echo 'wwnn=3D0x200000109b5f2956,wwpn=3D0x100000109b5f2956,marginal=3D1=
' >
> > /sys/class/fcloop/ctl/set_marginal_rport`
> >
> > Turn off marginal for a remote port matching wwnn and wwpn:
> > `echo 'wwnn=3D0x200000109b5f2956,wwpn=3D0x100000109b5f2956,marginal=3D0=
' >
> > /sys/class/fcloop/ctl/set_marginal_rport`
> >
> > Suggested-by: John Meneghini <jmeneghi@redhat.com>
> > Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> > V10 -> V1:
> >   - New patch
> > V1 -> V2:
> >   - Fix reference count leak in error path
> > ---
> >   drivers/nvme/target/fcloop.c | 50 +++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 50 insertions(+)
> >
> > diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.=
c
> > index b63af3b643a6..9977c2a71bd5 100644
> > --- a/drivers/nvme/target/fcloop.c
> > +++ b/drivers/nvme/target/fcloop.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/module.h>
> >   #include <linux/parser.h>
> >   #include <uapi/scsi/fc/fc_fs.h>
> > +#include <uapi/scsi/fc/fc_els.h>
> >
> >   #include "../host/nvme.h"
> >   #include "../target/nvmet.h"
> > @@ -21,6 +22,7 @@ enum {
> >       NVMF_OPT_FCADDR         =3D 1 << 3,
> >       NVMF_OPT_LPWWNN         =3D 1 << 4,
> >       NVMF_OPT_LPWWPN         =3D 1 << 5,
> > +     NVMF_OPT_MARGINAL       =3D 1 << 6,
> >   };
> >
> >   struct fcloop_ctrl_options {
> > @@ -31,6 +33,7 @@ struct fcloop_ctrl_options {
> >       u32                     fcaddr;
> >       u64                     lpwwnn;
> >       u64                     lpwwpn;
> > +     u32                     marginal;
> >   };
> >
> >   static const match_table_t opt_tokens =3D {
> > @@ -40,6 +43,7 @@ static const match_table_t opt_tokens =3D {
> >       { NVMF_OPT_FCADDR,      "fcaddr=3D%x"     },
> >       { NVMF_OPT_LPWWNN,      "lpwwnn=3D%s"     },
> >       { NVMF_OPT_LPWWPN,      "lpwwpn=3D%s"     },
> > +     { NVMF_OPT_MARGINAL,    "marginal=3D%d"   },
> >       { NVMF_OPT_ERR,         NULL            }
> >   };
> >
> > @@ -120,6 +124,13 @@ fcloop_parse_options(struct fcloop_ctrl_options *o=
pts,
> >                       }
> >                       opts->lpwwpn =3D token64;
> >                       break;
> > +             case NVMF_OPT_MARGINAL:
> > +                     if (match_int(args, &token)) {
> > +                             ret =3D -EINVAL;
> > +                             goto out_free_options;
> > +                     }
> > +                     opts->marginal =3D token;
> > +                     break;
> >               default:
> >                       pr_warn("unknown parameter or missing value '%s'\=
n", p);
> >                       ret =3D -EINVAL;
> > @@ -199,6 +210,9 @@ fcloop_parse_nm_options(struct device *dev, u64 *nn=
ame, u64 *pname,
> >
> >   #define TGTPORT_OPTS        (NVMF_OPT_WWNN | NVMF_OPT_WWPN)
> >
> > +#define MARGINAL_OPTS        (NVMF_OPT_WWNN | NVMF_OPT_WWPN | \
> > +                      NVMF_OPT_MARGINAL)
> > +
> >
> >   static DEFINE_SPINLOCK(fcloop_lock);
> >   static LIST_HEAD(fcloop_lports);
> > @@ -1663,6 +1677,40 @@ fcloop_set_cmd_drop(struct device *dev, struct d=
evice_attribute *attr,
> >       return count;
> >   }
> >
> > +static ssize_t
> > +fcloop_set_marginal_rport(struct device *dev, struct device_attribute =
*attr,
> > +             const char *buf, size_t count)
> > +{
> > +     struct fcloop_nport *nport;
> > +     struct fcloop_ctrl_options opts =3D {};
> > +     unsigned long flags;
> > +     int ret;
> > +
> > +     ret =3D fcloop_parse_options(&opts, buf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* everything there ? */
> > +     if ((opts.mask & MARGINAL_OPTS) !=3D MARGINAL_OPTS)
> > +             return -EINVAL;
> > +
> > +     nport =3D fcloop_nport_lookup(opts.wwnn, opts.wwpn);
> > +     if (!nport)
> > +             return -ENOENT;
> > +
> > +     spin_lock_irqsave(&fcloop_lock, flags);
> > +     if (!nport->rport || !nport->rport->remoteport) {
> > +             spin_unlock_irqrestore(&fcloop_lock, flags);
> > +             fcloop_nport_put(nport);
> > +             return -ENOENT;
> > +     }
> > +
> > +     nvme_fc_set_remoteport_fpin(nport->rport->remoteport, opts.margin=
al);
> > +     spin_unlock_irqrestore(&fcloop_lock, flags);
> > +     fcloop_nport_put(nport);
> > +
> > +     return count;
> > +}
> >
> >   static DEVICE_ATTR(add_local_port, 0200, NULL, fcloop_create_local_po=
rt);
> >   static DEVICE_ATTR(del_local_port, 0200, NULL, fcloop_delete_local_po=
rt);
> > @@ -1671,6 +1719,7 @@ static DEVICE_ATTR(del_remote_port, 0200, NULL, f=
cloop_delete_remote_port);
> >   static DEVICE_ATTR(add_target_port, 0200, NULL, fcloop_create_target_=
port);
> >   static DEVICE_ATTR(del_target_port, 0200, NULL, fcloop_delete_target_=
port);
> >   static DEVICE_ATTR(set_cmd_drop, 0200, NULL, fcloop_set_cmd_drop);
> > +static DEVICE_ATTR(set_marginal_rport, 0200, NULL, fcloop_set_marginal=
_rport);
> >
> >   static struct attribute *fcloop_dev_attrs[] =3D {
> >       &dev_attr_add_local_port.attr,
> > @@ -1680,6 +1729,7 @@ static struct attribute *fcloop_dev_attrs[] =3D {
> >       &dev_attr_add_target_port.attr,
> >       &dev_attr_del_target_port.attr,
> >       &dev_attr_set_cmd_drop.attr,
> > +     &dev_attr_set_marginal_rport.attr,
> >       NULL
> >   };
> >
> Please don't make it a fabrics option.

What do you mean by fabrics option? How should I fix this?

Thanks,
Jesse Taube

> Setting is via sysfs is
> sufficient seeing it's for testing only.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>

