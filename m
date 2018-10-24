Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Tue, 23 Oct 2018 19:09:23 -0500
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] block: fix rdma queue mapping
Message-ID: <20181024000923.GA17352@ssaleem-MOBL4.amr.corp.intel.com>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
 <20181017163720.GA23798@lst.de>
 <c850626a-5891-fa34-e647-c815f67099da@grimberg.me>
 <00dd01d46ad0$6eb82250$4c2866f0$@opengridcomputing.com>
 <ab0370aa-c488-bfed-675a-b0f84d75a42a@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <ab0370aa-c488-bfed-675a-b0f84d75a42a@grimberg.me>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Steve Wise <swise@opengridcomputing.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 'Max Gurtovoy' <maxg@mellanox.com>, 'Christoph Hellwig' <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 23, 2018 at 03:25:06PM -0600, Sagi Grimberg wrote:
> 
> >>>> Christoph, Sagi:  it seems you think /proc/irq/$IRP/smp_affinity
> >>>> shouldn't be allowed if drivers support managed affinity. Is that correct?
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
> > I'm beginning to think I don't know what "managed affinity" actually is.  Currently iw_cxgb4 doesn't support ib_get_vector_affinity().  I have a patch for it, but ran into this whole issue with nvme failing if someone changes the affinity map via /proc.
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

Sagi - From what I can tell, i40iw is also exposed to this same issue if the IRQ affinity
is configured by user.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
