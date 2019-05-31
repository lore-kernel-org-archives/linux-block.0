Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B180BC04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 06:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823082645D
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 06:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI4WxsC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEaGa7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 02:30:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39646 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGa6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 02:30:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so5671964wrt.6;
        Thu, 30 May 2019 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuXRgKu/1Uj9+vhEaRCB8Rrusk9ikudSiRusKoV4cwY=;
        b=OI4WxsC13BHHruUm+/wO4dZaHRMJffb84mj98mXQjE7RmxYN6WuvGh6TGImb8Fihj/
         RMuM3lbD0ReU+s2oRdNkzioiIAub5Fhx1dfVwQD2vpTyCXyc0k4ggkxnGMFFGptyONKv
         eIEVOhWY2bBTIWmypMKggpoGwtlgeOrzjbLOhKwmAqoOu9wdN0cf4GQqGdXMa2rnJ30z
         cd2SgT52lACnLqN+rWrXiNAvI35IGESto910tP9M84iNDYop/1gaVTJtCKqBIClYScA/
         qNnIr/A94Ko4gFW1Hajttanrs4RVW/0tbffm+pS36bUzdCcKK0rOvPlMj472nbJvBCzn
         H3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuXRgKu/1Uj9+vhEaRCB8Rrusk9ikudSiRusKoV4cwY=;
        b=W8j4vLlylANk8KlTJCWoPMUWjMfiZoTkIkrd3auRwmJK+lglNHiSCBZaeF66a24/K6
         h/FJy9hwDT6180FOzmlna3GYBzswcREOIkJzM9Vo/wZOrClO1uroULK1hJO4rO0zyYBw
         MFxZcjbkMnVTzIPV2SMl7ZpbmPeoB1yuxmNV2JGvTVGydcehGPHJp5vyAfTlS26RffMC
         MsqHDoVDbziRo8mJ275se9z3BIwIoI9G32n/0PDhk1DtHfMPdUX/1gbk0I/q9lESb3Oa
         NaMRjrx7QQuesUKDrdR/NHN+8+DYgsvaEm8PIrqWUiNmZbIkBr+ZQoghoJ7xgRUeIPPM
         n0Ow==
X-Gm-Message-State: APjAAAUEA2ob5fvprIF23NkTVyJRViaQ0DXmOb1M/Zg8YCeSReSHsA1v
        JvXZsXRW5DAPiGwHGJa6oQjNTfGI26ljzvcAOWM=
X-Google-Smtp-Source: APXvYqymUUm/uhIc7MW5B4OYGAR7bzmjIZwe9TVK3Tg0yDfyD8mCWmnt1Ga+h2Cl6o3eX6y3Lk8O6CUscKtMu2MH8Sg=
X-Received: by 2002:adf:afdf:: with SMTP id y31mr4986401wrd.315.1559284256872;
 Thu, 30 May 2019 23:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190531022801.10003-1-ming.lei@redhat.com> <20190531022801.10003-7-ming.lei@redhat.com>
 <d489e4e8-e625-4c68-4ab8-9b70e5989cc8@suse.de>
In-Reply-To: <d489e4e8-e625-4c68-4ab8-9b70e5989cc8@suse.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 31 May 2019 14:30:44 +0800
Message-ID: <CACVXFVMFVqD3797qfe8K5bZnwv7fSqP7oz3AMyQLKWKH8Z89FA@mail.gmail.com>
Subject: Re: [PATCH 6/9] scsi: hpsa: convert private reply queue to blk-mq hw queue
To:     Hannes Reinecke <hare@suse.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 31, 2019 at 2:15 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 5/31/19 4:27 AM, Ming Lei wrote:
> > SCSI's reply qeueue is very similar with blk-mq's hw queue, both
> > assigned by IRQ vector, so map te private reply queue into blk-mq's hw
> > queue via .host_tagset.
> >
> > Then the private reply mapping can be removed.
> >
> > Another benefit is that the request/irq lost issue may be solved in
> > generic approach because managed IRQ may be shutdown during CPU
> > hotplug.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/scsi/hpsa.c | 49 ++++++++++++++++++---------------------------
> >  1 file changed, 19 insertions(+), 30 deletions(-)
> >
> There had been requests to make the internal interrupt mapping optional;
> but I guess we first should

For HPSA, either managed IRQ is used or single MSI-X vector is allocated,
I am pretty sure that both cases are covered in this patch, so not sure what the
'optional' means.

> > diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> > index 1bef1da273c2..c7136f9f0ce1 100644
> > --- a/drivers/scsi/hpsa.c
> > +++ b/drivers/scsi/hpsa.c
> > @@ -51,6 +51,7 @@
> >  #include <linux/jiffies.h>
> >  #include <linux/percpu-defs.h>
> >  #include <linux/percpu.h>
> > +#include <linux/blk-mq-pci.h>
> >  #include <asm/unaligned.h>
> >  #include <asm/div64.h>
> >  #include "hpsa_cmd.h"
> > @@ -902,6 +903,18 @@ static ssize_t host_show_legacy_board(struct device *dev,
> >       return snprintf(buf, 20, "%d\n", h->legacy_board ? 1 : 0);
> >  }
> >
> > +static int hpsa_map_queues(struct Scsi_Host *shost)
> > +{
> > +     struct ctlr_info *h = shost_to_hba(shost);
> > +     struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
> > +
> > +     /* Switch to cpu mapping in case that managed IRQ isn't used */
> > +     if (shost->nr_hw_queues > 1)
> > +             return blk_mq_pci_map_queues(qmap, h->pdev, 0);
> > +     else
> > +             return blk_mq_map_queues(qmap);
> > +}
> > +
> >  static DEVICE_ATTR_RO(raid_level);
> >  static DEVICE_ATTR_RO(lunid);
> >  static DEVICE_ATTR_RO(unique_id);
> This helper is pretty much shared between all converted drivers.
> Shouldn't we have a common function here?
> Something like
>
> scsi_mq_host_tag_map(struct Scsi_Host *shost, int offset)?

I am not sure if the common helper is helpful much, since the
condition for using
cpu map or pci map still depends on driver private state, we still
have to define
each driver's .map_queues too.

Also PCI device pointer has to be provided.

thanks,
Ming Lei
