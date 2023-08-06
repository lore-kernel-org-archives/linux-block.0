Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F15C001DE
	for <linux-block@archiver.kernel.org>; Sun,  6 Aug 2023 15:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjHFPSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Aug 2023 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFPSg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Aug 2023 11:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16AC10DE
        for <linux-block@vger.kernel.org>; Sun,  6 Aug 2023 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691335070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmKB9tnmoSW66PnBBOCrXWK1ePidGDAnxGSMu5crApw=;
        b=R7/Dvvs67igond/A10mE7BvhHWASzh1D4R1wIYjojGMhJRNahTYp3n29n35lsCxPOwZD06
        eoGZRom7KIqZpeoMEaiI1YUGavhyHKmb7JucEvUIycJiXO83ISn2hKF2PKowQUBroHAom4
        xii2pzotYEMCSAOTS+NGOs4sMmPKluA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-rYzX39rrM0aWPTkoEGgibA-1; Sun, 06 Aug 2023 11:17:46 -0400
X-MC-Unique: rYzX39rrM0aWPTkoEGgibA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99c20561244so242914666b.0
        for <linux-block@vger.kernel.org>; Sun, 06 Aug 2023 08:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691335065; x=1691939865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmKB9tnmoSW66PnBBOCrXWK1ePidGDAnxGSMu5crApw=;
        b=KqJWSHxqF1ZtyfQ2piJCF+lNl2jAi+AXzIfst5A1jhvlcttiPMy+PM7lMGAIFdT/Ez
         ivG0gPaHp78kHW+q/fyfqZoLB/xMIYrM8fzJtGjkzHZGPfs1k6sEUr6MLAzhCWtGLcBe
         H85sSlwhD78/ACiiclrZqRKo8EVXLQxaXo7kZf0sRuYNc349SbkIUgJz1UpG+bg+YYg/
         qOqJim0m4PbsVuHwVGjscq0ynQ+MWik69SsDGnBWKaZdQuH7ecjIGQvZmT6ra+1a963k
         j6uyVFCks1CnN5ppnHLK1NZJMsuZZVXWE/fqHr5gpxt1qmqE807QwazrKRh0X+eQpNZ0
         xIEw==
X-Gm-Message-State: AOJu0YxIbI7kodsmwGgsPsWNtHMoXdao/1V0EK956y+kp8g6YBTE0d0n
        fQqBD4cVHa7FG5vldbLORs/+uz+SAnTK3wAmFULEtvR6p7UzGTtQTv9TH+4kj/Sz9hoAUOrVl4V
        SabeJd7yMsNn77VbZdRvVx/g=
X-Received: by 2002:a17:907:2bca:b0:97d:2bcc:47d5 with SMTP id gv10-20020a1709072bca00b0097d2bcc47d5mr6414190ejc.49.1691335064957;
        Sun, 06 Aug 2023 08:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtapW82Hb1Zd8BBSQHwutyuDtCwq2yQg3/1rQjZzPMqZ9Z/8LbFdyhFBBVmpsYlocZxyvMvg==
X-Received: by 2002:a17:907:2bca:b0:97d:2bcc:47d5 with SMTP id gv10-20020a1709072bca00b0097d2bcc47d5mr6414173ejc.49.1691335064609;
        Sun, 06 Aug 2023 08:17:44 -0700 (PDT)
Received: from redhat.com ([91.242.248.114])
        by smtp.gmail.com with ESMTPSA id bj10-20020a170906b04a00b0099bd6026f45sm4018477ejb.198.2023.08.06.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 08:17:43 -0700 (PDT)
Date:   Sun, 6 Aug 2023 11:10:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        "pankaj.gupta.linux@gmail.com" <pankaj.gupta.linux@gmail.com>,
        "houtao@huaweicloud.com" <houtao@huaweicloud.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>,
        "kch@nvidia.com" <kch@nvidia.com>
Subject: Re: [PATCH v4] virtio_pmem: add the missing REQ_OP_WRITE for flush
 bio
