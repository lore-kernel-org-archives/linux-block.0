Return-Path: <linux-block-owner@vger.kernel.org>
Received: from linode.aoot.com ([69.164.194.13]:44894 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWVYT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Oct 2018 17:24:19 -0400
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Sagi Grimberg'" <sagi@grimberg.me>,
        "'Christoph Hellwig'" <hch@lst.de>
Cc: <linux-block@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>,
        "'Max Gurtovoy'" <maxg@mellanox.com>
References: <20180820205420.25908-1-sagi@grimberg.me> <20180822131130.GC28149@lst.de> <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me> <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com> <20181017163720.GA23798@lst.de> <c850626a-5891-fa34-e647-c815f67099da@grimberg.me>
In-Reply-To: <c850626a-5891-fa34-e647-c815f67099da@grimberg.me>
Subject: RE: [PATCH v2] block: fix rdma queue mapping
Date: Tue, 23 Oct 2018 08:00:53 -0500
Message-ID: <00dd01d46ad0$6eb82250$4c2866f0$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> >> Christoph, Sagi:  it seems you think /proc/irq/$IRP/smp_affinity
> >> shouldn't be allowed if drivers support managed affinity. Is that correct?
> >
> > Not just shouldn't, but simply can't.
> >
> >> But as it stands, things are just plain borked if an rdma driver
> >> supports ib_get_vector_affinity() yet the admin changes the affinity via
> >> /proc...
> >
> > I think we need to fix ib_get_vector_affinity to not return anything
> > if the device doesn't use managed irq affinity.
> 
> Steve, does iw_cxgb4 use managed affinity?
> 
> I'll send a patch for mlx5 to simply not return anything as managed
> affinity is not something that the maintainers want to do.

I'm beginning to think I don't know what "managed affinity" actually is.  Currently iw_cxgb4 doesn't support ib_get_vector_affinity().  I have a patch for it, but ran into this whole issue with nvme failing if someone changes the affinity map via /proc.

Steve.
