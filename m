Return-Path: <linux-block-owner@vger.kernel.org>
Received: from linode.aoot.com ([69.164.194.13]:45486 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbeJXF4Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Oct 2018 01:56:16 -0400
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Sagi Grimberg'" <sagi@grimberg.me>,
        "'Christoph Hellwig'" <hch@lst.de>
Cc: <linux-block@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>,
        "'Max Gurtovoy'" <maxg@mellanox.com>
References: <20180820205420.25908-1-sagi@grimberg.me> <20180822131130.GC28149@lst.de> <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me> <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com> <20181017163720.GA23798@lst.de> <c850626a-5891-fa34-e647-c815f67099da@grimberg.me> <00dd01d46ad0$6eb82250$4c2866f0$@opengridcomputing.com> <ab0370aa-c488-bfed-675a-b0f84d75a42a@grimberg.me>
In-Reply-To: <ab0370aa-c488-bfed-675a-b0f84d75a42a@grimberg.me>
Subject: RE: [PATCH v2] block: fix rdma queue mapping
Date: Tue, 23 Oct 2018 16:31:04 -0500
Message-ID: <030301d46b17$b43132d0$1c939870$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



> -----Original Message-----
> From: Sagi Grimberg <sagi@grimberg.me>
> Sent: Tuesday, October 23, 2018 4:25 PM
> To: Steve Wise <swise@opengridcomputing.com>; 'Christoph Hellwig'
> <hch@lst.de>
> Cc: linux-block@vger.kernel.org; linux-rdma@vger.kernel.org; linux-
> nvme@lists.infradead.org; 'Max Gurtovoy' <maxg@mellanox.com>
> Subject: Re: [PATCH v2] block: fix rdma queue mapping
> 
> 
> >>>> Christoph, Sagi:  it seems you think /proc/irq/$IRP/smp_affinity
> >>>> shouldn't be allowed if drivers support managed affinity. Is that
> correct?
> >>>
> >>> Not just shouldn't, but simply can't.
> >>>
> >>>> But as it stands, things are just plain borked if an rdma driver
> >>>> supports ib_get_vector_affinity() yet the admin changes the affinity via
> >>>> /proc...
> >>>
> >>> I think we need to fix ib_get_vector_affinity to not return anything
> >>> if the device doesn't use managed irq affinity.
> >>
> >> Steve, does iw_cxgb4 use managed affinity?
> >>
> >> I'll send a patch for mlx5 to simply not return anything as managed
> >> affinity is not something that the maintainers want to do.
> >
> > I'm beginning to think I don't know what "managed affinity" actually is.
> Currently iw_cxgb4 doesn't support ib_get_vector_affinity().  I have a patch
> for it, but ran into this whole issue with nvme failing if someone changes the
> affinity map via /proc.
> 
> That means that the pci subsystem gets your vector(s) affinity right and
> immutable. It also guarantees that you have reserved vectors and not get
> a best effort assignment when cpu cores are offlined.
> 
> You can simply enable it by adding PCI_IRQ_AFFINITY to
> pci_alloc_irq_vectors() or call pci_alloc_irq_vectors_affinity()
> to communicate post/pre vectors that don't participate in
> affinitization (nvme uses it for admin queue).
> 
> This way you can easily plug ->get_vector_affinity() to return
> pci_irq_get_affinity(dev, vector)
> 
> The original patch set from hch:
> https://lwn.net/Articles/693653/

Thanks for educating me. 😊  I'll have a look into this. 

Steve.