Message-ID: <20230806110854-mutt-send-email-mst@kernel.org>
References: <CAM9Jb+g5rrvmw8xCcwe3REK4x=RymrcqQ8cZavwWoWu7BH+8wA@mail.gmail.com>
 <20230713135413.2946622-1-houtao@huaweicloud.com>
 <CAM9Jb+jjg_By+A2F+HVBsHCMsVz1AEVWbBPtLTRTfOmtFao5hA@mail.gmail.com>
 <47f9753353d07e3beb60b6254632d740682376f9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47f9753353d07e3beb60b6254632d740682376f9.camel@intel.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 04, 2023 at 09:03:20PM +0000, Verma, Vishal L wrote:
> On Fri, 2023-08-04 at 20:39 +0200, Pankaj Gupta wrote:
> > Gentle ping!
> > 
> > Dan, Vishal for suggestion/review on this patch and request for merging.
> > +Cc Michael for awareness, as virtio-pmem device is currently broken.
> 
> Looks good to me,
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> 
> Dave, will you queue this for 6.6.


Generally if you expect me to merge a patch I should be CC'd.


> > 
> > Thanks,
> > Pankaj
> > 
> > > From: Hou Tao <houtao1@huawei.com>
> > > 
> > > When doing mkfs.xfs on a pmem device, the following warning was
> > > reported:
> > > 
> > >  ------------[ cut here ]------------
> > >  WARNING: CPU: 2 PID: 384 at block/blk-core.c:751 submit_bio_noacct
> > >  Modules linked in:
> > >  CPU: 2 PID: 384 Comm: mkfs.xfs Not tainted 6.4.0-rc7+ #154
> > >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> > >  RIP: 0010:submit_bio_noacct+0x340/0x520
> > >  ......
> > >  Call Trace:
> > >   <TASK>
> > >   ? submit_bio_noacct+0xd5/0x520
> > >   submit_bio+0x37/0x60
> > >   async_pmem_flush+0x79/0xa0
> > >   nvdimm_flush+0x17/0x40
> > >   pmem_submit_bio+0x370/0x390
> > >   __submit_bio+0xbc/0x190
> > >   submit_bio_noacct_nocheck+0x14d/0x370
> > >   submit_bio_noacct+0x1ef/0x520
> > >   submit_bio+0x55/0x60
> > >   submit_bio_wait+0x5a/0xc0
> > >   blkdev_issue_flush+0x44/0x60
> > > 
> > > The root cause is that submit_bio_noacct() needs bio_op() is either
> > > WRITE or ZONE_APPEND for flush bio and async_pmem_flush() doesn't assign
> > > REQ_OP_WRITE when allocating flush bio, so submit_bio_noacct just fail
> > > the flush bio.
> > > 
> > > Simply fix it by adding the missing REQ_OP_WRITE for flush bio. And we
> > > could fix the flush order issue and do flush optimization later.
> > > 
> > > Cc: stable@vger.kernel.org # 6.3+
> > > Fixes: b4a6bb3a67aa ("block: add a sanity check for non-write flush/fua bios")
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> > > Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>
> > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > > ---
> > > v4:
> > >  * add stable Cc
> > >  * collect Rvb and Tested-by tags
> > > 
> > > v3: https://lore.kernel.org/linux-block/20230625022633.2753877-1-houtao@huaweicloud.com
> > >  * adjust the overly long lines in both commit message and code
> > > 
> > > v2: https://lore.kernel.org/linux-block/20230621134340.878461-1-houtao@huaweicloud.com
> > >  * do a minimal fix first (Suggested by Christoph)
> > > 
> > > v1: https://lore.kernel.org/linux-block/ZJLpYMC8FgtZ0k2k@infradead.org/T/#t
> > > 
> > >  drivers/nvdimm/nd_virtio.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > > index c6a648fd8744..1f8c667c6f1e 100644
> > > --- a/drivers/nvdimm/nd_virtio.c
> > > +++ b/drivers/nvdimm/nd_virtio.c
> > > @@ -105,7 +105,8 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > >          * parent bio. Otherwise directly call nd_region flush.
> > >          */
> > >         if (bio && bio->bi_iter.bi_sector != -1) {
> > > -               struct bio *child = bio_alloc(bio->bi_bdev, 0, REQ_PREFLUSH,
> > > +               struct bio *child = bio_alloc(bio->bi_bdev, 0,
> > > +                                             REQ_OP_WRITE | REQ_PREFLUSH,
> > >                                               GFP_ATOMIC);
> > > 
> > >                 if (!child)
> > > --
> > > 2.29.2
> > > 
> 

