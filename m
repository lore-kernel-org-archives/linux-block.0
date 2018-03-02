Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1520010446.2693.19.camel@hpe.com>
References: <20180228234006.21093-1-logang@deltatee.com> <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com> <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519936477.4592.23.camel@au1.ibm.com> <1519936815.4592.25.camel@au1.ibm.com>
 <20180301205315.GJ19007@ziepe.ca> <1519942012.4592.31.camel@au1.ibm.com>
 <CA+55aFy-oAiFJ3WDx4giR1enj65y-YJnZZhY6geFw0ygFyKXfQ@mail.gmail.com>
 <1519943658.4592.34.camel@kernel.crashing.org> <1520010446.2693.19.camel@hpe.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Mar 2018 08:57:36 -0800
Message-ID: <CA+55aFztf2D4NwEkRxnJkD6kK62CWKxmERbALMGoMgFEGLEJZA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"jglisse@redhat.com" <jglisse@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "keith.busch@intel.com" <keith.busch@intel.com>,
	"oliveroh@au1.ibm.com" <oliveroh@au1.ibm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 2, 2018 at 8:22 AM, Kani, Toshi <toshi.kani@hpe.com> wrote:
>
> FWIW, this thing is called MTRRs on x86, which are initialized by BIOS.

No.

Or rather, that's simply just another (small) part of it all - and an
architected and documented one at that.

Like the page table caching entries, the memory type range registers
are really just "secondary information". They don't actually select
between PCIe and RAM, they just affect the behavior on top of that.

The really nitty-gritty stuff is not architected, and generally not
documented outside (possibly) the BIOS writer's guide that is not made
public.

Those magical registers contain details like how the DRAM is
interleaved (if it is), what the timings are, where which memory
controller handles which memory range, and what are goes to PCIe etc.

Basically all the actual *steering* information is very much hidden
away from the kernel (and often from the BIOS too). The parts we see
at a higher level are just tuning and tweaks.

Note: the details differ _enormously_ between different chips. The
setup can be very different, with things like Knights Landing having
the external cache that can also act as local memory that isn't a
cache but maps at a different physical address instead etc. That's the
kind of steering I'm talking about - at a low level how physical
addresses get mapped to different cache partitions, memory
controllers, or to the IO system etc.

                  Linus
